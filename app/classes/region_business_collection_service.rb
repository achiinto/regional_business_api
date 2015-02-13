class RegionBusinessCollectionService
  def initialize(region, client_ids)
    @region = region
    @api_client = ApiClient.active_client(client_ids)
  end

  def collect!
    api_result = @api_client.fetch_businesses_in(@region)
    api_businesses = api_result.businesses
    api_businesses.each do |api_business|
      RegionBusinessPersistenceService.new(api_business).persist!
    end
    @region.update_current_index(api_businesses.count)
  end
end
