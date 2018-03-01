# FileCache

Simple file caching module, which caches a ruby object in a file.

## Usage

Cache api call for 24 hours as json:

```ruby
instances = FileCache.open do
  ec2 = Aws::EC2::Client.new()
  ec2.describe_instances()
end
```

Cache data returned from block for 5 minutes as json:

```ruby
data = FileCache.open(lifetime: 5) do
  # heavy calculation, data retrivial or similar
  # which returns one object, which is going to be cached
end
```

Cache data returned from block and use Marshal.dump and Marshal.load:

```ruby
data = FileCache.open(format: :marshal) do
  # heavy calculation, data retrivial or similar
  # which returns one object, which is going to be cached
end
```

Force refresh of cached data:

```ruby
data = FileCache.open(force_refresh: true) do
  # heavy calculation, data retrivial or similar
  # which returns one object, which is going to be cached
end
```

Per default, the cache filename is calculated from $0. If You need multiple cache files, You can use variants to create different cache files:

```ruby
data = FileCache.open(variants: 'some_variant') do
  # heavy calculation, data retrivial or similar
  # which returns one object, which is going to be cached
end
```

Force deletion of cache file:

```
FileCache.clean
```

Force deletion of cache file in marshal format and with variants:

```
FileCache.clean(format: :marshal, variants: 'some_variant')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lscheidler/ruby-file_cache.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lscheidler/ruby-file_cache.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

