require 'minitest/autorun'
require 'seaweed'

class TestSeaweed < Minitest::Test

  def setup!
    @mock_rest_client = MiniTest::Mock.new
    @mock_json_parser = MiniTest::Mock.new
    @mock_response = MiniTest::Mock.new

    (1..10).each do
      @mock_rest_client.expect :get, @mock_response, [String]
      @mock_rest_client.expect :put, @mock_response, [String, Hash]
      @mock_rest_client.expect :post, @mock_response, [String, Hash]
      @mock_rest_client.expect :delete, @mock_response, [String]

      @mock_response.expect :code, 200
      @mock_response.expect :strip, "hello world!"
      @mock_response.expect :nil?, false
      @mock_json_parser.expect :parse, {
        fid: "3,01637037d6",
        publicUrl: "localhost:8080",
        url: "localhost:8080",
        name: "test.txt",
        size: 37,
        locations: [
          {
            publicUrl: "localhost:8080",
            url: "localhost:8080"
          }
        ]
      }, [@mock_response, symbolize_names: true]
    end

    Seaweed.connect http_options: { http: @mock_rest_client, json: @mock_json_parser }
  end

  def test_status
    setup!
    status = Seaweed.status
    assert_equal false, status.nil?
  end

  def test_low_level_upload
    setup!
    location = Seaweed::Master.dir_assign!
    file = Seaweed::File.new location[:fid], \
      volume_url: location[:url],
      attachment: File.expand_path("../fixtures/test.txt", __FILE__)
    file.upload!
    assert_equal 37, file.size
  end

  def test_as_resource
    setup!
    file = Seaweed.upload File.expand_path("../fixtures/test.txt", __FILE__)
    file1 = Seaweed.find file.id
    assert_equal "hello world!", file1.read.strip
    assert_equal true, file1.delete!
  end
end
