require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Wepay < OmniAuth::Strategies::OAuth2

      DEFAULT_PERMISSIONS = "manage_accounts,view_balance,collect_payments,refund_payments,view_user,preapprove_payments,send_money"

      option :fields, [:user_id, :name, :email]
      option :uid_field, :user_id
      option :scope, DEFAULT_PERMISSIONS
      option :client_options, {
        :authorize_url  => "https://stage.wepay.com/v2/oauth2/authorize",
        :token_url      => "https://stage.wepayapi.com/v2/oauth2/token",
        :site           => "https://stage.wepayapi.com/v2",
        :user_path      => "/user"
      }

      uid do
        raw_info['user_id']
      end

      info do
        {
         "email"        => raw_info['email'],
         "name"         => raw_info['user_name'],
         "first_name"   => raw_info['first_name'],
         "last_name"    => raw_info['last_name']
         }
      end

      # For WePay Canada, we need to pass that param to WePay
      # I ripped this off from this PR
      # https://github.com/arunagw/omniauth-twitter/pull/10/files

      alias :old_request_phase :request_phase

      def request_phase 
        user_country = session['omniauth.params']['user_country']
        if user_country && !user_country.empty?
          options[:authorize_params] ||= {}
          options[:authorize_params].merge!(:user_country => user_country)
        end
        old_request_phase
      end

      def raw_info
        url = options.client_options[:site] + options.client_options[:user_path]

        info = client.request(:post, url) do |req|
          req.headers["Authorization"] = "Bearer #{access_token.token}"
        end.parsed

        @raw_info ||= info.merge({user_id: access_token.params["user_id"]})
      end
    end
  end
end
