# Dry::Struct::Rails

Railtie gem to let `dry-struct` cope with Rails' reloading.

This gem is quite EXPERIMENTAL, it's goal is to let subclasses of `Dry::Struct` survive a Rails Application reload in development.

## Previous Work

This gem is based on [dry-types-rails](https://github.com/jeromegn/dry-types-rails). Licensed under The MIT License (MIT), Copyright (c) 2016 Jerome Gravel-Niquet.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dry-struct-rails', group: :development
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dry-struct-rails

## Usage

Nothing more to do.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Contributing

Pull requests are welcome on GitHub at https://github.com/fnordfish/dry-struct-rails.
