FactoryBot.define do
  factory :post do
    image           {"image.png"}
    title           {"テスト"}
    category_id     {3}
    description     {"詳細テスト"}
    day_time        {"1994.08.02"}
    prefectures_id  {3}
    place           {"場所テスト"}
    budget          {"予算テスト"}
    association               :user
    after(:build) do |culture|
      culture.image.attach(io: File.open(Rails.root.join('spec', 'factories', 'images', 'sample.jpg')), filename: 'sample.jpg', content_type: 'image/jpg')
    end
  end
end