require "omniauth"
require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Bitbucket < OmniAuth::Strategies::OAuth2
      EMAIL = "email".freeze
      ACCOUNT = "account".freeze

      option :client_options,
             site: "https://bitbucket.org",
             authorize_url: "/site/oauth2/authorize",
             token_url: "/site/oauth2/access_token"

      def authorize_params
        super.tap do |params|
          scope = params[:scope].to_s.split(/\s+/)
          scope << EMAIL unless scope.include?(EMAIL)
          scope << ACCOUNT unless scope.include?(ACCOUNT)
          params[:scope] = scope.join(" ")
        end
      end

      def callback_url
        full_host + script_name + callback_path
      end

      uid do
        raw_info[:uuid]
      end

      info do
        {
          username: raw_info[:username],
          email: primary_email,
          name: raw_info[:display_name]
        }
      end

      extra do
        {
          account_id: raw_info[:account_id],
          created_on: raw_info[:created_on],
          is_staff: raw_info[:is_staff],
          links: raw_info[:links],
          location: raw_info[:location],
          website: raw_info[:website]
        }
      end

      def raw_info
        @raw_info ||= deep_symbolize(access_token.get("/api/2.0/user").parsed)
      end

      def emails
        @emails ||= deep_symbolize(access_token.get("/api/2.0/user/emails").parsed).fetch(:values)
      end

      def primary_email
        (emails.find {|info| info["is_primary"] } || {})["email"]
      end
    end
  end
end
