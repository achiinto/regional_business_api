require 'rails_helper'

RSpec.describe Region, type: :model do
  let(:subject) { build_stubbed(:region) }

  describe "search_bounding_box" do
    it "returns a hash of coordinates that define a box in geolocation" do
      bounding_box_hash = { sw_latitude: subject.sw_latitude, sw_longitude: subject.sw_longitude,
                            ne_latitude: subject.ne_latitude, ne_longitude: subject.ne_longitude }
      expect(subject.search_bounding_box).to eq bounding_box_hash
    end
  end

  describe "update_current_index" do
    context "with api result count less than the page size" do
      it "updates current index to zero" do
        expect(subject).to receive(:update_attribute).with(:current_index, 0)
        subject.update_current_index(Region::YELP_REGION_SEARCH_PAGE_SIZE - 1)
      end
    end

    context "with api result count equal to the page size" do
      it "updates the current index by adding the api result count" do
        subject.current_index = 11
        expect(subject).to receive(:update_attribute).with(:current_index, 11 + Region::YELP_REGION_SEARCH_PAGE_SIZE)
        subject.update_current_index(Region::YELP_REGION_SEARCH_PAGE_SIZE)
      end
    end
  end
end
