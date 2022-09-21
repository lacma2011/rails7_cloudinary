class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :public_id
      t.integer :user_id
      t.string :url
      t.string :secure_url
      t.string :asset_id

      t.timestamps
    end
  end
end
