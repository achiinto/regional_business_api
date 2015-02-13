FactoryGirl.define do
  factory :region do
    name Faker::Name.name
    sw_latitude Faker::Number.number(7)
    sw_longitude Faker::Number.number(7)
    ne_latitude Faker::Number.number(7)
    ne_longitude Faker::Number.number(7)
    current_index Faker::Number.number(1)
    source_type "Yelp"
  end
end
