class User < ActiveRecord::Base

  validates :email, presence: true, uniqueness: true

  has_many :short_urls,
    primary_key: :id,
    foreign_key: :creator_id,
    class_name: :ShortenedUrl

  has_many :visits,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Visit

  has_many :visited_urls,
    through: :visits,
    source: :short_url

  has_many(
    :distinct_visited_urls,
    -> { distinct },
    through: :visits,
    source: :short_url
  )


end
