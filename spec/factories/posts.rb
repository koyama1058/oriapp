FactoryBot.define do
  factory :post do
    image           { 'image.png' }
    title           { Faker::Lorem.sentence }
    category_id     { 3 }
    description     { Faker::Lorem.sentence }
    day_time        { Faker::Lorem.sentence }
    prefectures_id  { 3 }
    place           { Faker::Lorem.sentence }
    budget          { Faker::Lorem.sentence }
    association :user
    after(:build) do |culture|
      culture.image.attach(io: File.open(Rails.root.join('spec', 'factories', 'images', 'sample.jpg')), filename: 'sample.jpg', content_type: 'image/jpg')
    end
  end
end
