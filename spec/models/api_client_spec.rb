require 'rails_helper'

RSpec.describe ApiClient, type: :model do
  let(:subject) { build_stubbed(:api_client) }
  let(:region) { build_stubbed(:region) }
  let(:api_client) { Yelp::Client.new }
  let(:bounding_box_hash) { 
        Hash.new(sw_latitude: Faker::Number.number(7), sw_longitude: Faker::Number.number(7),
                 ne_latitude: Faker::Number.number(7), ne_longitude: Faker::Number.number(7))
      }
  let(:api_result) { BurstStruct::Burst.new(JSON.parse(fixture("yelp/search.json").read)) }


  describe "active scope" do
    it "queries for clients with daily api count more than the daily limit threshold" do
      where_clause = "(daily_api_count > #{ApiClient::API_DAILY_LIMIT_THRESHOLD})"
      query = "SELECT \"api_clients\".* FROM \"api_clients\" WHERE #{where_clause}"
      expect(described_class.active.to_sql).to eq query
    end
  end

  describe "active_client" do
    it "queries database for the given client ids for active clients and sample for one" do
      result = double
      allow(described_class).to receive(:where).with(id: [1,2,3]).and_return(result)
      expect(result).to receive_message_chain(:active, :sample)
      described_class.active_client([1,2,3])
    end
  end

  describe "fetch_businesses_in" do
    before(:each) do
      allow(region).to receive(:search_bounding_box).and_return(bounding_box_hash)
      allow(subject).to receive(:api_connection).and_return(api_client)
      allow(api_client).to receive(:search_by_bounding_box).and_return(api_result)
      allow(subject).to receive(:update_attribute)
    end

    it "makes a search by bounding box and index defined by Region" do
      params = { offset: region.current_index }
      locale = { lang: 'en' }
      expect(api_client).to receive(:search_by_bounding_box).with(bounding_box_hash, params, locale)
      expect(subject.fetch_businesses_in(region)).to eq api_result
    end

    it "updates the daily api count" do
      expect(subject).to receive(:update_attribute).with(:daily_api_count, subject.daily_api_count - 1)
      subject.fetch_businesses_in(region)
    end
  end

  describe "api_connection" do
    it "returns a Yelp::Client instance with proper key and secret" do
      connection = subject.api_connection
      configuration = connection.instance_variable_get(:@configuration)
      expect(connection.class).to eq Yelp::Client
      expect(configuration.instance_variable_get(:@consumer_key)).to eq subject.consumer_key
      expect(configuration.instance_variable_get(:@consumer_secret)).to eq subject.consumer_secret
      expect(configuration.instance_variable_get(:@token)).to eq subject.api_token
      expect(configuration.instance_variable_get(:@token_secret)).to eq subject.api_token_secret
    end
  end
end
