require 'rails_helper'

RSpec.describe Business, type: :model do
  let(:subject) { build_stubbed(:business) }
  let(:new_subject) { Business.new }
  let(:api_result) { BurstStruct::Burst.new(JSON.parse(fixture("yelp/search.json").read)) }

  describe "api_business=" do
    context "with business api data is given" do
      it "assigns business api data to the business instance" do
        api_business_data = api_result.businesses.first
        new_subject.api_business = api_business_data
        expect(new_subject.resource_id).to eq "yelp_#{api_business_data.id}"
        expect(new_subject.name).to eq api_business_data.name
        expect(new_subject.image_url).to eq api_business_data.image_url
        expect(new_subject.url).to eq api_business_data.url
        expect(new_subject.phone).to eq api_business_data.phone
        expect(new_subject.review_count).to eq api_business_data.review_count
        expect(new_subject.categories).to eq api_business_data.categories.flatten
        expect(new_subject.display_address).to eq api_business_data.location.display_address.join(", ")
        expect(new_subject.is_closed).to eq api_business_data.is_closed
        expect(new_subject.latitude).to eq api_business_data.location.coordinate.latitude
        expect(new_subject.longitude).to eq api_business_data.location.coordinate.longitude
      end
    end
  end
end
