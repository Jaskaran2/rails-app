require "rails_helper"

RSpec.feature "Login user",type: :feature do
    before{User.create(email:"Jack123@hotmail.com",password:"123456",password_confirmation:"123456")}
    
    feature "successful login" do
        scenario "User logins successfully" do
            visit('/sign_in')
            fill_in 'Email',with: 'Jack123@hotmail.com'
            fill_in 'Password',with: '123456'
            click_button 'Sign_in'
            expect(page).to have_content 'Logged in successfully'
        end
    end

    feature "Unsuccessful login" do
        scenario "User cannot login due to invalid mail" do
            visit('/sign_in')
            fill_in 'Email',with: 'Test43@hotmail.com'
            fill_in 'Password',with: '123456'
            click_button 'Sign_in'
            expect(page).to have_content 'Invalid email or password'
        end

        scenario "User  cannot login due to invalid password" do
            visit('/sign_in')
            fill_in 'Email',with: 'Jack123@hotmail.com'
            fill_in 'Password',with: '123455'
            click_button 'Sign_in'
            expect(page).to have_content 'Invalid email or password'
        end
    end
    after{User.delete_by(email:"Jack123@hotmail.com")}
end