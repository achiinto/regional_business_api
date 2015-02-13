class RegionBusinessPersistenceService
  def initialize(api_business)
    @api_business = api_business
  end

  def persist!
    business = Business.find_or_initialize_by(resource_id: @api_business.id)
    business.api_business = @api_business
    business.save!
  end
end
