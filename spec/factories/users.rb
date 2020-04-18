FactoryBot.define do
  factory :user do
    email { "user@mail.com" }
    password { "MyString" }
    password_confirmation { "MyString" }
  end
end
