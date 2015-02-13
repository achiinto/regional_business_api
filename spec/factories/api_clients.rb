FactoryGirl.define do
  factory :api_client do
    daily_api_count 2000
    consumer_key Faker::Lorem.characters(10)
    consumer_secret Faker::Lorem.characters(10)
    api_token Faker::Lorem.characters(10)
    api_token_secret Faker::Lorem.characters(10)
  end
end
