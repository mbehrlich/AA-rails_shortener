class ShortenedUrl < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.string :short_url, null: false, unique: true
      t.string :long_url, null: false
      t.integer :creator_id
      t.timestamps
    end

    add_index :shortened_urls, :short_url

  end
end
