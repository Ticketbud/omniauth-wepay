# Omniauth Wepay

WePay OAuth2 Strategy for OmniAuth 1.0.

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-wepay', git: "https://github.com/Ticketbud/omniauth-wepay"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-wepay

## Usage

OmniAuth::Strategies::Wepay is a Rack middleware. Read the OmniAuth 1.0 docs for detailed instructions: https://github.com/intridea/omniauth.

Here's a quick example, adding the middleware to a Rails app in config/initializers/omniauth.rb:
```ruby
require "omniauth/strategies/wepay"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :wepay, ENV['APP_ID'], ENV['SECRET']
end
```

### Note

Currently the gem defaults to the "stage" endpoints. When you are ready to go into production, modify the omniauth.rb as follows to use the production endpoints:


```ruby
require "omniauth/strategies/wepay"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :wepay, ENV['APP_ID'], ENV['SECRET'] do |config|
    config.client_options.authorize_url  = "https://www.wepay.com/v2/oauth2/authorize"
    config.client_options.token_url      = "https://www.wepayapi.com/v2/oauth2/token"
    config.client_options.site           = "https://www.wepayapi.com/v2"
  end
end
```

## Scopes
The following scopes are hardcoded into the strategy:

```
manage_accounts,view_balance,collect_payments,refund_payments,view_user,preapprove_payments  
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


# License

Copyright (c) 2015 by Brandon Harris

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
