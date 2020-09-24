# frozen_string_literal: true

require "test_helper"

class AuthorizeParamsTest < Minitest::Test
  let(:app) { ->(env) { } }

  let(:strategy) do
    OmniAuth::Strategies::Bitbucket.new(app, "consumer_id", "consumer_secret")
  end

  test "sets defaults scopes" do
    strategy.stubs(:session).returns({})
    assert_equal "email account", strategy.authorize_params.scope
  end

  test "injects required scopes" do
    strategy =
      OmniAuth::Strategies::Bitbucket.new(nil, "ID", "SECRET", scope: "team")
    strategy.stubs(:session).returns({})

    assert_equal "team email account", strategy.authorize_params.scope
  end

  test "sets unique scopes" do
    strategy = OmniAuth::Strategies::Bitbucket.new(
      nil,
      "ID",
      "SECRET",
      scope: "account email"
    )
    strategy.stubs(:session).returns({})

    assert_equal "account email", strategy.authorize_params.scope
  end
end
