require 'test_helper'

class CredentialTest < ActiveSupport::TestCase
  test "credential provider cant be blank" do
    search = Credential.new
    search.valid?
    assert search.errors.details[:provider].map(&:values).flatten.include?(:blank)
  end

  test "credential name cant be blank" do
    search = Credential.new
    search.valid?
    assert search.errors.details[:name].map(&:values).flatten.include?(:blank)
  end

  test "credential consumer_key cant be blank" do
    search = Credential.new
    search.valid?
    assert search.errors.details[:consumer_key].map(&:values).flatten.include?(:blank)
  end

  test "credential consumer_secret cant be blank" do
    search = Credential.new
    search.valid?
    assert search.errors.details[:consumer_secret].map(&:values).flatten.include?(:blank)
  end

  test "credential access_token cant be blank" do
    search = Credential.new
    search.valid?
    assert search.errors.details[:access_token].map(&:values).flatten.include?(:blank)
  end

  test "credential access_token_secret cant be blank" do
    search = Credential.new
    search.valid?
    assert search.errors.details[:access_token_secret].map(&:values).flatten.include?(:blank)
  end

  test "credential user cant be blank" do
    search = Credential.new
    search.valid?
    assert search.errors.details[:user_id].map(&:values).flatten.include?(:blank)
  end

  test 'client should be a Twitter::REST::Client' do
    assert Credential.first.client.is_a?(Twitter::REST::Client)
  end
end
