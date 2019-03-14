class Credential < ApplicationRecord
  belongs_to :user

  validates_presence_of :provider, :name, :consumer_key, :consumer_secret, :access_token, :access_token_secret, :user_id

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = self.consumer_key
      config.consumer_secret = self.consumer_secret
      config.access_token = self.access_token
      config.access_token_secret = self.access_token_secret
    end
  end
end
