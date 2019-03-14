class Credential < ApplicationRecord
  belongs_to :user

  validates_presence_of :provider, :name, :consumer_key, :consumer_secret, :access_token, :access_token_secret, :user_id
end
