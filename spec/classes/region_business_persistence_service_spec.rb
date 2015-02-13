require 'rails_helper'

RSpec.describe RegionBusinessPersistenceService, type: :class do
  let(:subject) { RegionBusinessPersistenceService.new(api_business) }
  let(:business) { build_stubbed(:business) }
  let(:api_result) { BurstStruct::Burst.new(JSON.parse(fixture("yelp/search.json").read)) }
  let(:api_business) { api_result.businesses.first }

  describe "initialize" do
    it "instantiates a persistence service with api business data" do
      expect(subject.instance_variable_get(:@api_business)).to eq api_business
    end
  end

  describe "persist!" do
    before(:each) do
      allow(Business).to receive(:find_or_initialize_by).and_return(business)
      allow(business).to receive(:api_business=)
      allow(business).to receive(:save!).and_return(true)
    end

    it "finds or intializes a business given resource id" do
      expect(Business).to receive(:find_or_initialize_by).with(resource_id: api_business.id)
      subject.persist!
    end

    context "with business object located" do
      it "assigns attributes with api result" do
        expect(business).to receive(:api_business=).with(api_business)
        subject.persist!
      end
    end

    it "performs a save to the business" do
      expect(business).to receive(:save!)
      subject.persist!
    end
  end
end
