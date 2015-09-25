require 'rest-client'
require 'json'
require 'forwardable'

class Seaweed::HTTP
  class << self
    extend Forwardable

    def configure(http: RestClient, json: JSON)
      @http = http
      @json = json
    end

    def parse(json)
      @json.parse json, symbolize_names: true
    end

    def_delegators :@http, :get, :put, :post, :delete
  end
end
