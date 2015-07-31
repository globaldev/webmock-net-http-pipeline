require "webmock/net/http/pipeline/version"
require "webmock"

module WebMock
  module NetHTTPPipeline

    def pipeline(requests)
      responses = []
      requests.reject! do |req|
        response = request(req)
        yield response if block_given?
        responses << response
      end
      responses
    end

    # Not actually used, but keeps the interface consistent with -pipeline
    attr_accessor :pipelining

  end
end

WebMock::HttpLibAdapters::NetHttpAdapter.instance_variable_get(:@webMockNetHTTP).class_eval do
  prepend WebMock::NetHTTPPipeline
end
