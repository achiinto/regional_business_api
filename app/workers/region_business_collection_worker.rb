class RegionBusinessCollectionWorker
  include Sidekiq::Worker

  def perform(region_id, client_ids)
    region = Region.find_by(id: region_id)
    RegionBusinessCollectionService.new(region, client_ids).collect! if region
  end
end
