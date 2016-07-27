
class ShortenedUrl < ActiveRecord::Base

  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true, length: { maximum: 1024, minimum: 5 }
  validate :frequency_limit

  belongs_to :creator,
    primary_key: :id,
    foreign_key: :creator_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: :Visit

  has_many :visitors,
    through: :visits,
    source: :user

  has_many(
    :distinct_visitors,
    -> { distinct },
    through: :visits,
    source: :user
    )

  has_many :taggings,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: :Tagging

  has_many(
    :tags,
    -> { distinct },
    through: :taggings,
    source: :tag_topic)



  def self.random_code
    code = SecureRandom.urlsafe_base64(16)
    while self.exists?(:short_url => code)
      code = SecureRandom.urlsafe_base64(16)
    end
    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    short_url = ShortenedUrl.random_code
    ShortenedUrl.create(short_url: short_url, long_url: long_url, creator_id: user.id)
  end

  def frequency_limit
    # calculate recent submissions
    recent = (Time.now - 5.minutes)..Time.now
    num_recent = creator.short_urls.where(created_at: recent).count
    unless (num_recent < 5 || creator.premium)
      self.errors[:frequency] << "You are using this service way too freaking much!"
    end
  end

  def num_clicks
    visits.length
  end

  def num_uniques
    # visitors.uniq.length
    distinct_visitors.count
  end

  def num_recent_uniques
    recent = (Time.now - 10.minutes)..Time.now
    visits.select(:user_id).where(created_at: recent).distinct.count
  end

end
