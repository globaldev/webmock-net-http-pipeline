# WebMock + Net::HTTP::Pipeline

Use WebMock to test your use of pipelined HTTP requests.

[WebMock][webmock] is a great tool for stubbing HTTP requests in tests.
[net-http-pipeline][nhp] is an HTTP/1.1 pipelining implementation build on top
of Net::HTTP, used for making batches of HTTP calls more efficient.  The only
problem is that the two don't play well together: net-http-pipeline bypasses
the hooks that WebMock sets in place to provide its behaviour.

This library mimics the -pipeline behaviour within WebMock's version of
`Net::HTTP#request` to allow you to test your pipelined HTTP calls.

## Installation

Add this line to your application"s Gemfile:

```ruby
gem "webmock-net-http-pipeline"
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install webmock-net-http-pipeline
```

## Usage

Simply continue to mock your HTTP requests as you already do with Webmock, but
now you can test your mocked pipeline calls too.

```ruby
require "webmock"
require "webmock/net/http/pipeline"

include WebMock::API

host = "www.example.com"
stub_request(:any, host)

http      = Net::HTTP.start(host, 80).tap { |http| http.pipelining = true }
requests  = (1..3).map { Net::HTTP::Get.new("/") }
responses = http.pipeline(requests)

p responses   #=> [#<Net::HTTPOK 200  readbody=true>, ...]
```

## Ruby Version Compatilbility

As of v2.0.0, this library is compatible with Ruby versions >= 2.0.0.  For a
version compatible with earlier Rubies, please v1.0.0.

## Contributing

1. Fork it: http://github.com/globaldev/webmock-net-http-pipeline/fork
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am "Add some feature"`
4. Push to the branch: `git push origin my-new-feature`
5. Create new Pull Request

## Licensing and Attribution

webmock-net-http-pipeline is released under the MIT license as detailed in the
LICENSE file that should be distributed with ; the source code is [freely
available][wnhp].

webmock-net-http-pipeline was developed by [Tim Blair][tim] and [Mat
Sadler][mat] during work on [White Label Dating][wld], while employed by
[Global Personals Ltd][gp].  Global Personals Ltd. have kindly agreed to the
extraction and release of this software under the license terms above.

[webmock]: https://github.com/bblimke/webmock
[nhp]:     https://github.com/drbrain/net-http-pipeline
[wnhp]:    https://gitbug.com/globaldev/webmock-net-http-pipeline
[tim]:     http://tim.bla.ir/
[mat]:     https://twitter.com/matsadler
[wld]:     http://www.whitelabeldating.com/
[gp]:      http://www.globalpersonals.co.uk/
