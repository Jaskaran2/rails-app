require "rails_helper"

RSpec.describe "Create user",type: :request do
    context "User created" do
        it "Redirects to home page after user created" do
            post sign_up_path ,:params => { :user => { :email=> "Jas@gmail.com",:password=>"123456",:password_confirmation=>"123456" } }
            expect(subject).to redirect_to(root_path)   
        end
    end

    context "Cannot create user" do
        it "renders new as password does not match confirm password" do
            post sign_up_path, :params => { :user => { :email=> "Jas@gmail.com",:password=>"123456",:password_confirmation=>"123455" } }                
            expect(response).to render_template(:new) 
        end

        
        it "renders new as invalid email format" do
            post sign_up_path, :params => { :user => { :email=> "Jas",:password=>"123456",:password_confirmation=>"123456" } } 
            expect(response).to render_template(:new) 
        end
    end
end