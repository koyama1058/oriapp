FactoryBot.define do
  factory :user do
    nickname                { "テスト" }
    email                   { "test@com" }
    password                { "123456" }
    password_confirmation   { "123456" }
  end
end
