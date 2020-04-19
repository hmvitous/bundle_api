FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    email { generate :email }
    password { "MyString" }
    password_confirmation { "MyString" }
  end
end
