class Post < ApplicationRecord

  validates_uniqueness_of :provider_user_id, scope: :provider

  def self.create_from_tweet(tweet)
    post = self.create(
      provider: 'twitter',
      provider_user_id: tweet.user.id,
      provider_user_name: tweet.user.name,
      provider_user_image: tweet.user.profile_image_uri_https.to_s,
      provider_user_screen_name: tweet.user.screen_name,
      provider_user_description: tweet.user.description,
      message: tweet.text,
      uri: tweet.uri,
      published_at: tweet.created_at,
      retweeted: tweet.retweeted?,
      lang: tweet.lang,
      complete_data: tweet.to_json
    )
  end
end
