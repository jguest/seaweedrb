module Seaweed

  def self.connect(host: "localhost", port: 9333, http_options: {})
    Seaweed::HTTP.configure http_options
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

  def self.find(fid, http_options: nil)
    location = Seaweed::Master.dir_lookup fid.split(",")[0]
    Seaweed::File.new fid, volume_url: location[:url]
  end
end

require 'seaweed/http'
require 'seaweed/master'
require 'seaweed/file'
