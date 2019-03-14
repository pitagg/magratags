class CreateCredentials < ActiveRecord::Migration[5.0]
  def change
    create_table :credentials do |t|
      t.string :provider
      t.string :name
      t.string :consumer_key
      t.string :consumer_secret
      t.string :access_token
      t.string :access_token_secret
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
