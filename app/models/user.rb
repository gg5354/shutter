class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :albums
  has_many :photos

  def friends
    ids = Friend.where('user_1 = ? OR user_2 = ?', self.id, self.id).map do |friend|
      friend.user_1 == self.id ? friend.user_2 : friend.user_1
    end

    User.where(id: ids)
  end
end
