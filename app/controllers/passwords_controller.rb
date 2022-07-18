class PasswordsController<ApplicationController
   before_action :require_user_logged_in!
   
    def edit
    end

    def update
     user=User.find_by(email: Current.user.email)
       if user.authenticate(params[:current_password]) and Current.user.update(password_params)
          redirect_to root_path,notice:"Password Updated Successfully"
       else
          render :edit
       end
    end

    private
    def password_params
        params.require(:user).permit(:password, :password_confirmation)
    end
end
