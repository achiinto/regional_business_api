FactoryGirl.define do
  factory :business do
    resource_id Faker::Company.name
    name Faker::Company.name
    image_url Faker::Company.logo
    url Faker::Internet.url
    phone Faker::PhoneNumber.phone_number
    review_count Faker::Number.digit
    categories [Faker::Name.name, Faker::Name.name]
    display_address Faker::Address.street_address
    is_closed false
    latitude Faker::Address.latitude
    longitude Faker::Address.longitude
  end
end
