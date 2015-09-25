class Seaweed::Master
  class << self

    # supply seaweed-fs master connection info
    #
    # @param String host
    # @param String port

    def connect(host: "localhost", port: 9333)
      @base_url = "http://#{host}:#{port}"
    end

    # get the system status
    # https://github.com/chrislusf/seaweedfs/wiki/API#check-system-status
    #
    # @return Hash

    def status
      res = Seaweed::HTTP.get "#{@base_url}/cluster/status?pretty=y"
      Seaweed::HTTP.parse res
    end

    # assign a key file
    # https://github.com/chrislusf/seaweedfs/wiki/API#assign-a-file-key
    #
    # @return Hash

    def dir_assign!
      res = Seaweed::HTTP.post "#{@base_url}/dir/assign", {}
      Seaweed::HTTP.parse res
    end

    # lookup a volume
    # https://github.com/chrislusf/seaweedfs/wiki/API#lookup-volume
    #
    # @param String volume_id
    # @return Hash

    def dir_lookup(volume_id)
      res = Seaweed::HTTP.get "#{@base_url}/dir/lookup?volumeId=#{volume_id}"
      Seaweed::HTTP.parse(res)[:locations][0]
    end

    # force garbage collection
    # https://github.com/chrislusf/seaweedfs/wiki/API#force-garbage-collection
    #
    # @param Float threshold

    def vaccum!(threshold: 0.3)
      res = Seaweed::HTTP.get "#{@base_url}/vol/vaccum?garbageThreshold=#{threshold}"
      Seaweed::HTTP.parse res
    end
  end
end
