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
    token = "token #{auth["credentials"]["token"]}"
    user[:token] = token
    github_id = find_github_id(token)
    user[:github_id] = github_id
    user.save
  end

  def find_github_id(token)
    GithubService.new(token).get_github_id
  end

end
