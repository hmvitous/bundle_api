FactoryBot.define do
  factory :user do
    email {|n| "user_#{n}@mail.com" }
    password { "MyString" }
    password_confirmation { "MyString" }
  end
end
