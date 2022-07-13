class RegistrationsController < ApplicationController
    def new
        @user=User.new
    end

    def create
        @user=User.new(user_params)
        if @user.save
            session[:user_id]=@user.id
            redirect_to root_path,notice: "Account created successfully"
        else
            render :new
        end
    end

    def newuser

    end

    def createuser
        user=User.find_by(email: params[:email])
        if user.present? and user.authenticate(params[:password])
            session[:user_id]=user.id
            redirect_to root_path,notice: "Logged in successfully"
        else
            puts "Invalid email or password"
            flash[:alert]="Invalid email or passowrd"
            render :new
        end
    end
 
 
 
    def destroy
        session[:user_id]=nil
        redirect_to root_path,notice:"Logged out"
    end

    private

    def user_params
        params.require(:user).permit(:email,:password,:password_confirmation)
    end

end