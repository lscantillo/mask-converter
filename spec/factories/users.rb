FactoryBot.define do
  factory :user do
    username { Faker::Internet.username(specifier: 5..8) }
    salt { Faker::Lorem.characters(number: 10) }
    password { Faker::Internet.password(min_length: 6, max_length: 16) }
    password_confirmation { password }
    role { "viewer" }
  end
end
