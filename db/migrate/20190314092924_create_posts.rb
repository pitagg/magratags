class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :provider
      t.string :provider_user_id
      t.string :provider_user_name
      t.string :provider_user_image
      t.string :provider_user_screen_name
      t.text :provider_user_description
      t.text :message
      t.string :uri
      t.datetime :published_at
      t.boolean :retweeted
      t.string :lang
      t.json :complete_data

      t.timestamps
    end
  end
end
