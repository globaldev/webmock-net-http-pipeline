require "minitest/autorun"
require "webmock/net/http/pipeline"

class TestPipeliningBehaviour < MiniTest::Test

  class MockedResponse < Struct.new(:request); end
  class MockedClient
    include WebMock::NetHTTPPipeline
    def request(req)
      MockedResponse.new(req)
    end
  end

  def setup
    @client = MockedClient.new
  end

  def test_pipelines_zero_requests
    assert_empty @client.pipeline([])
  end

  def test_pipelines_one_request
    requests = [:one]
    responses = @client.pipeline(requests.dup)
    assert_equal 1, responses.length
    assert_same requests.first, responses.first.request
  end

  def test_pipelines_multiple_requests
    requests = [:one, :two, :three]
    responses = @client.pipeline(requests.dup)
    responses.each { |res| assert_includes requests, res.request }
  end

  def test_returns_responses_in_order
    requests = [:one, :two, :three]
    responses = @client.pipeline(requests.dup)
    assert requests == responses.map { |r| r.request }
  end

  def test_removes_successfully_pipelined_requests
    requests = [:one, :two, :three]
    assert_equal 3, @client.pipeline(requests).size
    assert_empty requests
  end

  def test_yields_each_response_if_block_given
    requests, responses = [:one, :two, :three], []
    @client.pipeline(requests.dup) { |res| responses << res.request }
    assert requests == responses
  end
end

class TestWebMockInclusion < MiniTest::Test
  def setup
    klass = WebMock::HttpLibAdapters::NetHttpAdapter
    @client = klass.instance_variable_get(:@webMockNetHTTP).new(nil)
  end

  def test_net_http_adapter_responds_to_pipeline
    assert_respond_to @client, :pipeline
  end

  def test_net_http_adapter_responds_to_pipelining
    assert_respond_to @client, :pipelining
  end

  def test_net_http_adapter_responds_to_pipelining=
    assert_respond_to @client, :pipelining=
  end
end
