class CreatePostEntries < ActiveRecord::Migration
  def change
    create_table :post_entries do |t|
      t.integer :author_id
      t.text :content

      t.timestamps
    end
  end
end
