class Seaweed::File
  include Seaweed::Client

  attr_reader :id, :name, :volume_id, :volume_url, :attachment, :size

  def initialize(fid, volume_url: nil, attachment: nil)
    @id = fid
    @volume_id, @key, @cookie = fid.match(/^(\d),(\w\w)(\w+)$/).captures
    @volume_url = volume_url
    @attachment = attachment
  end

  def upload!
    response = parse RestClient.put(url, file: File.new(@attachment, 'rb'))
    @name = response[:name]
    @size = response[:size]
    self
  end

  def delete!
    response = parse RestClient.delete(url)
    !response[:size].nil?
  end

  def read
    RestClient.get url
  end

  def url
    "#{@volume_url}/#{@id}"
  end

  def pretty_url
    "#{@volume_url}/#{@volume_id}/#{@key}#{@cookie}/#{@name}"
  end
end
