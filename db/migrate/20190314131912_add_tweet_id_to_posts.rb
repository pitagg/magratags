class AddTweetIdToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :tweet_id, :string
  end
end
