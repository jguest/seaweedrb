## seaweedrb

a [seaweed-fs](https://github.com/chrislusf/seaweedfs) ruby client

### Getting Started

Run `gem install seaweedrb` or include it in your project's Gemfile.

```ruby
require 'seaweed'
Seaweed.connect host: "localhost", port: 9333
```

### Operations

```ruby
# upload a file
file = Seaweed.upload "/path/to/test.txt"

# file info
file.pretty_url # => "http://localhost:8080/1/01766888e0/test.txt"
file.url        # => "http://localhost:8080/1,01766888e0"
file.read       # => "hello world!"

# find a file and delete it
file = Seaweed.find "1,01766888e0"
file.read    # => "hello world!"
file.delete! # => true
```
