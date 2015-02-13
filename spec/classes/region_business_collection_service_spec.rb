require 'rails_helper'

RSpec.describe RegionBusinessCollectionService, type: :class do
  let(:subject) { RegionBusinessCollectionService.new(region, [1]) }
  let(:region_business_persistence_service) { RegionBusinessPersistenceService.new(api_result.businesses.first) }
  let(:api_client) { build_stubbed(:api_client) }
  let(:region) { build_stubbed(:region) }
  let(:api_result) { BurstStruct::Burst.new(JSON.parse(fixture("yelp/search.json").read)) }

  before(:each) do
    allow(ApiClient).to receive(:active_client).and_return(api_client)
  end

  describe "initialize" do
    it "instantiates a collection service with api client for a region" do
      expect(subject.instance_variable_get(:@api_client)).to eq api_client
      expect(subject.instance_variable_get(:@region)).to eq region
    end
  end

  describe "collect!" do
    before(:each) do
      allow(api_client).to receive(:fetch_businesses_in).and_return(api_result)
      allow(RegionBusinessPersistenceService).to receive(:new).and_return(region_business_persistence_service)
      allow(region_business_persistence_service).to receive(:persist!)
      allow(region).to receive(:update_current_index)
    end

    it "fetches businesses data through api client" do
      expect(api_client).to receive(:fetch_businesses_in).with(region)
      subject.collect!
    end

    context "with api data of businesses" do
      it "persists the businesses data" do
        expect(region_business_persistence_service).to receive(:persist!).once
        subject.collect!
      end
    end

    it "updates the current index of the region" do
      expect(region).to receive(:update_current_index)
      subject.collect!
    end
  end
end
