class AddPostIdToPostEntry < ActiveRecord::Migration
  def change
    add_column :post_entries, :post_id, :integer
  end
end
