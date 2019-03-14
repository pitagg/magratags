require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "tweet_id should be unique by provider" do
    post = Post.new(Post.first.slice(:provider, :provider_user_id))
    post.valid?
    assert post.errors.details[:tweet_id].map(&:values).flatten.include?(:taken)
  end
end
