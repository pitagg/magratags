require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user name cant be blank" do
    user = User.new
    user.valid?
    assert user.errors.details[:name].map(&:values).flatten.include?(:blank)
  end

  test "user email cant be blank" do
    user = User.new
    user.valid?
    assert user.errors.details[:email].map(&:values).flatten.include?(:blank)
  end

  test "user password cant be blank" do
    user = User.new
    user.valid?
    assert user.errors.details[:password].map(&:values).flatten.include?(:blank)
  end
end
