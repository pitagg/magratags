class Post < ApplicationRecord
  has_and_belongs_to_many :searches
  validates_uniqueness_of :tweet_id, scope: :provider

  # Recebe uma instância de Twitter::Tweet e encontra seu respectivo Post. Se não encontrar, cria um novo registro.
  def self.create_from_tweet(tweet)
    post = self.where(provider: 'twitter', tweet_id: tweet.id.to_s).first
    post ||= self.create(
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
      tweet_id: tweet.id.to_s,
      complete_data: tweet.to_json
    )
  end
end