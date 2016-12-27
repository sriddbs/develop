class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :actual_url, null: false
      t.string :key, null: false
      
      t.timestamps null: false
    end
  end
end
