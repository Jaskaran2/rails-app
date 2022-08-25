require "rails_helper"

RSpec.feature "Create articles",type: :feature do

    feature "User is signed in" do

        before do
            user = User.create(email:"JackRayan123@hotmail.com",password:"123456",password_confirmation:"123456")
            visit "/sign_in"
            fill_in 'Email',with: 'JackRayan123@hotmail.com'
            fill_in 'Password',with: '123456'
            click_button 'Sign_in'
            expect(page).to have_content 'Logged in successfully'
        end

        scenario "Article gets created" do
            visit('/')
            click_link 'add_new_article'
            visit('/articles/new')
            expect(page).to have_content 'New Article'
            fill_in 'title',with:"My New article"
            fill_in 'body',with:"Test artice length>10"
            click_button 'create_article'
            expect(page).to have_content 'Post created'
        end

        scenario "Article does not get created as body<10 characters" do
            visit('/')
            click_link 'add_new_article'
            visit('/articles/new')
            expect(page).to have_content 'New Article'
            fill_in 'title',with:"My New article"
            fill_in 'body',with:"Test"
            click_button 'create_article'
            expect(page).to have_content 'Body is too short (minimum is 10 characters)'
        end

        scenario "Article does not get created as title is blank" do
            visit('/')
            click_link 'add_new_article'
            visit('/articles/new')
            expect(page).to have_content 'New Article'
            fill_in 'title',with:""
            fill_in 'body',with:"Test it has more than 10 characters"
            click_button 'create_article'
            expect(page).to have_content "Title can't be blank"
        end

        scenario "Article does not get created as body is blank" do
            visit('/')
            click_link 'add_new_article'
            visit('/articles/new')
            expect(page).to have_content 'New Article'
            fill_in 'title',with:""
            fill_in 'body',with:""
            click_button 'create_article'
            expect(page).to have_content "Title can't be blank"
            expect(page).to have_content "Body can't be blank"
        end
    end
end
