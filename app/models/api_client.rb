class ApiClient < ActiveRecord::Base
  API_DAILY_LIMIT_THRESHOLD = 200

  scope :active, -> { where("daily_api_count > ?", API_DAILY_LIMIT_THRESHOLD) }

  def self.active_client(client_ids)
    self.where(id: client_ids).active.sample
  end

  def fetch_businesses_in(region)
    params = { offset: region.current_index }
    locale = { lang: 'en' }
    api_result = api_connection.search_by_bounding_box(region.search_bounding_box, params, locale)
    update_attribute(:daily_api_count, daily_api_count - 1)
    api_result
  end

  def api_connection
    @api_connection ||= Yelp::Client.new({ consumer_key: consumer_key,
                            consumer_secret: consumer_secret,
                            token: api_token,
                            token_secret: api_token_secret
                          })
  end
end
