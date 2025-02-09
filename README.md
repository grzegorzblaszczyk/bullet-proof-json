[![Dependabot Updates](https://github.com/grzegorzblaszczyk/bullet-proof-json/actions/workflows/dependabot/dependabot-updates/badge.svg)](https://github.com/grzegorzblaszczyk/bullet-proof-json/actions/workflows/dependabot/dependabot-updates)

# Goal

Tired of dealing with unreliable REST APIs with JSON responses, endless timeouts, and complex error handling just to fetch some JSON data?

BulletProofJSON for Ruby takes the hassle out of API response handling by offering:

* Seamless Request Handling: Automatically manage timeouts and errors so your app stays resilient.
* Smart Throttling: Respect API rate limits without overcomplicating your code.
* Robust Retry Mechanism: Never miss a response due to transient errors.

Whether you integrate with a rock-solid API or deal with unpredictable services, this gem ensures your JSON responses are delivered smoothly and reliably.

# Dependencies

It depends only on a few standard Ruby libraries like: 

* JSON
* Net::HTTP

# Installation

Add this line to your application's Gemfile:

```ruby
gem 'bullet_proof_json'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bullet_proof_json

## Usage

```ruby
provider = BulletProofJson::Provider.new
json = provider.get("https://api.restful-api.dev/objects")
json[0]["name"]
# "Google Pixel 6 Pro"
```

By default, it fetches the JSON response with maximum 3 attempts and 1 second of sleep time between each attempt.

You can change it in options hash per each request. Here is an example for 10 attempts, and 60 seconds of sleep time between attempts:

```ruby
provider = BulletProofJson::Provider.new
json = provider.get("https://api.restful-api.dev/objects", {max_attempts: 10, sleep_time: 60})
json[0]["name"]
# "Google Pixel 6 Pro"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/grzegorzblaszczyk/bullet-proof-json-provider/. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the BulletProofJSON project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/grzegorzblaszczyk/bullet-proof-json-provider//blob/master/CODE_OF_CONDUCT.md).

