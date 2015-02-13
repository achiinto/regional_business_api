class Region < ActiveRecord::Base
  YELP_REGION_SEARCH_PAGE_SIZE = 20

  def search_bounding_box
    { 
      sw_latitude: sw_latitude,
      sw_longitude: sw_longitude,
      ne_latitude: ne_latitude,
      ne_longitude: ne_longitude
    }
  end

  def update_current_index(api_result_count)
    return update_attribute(:current_index, 0) if api_result_count < YELP_REGION_SEARCH_PAGE_SIZE
    update_attribute(:current_index, current_index + api_result_count)
  end
end
