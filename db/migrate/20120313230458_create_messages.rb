class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :url, :null => false
      t.integer :vulnerability_id
      t.string :text
      t.boolean :crawler
      t.string :url_hash
      t.integer :count, :default => 1

      t.timestamps
    end
  end
end
