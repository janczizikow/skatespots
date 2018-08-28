# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :avatar, AvatarUploader

  before_create :set_username
  # after_create :send_welcome_email

  belongs_to :city, optional: true

  has_many :spots, dependent: :restrict_with_exception
  has_many :spots_photos, dependent: :restrict_with_exception
  has_many :favorites, dependent: :restrict_with_exception

  validates :username, uniqueness: {case_sensitive: false}

  private

  def set_username
    self.username = generate_username(self.email) if username.blank?
  end

  def generate_username(email)
    username = email.downcase.strip.split(/@/).first
    find_unique_username(username)
  end

  def find_unique_username(username)
    taken_usernames = User.where("username LIKE ?", "#{username}%").pluck(:username)
    return username unless taken_usernames.include?(username)

    count = 2
    while true
      new_username = "#{username}_#{count}"
      return new_username unless taken_usernames.include?(new_username)
      count += 1
    end
  end

  # def send_welcome_email
  #   UserMailer.welcome(self).deliver_now
  # end
end
