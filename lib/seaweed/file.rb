class Seaweed::File

  # a seaweed-fs file object
  #
  # String id
  # String name
  # String volume_id
  # String attachement
  # String size

  attr_reader :id, :name, :volume_id, :volume_url, :attachment, :size

  # create a new file
  #
  # @param String fid
  # @param String volume_url
  # @param String attachment
  # @return self

  def initialize(fid, volume_url: nil, attachment: nil)
    @id = fid
    @volume_id, @key, @cookie = fid.match(/^(\d),(\w\w)(\w+)$/).captures
    @volume_url = volume_url
    @attachment = attachment
  end

  # upload the file attachment
  # @return self

  def upload!
    response = Seaweed::HTTP.put url, file: File.new(@attachment, 'rb')
    data = Seaweed::HTTP.parse response
    @name = data[:name]
    @size = data[:size]
    self
  end

  # delete the uploaded file
  # @return Boolean

  def delete!
    res = Seaweed::HTTP.delete url
    !(Seaweed::HTTP.parse(res)[:size].nil?)
  end

  # read the uploaded file contents
  # @return String

  def read
    Seaweed::HTTP.get url
  end

  # the file's short url in the volume server
  # @return String

  def url
    "#{@volume_url}/#{@id}"
  end

  # the file's most verbose url in the volume server
  # @return String

  def pretty_url
    "#{@volume_url}/#{@volume_id}/#{@key}#{@cookie}/#{@name}"
  end
end
