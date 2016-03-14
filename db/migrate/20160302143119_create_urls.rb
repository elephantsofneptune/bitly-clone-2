class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :long, null: false
      t.string :shortened, null: false
      t.integer :share_count, default: 0, null: false

      t.timestamps
    end
  end
end
