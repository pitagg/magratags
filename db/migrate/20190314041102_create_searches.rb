class CreateSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :searches do |t|
      t.string :name
      t.string :expression
      t.boolean :ignore_rt, default: false
      t.string :last_tweet_id
      t.datetime :synced_at

      t.timestamps
    end
  end
end
