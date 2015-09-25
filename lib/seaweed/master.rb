class Seaweed::Master
  class << self

    def connect(host: "localhost", port: 9333)
      @base_url = "http://#{host}:#{port}"
    end

    def status
      res = Seaweed::HTTP.get "#{@base_url}/cluster/status?pretty=y"
      Seaweed::HTTP.parse res
    end

    def dir_assign!
      res = Seaweed::HTTP.post "#{@base_url}/dir/assign", {}
      Seaweed::HTTP.parse res
    end

    def dir_lookup(volume_id)
      res = Seaweed::HTTP.get "#{@base_url}/dir/lookup?volumeId=#{volume_id}"
      Seaweed::HTTP.parse(res)[:locations][0]
    end

    def vaccum!(threshold: 0.3)
      res = Seaweed::HTTP.get "#{@base_url}/vol/vaccum?garbageThreshold=#{threshold}"
      Seaweed::HTTP.parse res
    end
  end
end
