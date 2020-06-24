FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name { 'Doe' }
    email { 'user@example.com' }
    password { '123456' }
    password_confirmation { '123456' }
  end
end
