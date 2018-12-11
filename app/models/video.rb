class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial

  def self.display_videos(user)
    joins(:user_videos)
    .order(:tutorial_id, :position)
    .where('user_id = ?', user.id)
    .limit(5)
  end
end
