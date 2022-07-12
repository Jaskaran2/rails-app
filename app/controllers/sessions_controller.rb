class SessionsController<ApplicationController
    def new

    end

    def create
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

end