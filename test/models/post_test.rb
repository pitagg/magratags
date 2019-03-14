require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "provider_user_id should be unique by provider" do
    post = Post.new(Post.first.slice(:provider, :provider_user_id))
    post.valid?
    assert post.errors.details[:provider_user_id].map(&:values).flatten.include?(:taken)
  end
end
