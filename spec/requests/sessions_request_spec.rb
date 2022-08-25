require "rails_helper"

RSpec.describe "User login", type: :request do
   
        
    user=User.create(email:"test@gmail.com",password:"123456",password_confirmation:"123456")

    context "Valid user" do
        it "User is able to login" do
            post sign_in_path, :params => {:email=> "test@gmail.com",:password=>"123456"}
            expect(response).to redirect_to(root_path) 
        end
    end

    context "Invalid user" do  
        it "User is unable to login due to incorrect password" do
            post sign_in_path, :params => {:email=> "test@gmail.com",:password=>"123455"}
            expect(response).to render_template(:new)
        end

        it "User is unable to login due to unregistered mail" do
            post sign_in_path, :params => {:email=> "failmail@gmail.com",:password=>"123456"}
            expect(subject).to render_template(:new) 
        end
    end
end