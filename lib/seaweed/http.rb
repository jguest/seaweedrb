require 'rest-client'
require 'json'
require 'forwardable'

class Seaweed::HTTP
  class << self
    extend Forwardable

    def_delegators :@http, :get, :put, :post, :delete

    # inject your own rest client or json parser
    #
    # @param RestClient http
    # @param JSON json

    def configure(http: RestClient, json: JSON)
      @http = http
      @json = json
    end

    # JSON parse with default symbolized keys
    #
    # @param String json
    # @return Hash

    def parse(json)
      @json.parse json, symbolize_names: true
    end
  end
end
