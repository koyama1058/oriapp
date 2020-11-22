FactoryBot.define do
  factory :user do
    nickname                { "テスト" }
    email                 {Faker::Internet.free_email}
    password                { "123456" }
    password_confirmation   { "123456" }
    gender_id               {2}
    job_id                  {2}
    prefectures_id          {2}
  end
end
