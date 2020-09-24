# Omniauth::Bitbucket

[![Travis-CI](https://travis-ci.org/fnando/omniauth-atlassian-bitbucket.svg)](https://travis-ci.org/fnando/omniauth-atlassian-bitbucket)
[![CodeClimate](https://codeclimate.com/github/fnando/omniauth-atlassian-bitbucket.svg)](https://codeclimate.com/github/fnando/omniauth-atlassian-bitbucket)
[![Gem](https://img.shields.io/gem/v/omniauth-atlassian-bitbucket.svg)](https://rubygems.org/gems/omniauth-atlassian-bitbucket)
[![Gem](https://img.shields.io/gem/dt/omniauth-atlassian-bitbucket.svg)](https://rubygems.org/gems/omniauth-atlassian-bitbucket)

[Bitbucket](http://bitbucket.org)'s OAuth2 Strategy for OmniAuth. This strategy
uses API 2.0 to retrieve user information.

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-atlassian-bitbucket'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-atlassian-bitbucket

## Usage

`OmniAuth::Strategies::Bitbucket` is simply a Rack middleware. Read the OmniAuth
docs for detailed instructions: <https://github.com/intridea/omniauth>.

First, create a new application at
`https://bitbucket.org/account/user/<your username>/api`. Your callback URL must
be something like `https://example.com/auth/bitbucket/callback`. For development
you can use `http://127.0.0.1:3000/auth/bitbucket/callback`.

Here's a quick example, adding the middleware to a Rails app in
`config/initializers/omniauth.rb`. This example assumes you're exporting your
credentials as environment variables.

Notice that we'll always inject `account` and `emails` scopes, so we can
retrieve the required information.

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :bitbucket,
            ENV['BITBUCKET_CLIENT_ID'],
            ENV['BITBUCKET_CLIENT_SECRET']
end
```

Now visit `/auth/bitbucket` to start authentication against Bitbucket.

## Contributing

1. Fork
   [omniauth-atlassian-bitbucket](https://github.com/fnando/omniauth-atlassian-bitbucket/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
