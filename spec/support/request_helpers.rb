module Requests
  module JsonHelpers
    def response_json
      @_json ||= JSON.parse(response.body).with_indifferent_access
    end
  end
end
