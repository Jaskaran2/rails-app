require "rails_helper"

RSpec.describe "Creating articles" do
  
    context "when signed in" do
        before{ post '/sign_up',:params => { :user => { :email=> "Jas@gmail.com",:password=>"123456",:password_confirmation=>"123456" } }}
        let!(:no_of_article){Article.count}
        
        it "Redirects to home page when article created" do
            post '/articles', :params => { :article => { :title=> "Test",:body=>"Test article rspec",:status=>"public" } }     
            expect(response).to redirect_to(root_path)
            expect(Article.count).to eq(no_of_article+1)
        end

        it "Renders does not create new article as there was no title" do
             post '/articles', :params => { :article => { :title=> "",:body=>"Test article rspec",:status=>"public" } } 
             expect(response).to render_template(:new)
             expect(Article.count).to eq(no_of_article)
        end
 
         it "Renders create new article as there was no body" do
             post '/articles', :params => { :article => { :title=> "My article",:body=>"",:status=>"public" } } 
             expect(response).to render_template(:new)
             expect(Article.count).to eq(no_of_article)
        end
 
         it "Renders create new article as body length  < 10" do
             post '/articles', :params => { :article => { :title=> "My article",:body=>"Hi",:status=>"public" } }
             expect(response).to render_template(:new)
             expect(Article.count).to eq(no_of_article)
        end
    end

    
    context "User is not signed in" do
        it "Redirect to sign in path as no user is present" do
            redirect_to(sign_in_path)
        end
    end
end