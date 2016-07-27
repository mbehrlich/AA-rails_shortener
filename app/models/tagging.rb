class Tagging < ActiveRecord::Base

  validates :tag_id, :short_url_id, presence: true

  belongs_to :tag_topic,
    primary_key: :id,
    foreign_key: :tag_id,
    class_name: :TagTopic

  belongs_to :short_url,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: :ShortenedUrl

  def self.[]=(url_id, tags)
    tags.each do |tag|
      temp_tag = TagTopic.find_by(tag: tag)
      Tagging.create(tag_id: temp_tag.id, short_url_id: url_id)
    end
  end

end
