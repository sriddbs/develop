class AddShortUrlToLink < ActiveRecord::Migration
  def change
    add_column :links, :short_url, :string
  end
end
