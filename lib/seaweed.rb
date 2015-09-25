module Seaweed

  # supply seaweed-fs master connection info
  #
  # @param String host
  # @param String port
  # @param Hash http_options

  def self.connect(host: "localhost", port: 9333, http_options: {})
    Seaweed::HTTP.configure http_options
    Seaweed::Master.connect host: host, port: port
  end

  # get the system status
  # https://github.com/chrislusf/seaweedfs/wiki/API#check-system-status
  #
  # @return Hash

  def self.status
    Seaweed::Master.status
  end

  # upload a new file
  # https://github.com/chrislusf/seaweedfs/wiki/API#upload-file
  #
  # @param String path
  # @return Seaweed::File

  def self.upload(path)
    location = Seaweed::Master.dir_assign!
    file = Seaweed::File.new location[:fid], volume_url: location[:url], attachment: path
    file.upload!
  end

  # find a file by file id
  # https://github.com/chrislusf/seaweedfs/wiki/API#lookup-volume
  #
  # @param String fid
  # @return Seaweed::File

  def self.find(fid)
    location = Seaweed::Master.dir_lookup fid.split(",")[0]
    Seaweed::File.new fid, volume_url: location[:url]
  end
end

require 'seaweed/http'
require 'seaweed/master'
require 'seaweed/file'
