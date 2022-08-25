require "rails_helper"

RSpec.describe User do
    describe 'validate email' do
        it 'validates presence' do
            user=User.new
            user.email=""
            user.validate
            expect(user.errors[:email]).to include("can't be blank")
        end

        it "validates format" do
            user=User.new
            user.email="hello"
            user.validate
            expect(user.errors[:email]).to include("must be a valid email address")
        end

        it "validates is email is already present" do
            should validate_presence_of(:email)
        end
    end

    describe "validates passsword length" do
        it "validates password length" do 
            user=User.new
            user.password="123"
            user.validate
            expect(user.errors[:password].size).to eq(1)
        end
    end
end
