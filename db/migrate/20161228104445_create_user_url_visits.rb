class CreateUserUrlVisits < ActiveRecord::Migration
  def change
    create_table :user_url_visits do |t|
      t.integer :user_id
      t.integer :link_id
      
      t.timestamps null: false
    end
  end
end
