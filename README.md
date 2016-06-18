# MinifiedErb

Minifies output of erb templates compilation: eliminates line-breaks, tabs and spaces

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'minified_erb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install minified_erb

## Usage

```ruby
require 'erubis'
require 'minified_erb'

template = <<-HEREDOC
<div>
  <% 3.times do %>
    <span></span>
  <% end %>
</div>
HEREDOC

erb = Erubis::Eruby.new(template, minify: true)

p erb.result # => "<div><span></span><span></span><span></span></div>"
```

## Supported Erb engines

- Erubis
- Erbse

## Rails support

ActionView uses `erubis`. The `minify: true` is passed for all templates with `text/html` type.

## Limitations

Only full line comments are supported. Comments on the same line with code will lead to various issues.
```erb
<div>
  <%# this works %>
  <% if true # this will lead to a syntax error %>
  <% end     # because this line will become commented out too %>
</div>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dreyks/minified_erb.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

