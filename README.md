# pronto-circleci

[![Gem Version](https://badge.fury.io/rb/pronto-circleci.svg)](https://badge.fury.io/rb/pronto-circleci)
[![CircleCI](https://circleci.com/gh/comparaonline/pronto-circleci/tree/master.svg?style=svg)](https://circleci.com/gh/comparaonline/pronto-circleci/tree/master)

This gem allows to simply setup [pronto](https://github.com/prontolabs/pronto) along with **circleci** and **github**.

## Installation

### Application setup

Add the gem to your application's Gemfile:

```ruby
gem 'pronto-circleci'
```

And then add the pronto runners of your choice (e.g. `pronto-rubocop`)

```ruby
gem 'pronto-rubocop'
```

After that update your bundle:
```
$ bundle
```

### CircleCI setup

Setup circle to run pronto before your tests adding this to your `circle.yml`

```
test:
  pre:
    - bundle exec pronto-circleci
```

And finally setup an environment variable with a [Github access token](https://help.github.com/articles/creating-an-access-token-for-command-line-use) in the [circleci environment configuration](https://circleci.com/docs/1.0/environment-variables/) of your repo with the name of: `GITHUB_ACCESS_TOKEN`.


## Usage

Place a `pronto-circleci.yml` under the `config` folder of your app:

```
github:
  org: 'comparaonline'
  repo: 'pronto-circleci'
pronto:
  comments_on_diff: true
  reviews_on_diff: true
  report_status: true
```

### Config
The config flags under the pronto key map to the regular pronto configuration flags:

`comments_on_diff`: Comments appear on pull request diff.
`reviews_on_diff`: Review appear on pull request diff.
`report_status`: Report status check on pull request.

Please note that these are optional and disabled by default.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/pronto-circleci.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
