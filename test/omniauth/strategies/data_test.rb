require "test_helper"

class DataTest < Minitest::Test
  let(:app) { ->(env) { } }

  let(:strategy) do
    OmniAuth::Strategies::Bitbucket.new(app, "consumer_id", "consumer_secret")
  end

  test "returns raw info" do
    payload = {"id" => "ID"}
    access_token = mock("access_token")
    response = mock("response", parsed: payload)
    access_token.expects(:get).with("/api/2.0/user").returns(response)
    strategy.stubs(:access_token).returns(access_token)

    assert_equal Hash[:id, "ID"], strategy.raw_info
  end

  test "returns emails" do
    payload = {"values" => ["EMAILS"]}
    access_token = mock("access_token")
    response = mock("response", parsed: payload)
    access_token.expects(:get).with("/api/2.0/user/emails").returns(response)
    strategy.stubs(:access_token).returns(access_token)

    assert_equal ["EMAILS"], strategy.emails
  end

  test "returns primary email" do
    emails = [
      {"email" => "SECONDARY", "is_primary" => false},
      {"email" => "PRIMARY", "is_primary" => true}
    ]
    strategy.stubs(:emails).returns(emails)

    assert_equal "PRIMARY", strategy.primary_email
  end

  test "returns nil when no primary email is found" do
    strategy.stubs(:emails).returns([])
    assert_nil strategy.primary_email
  end

  test "returns info" do
    strategy.stubs(:raw_info).returns(username: "USERNAME", display_name: "NAME")
    strategy.stubs(:primary_email).returns("EMAIL")

    info = strategy.info

    assert_equal "USERNAME", info[:username]
    assert_equal "EMAIL", info[:email]
    assert_equal "NAME", info[:name]
  end

  test "returns uid" do
    strategy.stubs(:raw_info).returns(uuid: "ID")
    assert_equal "ID", strategy.uid
  end

  test "returns extra info" do
    raw_info = {
      account_id: "ACCOUNT_ID",
      created_on: "CREATED_ON",
      is_staff: "IS_STAFF",
      links: "LINKS",
      location: "LOCATION",
      website: "WEBSITE"
    }
    strategy.stubs(:raw_info).returns(raw_info)

    assert_equal raw_info, strategy.extra
  end
end
