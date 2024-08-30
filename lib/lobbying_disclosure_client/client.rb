# typed: strict
# frozen_string_literal: true

require 'faraday'

module LobbyingDisclosureClient
  class Client
    extend T::Sig

    sig do
      params(
        route: LobbyingDisclosureClient::Route
      ).returns(
        T::Hash[String, String]
      )
    end
    def get(route)
      JSON.parse(
        connection.get(
          route.to_full_api_path
        ).body
      )
    end

    sig do
      params(
        route: LobbyingDisclosureClient::Route,
        body: T::Hash[String, String]
      ).returns(
        T::Hash[String, String]
      )
    end
    def post(route, body = {})
      JSON.parse(
        connection.post(
          route.to_full_api_path,
          body.to_json
        ).body
      )
    end

    private

    sig do
      returns(Faraday::Connection)
    end
    def connection
      Faraday.new(
        headers: build_headers
      ) do |conn|
        conn.response :raise_error
        conn.adapter :net_http
      end
    end

    sig do
      returns(T::Hash[String, String])
    end
    def build_headers
      headers = { 'Content-Type' => 'application/json' }

      # The Lobbying Disclosure API does allow unauthenticated ("anonymous") requests,
      # though they are aggressively rate-limited.

      headers['Authorization'] = "Token #{LobbyingDisclosureClient.api_key}" if LobbyingDisclosureClient.api_key

      headers
    end
  end
end
