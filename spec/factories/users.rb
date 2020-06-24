FactoryBot.define do
  factory :user, class: User do
    first_name { 'John' }
    last_name { 'Doe' }
    email { 'user1@example.com' }
    password { '123456' }
    password_confirmation { '123456' }
  end

  factory :user2, class: User do
    first_name { 'Jane' }
    last_name { 'Doe' }
    email { 'user2@example.com' }
    password { '123456' }
    password_confirmation { '123456' }
  end
end
