class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :albums
  has_many :photos
  has_many :relationships, class_name: 'Friend', foreign_key: :user_1
  has_many :friends, through: :relationships, source: :user
end
