class Album < ActiveRecord::Base
  belongs_to :user
  has_many :photos
  validates_uniqueness_of :name, scope: :user_id
end
