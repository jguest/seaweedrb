class Seaweed::Master
  extend Seaweed::Client
  class << self

    def connect(host: "localhost", port: 9333)
      @host = host
      @port = port
      @base_url = "http://#{@host}:#{@port}"
    end

    def status
      RestClient.get "#{@base_url}/cluster/status?pretty=y"
    end

    def dir_assign!
      parse RestClient.post "#{@base_url}/dir/assign", {}
    end

    def dir_lookup(volume_id)
      data = parse RestClient.get("#{@base_url}/dir/lookup?volumeId=#{volume_id}")
      data[:locations][0]
    end

    def vaccum!(threshold: 0.3)
      parse RestClient.get "#{@base_url}/vol/vaccum?garbageThreshold=#{threshold}"
    end
  end
end
