# frozen_string_literal: true

class User < ApplicationRecord
  include Username
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :avatar, AvatarUploader

  belongs_to :city, optional: true

  has_many :spots, dependent: :restrict_with_exception
  has_many :spots_photos, dependent: :restrict_with_exception
  has_many :favorites, dependent: :restrict_with_exception

  validates :username, uniqueness: {case_sensitive: false}
end
