require "rails_helper"


RSpec.feature "Create user",type: :feature do
    
    feature "successful user creation" do

        scenario "User gets created" do
            visit('/sign_up')
            fill_in 'Email',with: 'Wgmail@gmail.com'
            fill_in 'Password',with: '123456'
            fill_in 'confirm_password',with: '123456'
            click_button 'Create User'
            expect(page).to have_content 'Account created successfully'
        end

        after{User.delete_by(email:"Wgmail@gmail.com")}

    end

    feature "Unsuccessful user creation" do

        before{User.create(email:"Test432@gmail.com",password:"123456",password_confirmation:"123456")}
        
        scenario "User does not get created due to invalid mail" do
            visit('/sign_up')
            fill_in 'Email',with: 'Test432gmail.com'
            fill_in 'Password',with: '123456'
            fill_in 'confirm_password',with: '123456'
            click_button 'Create User'
            expect(page).to have_content 'Email must be a valid email address'
        end

        scenario "User does not get created as email is taken" do
            visit('/sign_up')
            fill_in 'Email',with: 'Test432@gmail.com'
            fill_in 'Password',with: '123456'
            fill_in 'confirm_password',with: '123456'
            click_button 'Create User'
            expect(page).to have_content 'Email has already been taken'
        end


        scenario "User does not get created as password confirmation dosent match" do
            visit('/sign_up')
            fill_in 'Email',with: 'Test4321@hotmail.com'
            fill_in 'Password',with: '123455'
            fill_in 'confirm_password',with: '123456'
            click_button 'Create User'
            expect(page).to have_content 'Password confirmation doesn\'t match Password'
        end

        scenario "User does not get created as password < 6" do
            visit('/sign_up')
            fill_in 'Email',with: 'Test4321@hotmail.com'
            fill_in 'Password',with: '1234'
            fill_in 'confirm_password',with: '1234'
            click_button 'Create User'
            expect(page).to have_content 'Password is too short (minimum is 6 characters)'
        end 
        after{User.delete_by(email:"Test432@gmail.com")}
    end
end