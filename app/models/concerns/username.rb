# frozen_string_literal: true

module Username
  extend ActiveSupport::Concern

  included do
    before_create :set_username
  end

  private

  def set_username
    self.username = generate_username(self.email) if username.blank?
  end

  def generate_username(email)
    username = email.downcase.strip.split(/@/).first
    find_unique_username(username)
  end

  def find_unique_username(username)
    taken_usernames = User.where('username LIKE ?', "#{username}%").pluck(:username)
    return username unless taken_usernames.include?(username)

    count = 2
    while true
      new_username = "#{username}_#{count}"
      return new_username unless taken_usernames.include?(new_username)
      count += 1
    end
  end
end
