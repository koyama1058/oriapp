FactoryBot.define do
  factory :message do
    image           {"image.png"}
    text           {"チャットメッセージテスト"}
    association               :user
    association               :post
    after(:build) do |culture|
      culture.image.attach(io: File.open(Rails.root.join('spec', 'factories', 'images', 'sample.jpg')), filename: 'sample.jpg', content_type: 'image/jpg')
    end
  end
end
