FactoryBot.define do
  factory :user do
    nickname                { "テスト" }
    email                 {Faker::Internet.free_email}
    password                { "123456" }
    password_confirmation   { "123456" }
  end
end
