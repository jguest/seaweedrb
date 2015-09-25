module Seaweed

  def self.connect(host: "localhost", port: 9333)
    Seaweed::Master.connect host: host, port: port
  end

  def self.status
    Seaweed::Master.status
  end

  def self.upload(path)
    location = Seaweed::Master.dir_assign!
    file = Seaweed::File.new location[:fid], volume_url: location[:url], attachment: path
    file.upload!
  end

  def self.find(fid)
    location = Seaweed::Master.dir_lookup fid.split(",")[0]
    file = Seaweed::File.new fid, volume_url: location[:url]
  end

  require 'rest-client'
  module Client
    def parse(response)
      if response.code.between?(200, 300)
        return JSON.parse response, symbolize_names: true unless block_given?
        yield
      end
    end
  end
end

require 'seaweed/master'
require 'seaweed/file'
