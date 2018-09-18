require "test_helper"

class AuthorizeParamsTest < Minitest::Test
  let(:app) { ->(env) { } }

  let(:strategy) do
    OmniAuth::Strategies::Bitbucket.new(app, "consumer_id", "consumer_secret")
  end

  test "dont set a default scope" do
    strategy.stubs(:session).returns({})
    assert_equal nil, strategy.authorize_params.scope
  end

  test "sets unique scopes" do
    strategy = OmniAuth::Strategies::Bitbucket.new(nil, "ID", "SECRET", scope: "account team")
    strategy.stubs(:session).returns({})

    assert_equal "account team", strategy.authorize_params.scope
  end
end
