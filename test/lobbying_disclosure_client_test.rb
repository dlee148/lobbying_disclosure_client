# typed: true
# frozen_string_literal: true

require 'test_helper'

class LobbyingDisclosureClientTest < Minitest::Test
  def teardown
    LobbyingDisclosureClient.api_key = nil
  end

  def test_api_key_accessor
    assert_nil(LobbyingDisclosureClient.api_key)

    LobbyingDisclosureClient.api_key = 'Hello, world'

    assert_equal('Hello, world', LobbyingDisclosureClient.api_key)
  end
end
