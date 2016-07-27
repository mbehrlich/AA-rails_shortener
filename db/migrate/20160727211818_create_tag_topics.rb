class CreateTagTopics < ActiveRecord::Migration
  def change
    create_table :tag_topics do |t|
      t.string :tag, null: false
      t.timestamps
    end

    create_table :taggings do |t|
      t.integer :tag_id, null: false
      t.integer :short_url_id, null: false
      t.timestamps
    end

  end
end
