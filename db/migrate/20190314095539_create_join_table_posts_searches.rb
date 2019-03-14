class CreateJoinTablePostsSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :posts_searches, :id => false do |t|
      t.integer :post_id, index: true
      t.integer :search_id, index: true
    end

    add_index :posts_searches, [:search_id, :post_id]
  end
end
