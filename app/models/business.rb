class Business < ActiveRecord::Base
  def api_business=(api_business)
    self.resource_id = api_business.id
    self.name = api_business.name
    self.image_url = api_business.image_url rescue ""
    self.url = api_business.url
    self.phone = api_business.phone rescue ""
    self.review_count = api_business.review_count
    self.categories = api_business.categories.flatten
    self.display_address = api_business.location.display_address.join(", ")
    self.is_closed = api_business.is_closed
    self.latitude = api_business.location.coordinate.latitude
    self.longitude = api_business.location.coordinate.longitude
  end
end
