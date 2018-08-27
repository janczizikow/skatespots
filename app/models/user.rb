# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :avatar, AvatarUploader

  before_validation :set_username
  # after_create :send_welcome_email

  belongs_to :city, optional: true

  has_many :spots, dependent: :restrict_with_exception
  has_many :spots_photos, dependent: :restrict_with_exception
  has_many :favorites, dependent: :restrict_with_exception

  validates :username, uniqueness: {case_sensitive: false}

  private

  # FIXME: randomize username better
  def set_username
    self.username = ('A'..'Z').to_a.sample if username.blank?
  end

  # def send_welcome_email
  #   UserMailer.welcome(self).deliver_now
  # end
end
