class Seaweed::File

  attr_reader :id, :name, :volume_id, :volume_url, :attachment, :size

  def initialize(fid, volume_url: nil, attachment: nil)
    @id = fid
    @volume_id, @key, @cookie = fid.match(/^(\d),(\w\w)(\w+)$/).captures
    @volume_url = volume_url
    @attachment = attachment
  end

  def upload!
    response = Seaweed::HTTP.put url, file: File.new(@attachment, 'rb')
    data = Seaweed::HTTP.parse response
    @name = data[:name]
    @size = data[:size]
    self
  end

  def delete!
    res = Seaweed::HTTP.delete url
    !(Seaweed::HTTP.parse(res)[:size].nil?)
  end

  def read
    Seaweed::HTTP.get url
  end

  def url
    "#{@volume_url}/#{@id}"
  end

  def pretty_url
    "#{@volume_url}/#{@volume_id}/#{@key}#{@cookie}/#{@name}"
  end
end
