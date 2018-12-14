class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password_digest
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def find_or_create_from_auth_hash(user, auth)
    token = "#{auth["credentials"]["token"]}"
    user[:token] = token
    user[:github_id] = "#{auth["extra"]["raw_info"]["id"]}"
    user.save!
  end



  def validate_email
    self.activated = true
    # self.activation_token = nil
  end

  def set_activation_token
    if self.activation_token.blank?
      self.activation_token = SecureRandom.urlsafe_base64.to_s
    end
  end


end
