class PasswordResetsController<ApplicationController
    def new
    end

    def create
        @user=User.find_by(email: params[:email])

        if @user.present?
            PasswordMailer.with(user: @user).reset.deliver_now
            redirect_to root_path,notice:"We have sent a link to your account to reset password"
        else
            redirect_to root_path,notice:"We have sent a link to your account to reset password"
        end
    end

    def edit
        @user=User.find_signed!(params[:token],purpose:"password_reset")
    rescue ActiveSupport::MessageVerifier::InvalidSignature
        redirect_to sign_in_path,alert:"Your Token has expired"
    end

    def update
        @user=User.find_signed!(params[:token],purpose:"password_reset")
        if @user.update(password_params)
            redirect_to sign_in_path,notice: "Password Updated Successfully"
        else
            render :edit
        end
    end

    private
    def password_params
        params.require(:user).permit(:password,:password_confirmation)
    end
end
