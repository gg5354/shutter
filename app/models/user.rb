class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :albums
  has_many :photos

  def relationships
    Relationship.where('user_1 = ? OR user_2 = ?', self.id, self.id)
  end

  def friends(options = {})
    status = options[:status] || 'accepted'
    return self.class.none unless Relationship::STATUS[status]
    ids = relationships.where(status: Relationship::STATUS[status]).pluck(:user_1, :user_2)
    ids.map! { |t| t[0] == self.id ? t[1] : t[0] }
    self.class.where(id: ids)
  end
end
