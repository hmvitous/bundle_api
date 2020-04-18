FactoryBot.define do
  factory :event do
    title { 'MyString' }
    description { 'MyString' }
    category { 4 }
    user
    attendee_limit { 30 }
  end
end
