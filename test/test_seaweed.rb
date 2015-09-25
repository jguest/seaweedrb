require 'minitest/autorun'
require 'seaweed'

class TestSeaweed < Minitest::Test

  def test_status
    Seaweed.connect
    status = Seaweed.status
    assert_equal false, status.nil?
  end

  def test_low_level_upload
    Seaweed::Master.connect
    location = Seaweed::Master.dir_assign!
    file = Seaweed::File.new location[:fid], \
      volume_url: location[:url],
      attachment: File.expand_path("../fixtures/test.txt", __FILE__)
    file.upload!
  end

  def test_as_resource
    Seaweed.connect
    file = Seaweed.upload File.expand_path("../fixtures/test.txt", __FILE__)
    id = file.id
    file1 = Seaweed.find id
    assert_equal "hello world!", file1.read.strip
    assert_equal true, file1.delete!
  end
end
