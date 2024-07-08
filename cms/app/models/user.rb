class User < ApplicationRecord
  has_secure_password
  has_many :app_subscriptions
  has_many :user_roles
  has_many :apps, through: :app_subscriptions
  has_many :roles, through: :user_roles
end
