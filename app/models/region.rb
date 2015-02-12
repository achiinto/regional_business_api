class Region < ActiveRecord::Base

  def fetch_businesses
    locale = { lang: 'en' }
    bounding_box = { sw_latitude: current_sw_latitude,
                    sw_longitude: current_sw_longitude,
                    ne_latitude: current_ne_latitude,
                    ne_longitude: current_ne_longitude }
    yelp_client.search_by_bounding_box(bounding_box, {}, locale)
  end

  def yelp_client
    @client ||= Yelp::Client.new({ consumer_key: api_consumer_key,
                            consumer_secret: api_consumer_secret,
                            token: api_token,
                            token_secret: api_token_secret
                          })
  end
end
