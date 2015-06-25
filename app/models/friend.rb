class Friend < ActiveRecord::Base
  STATUS = {
    pending:  0,
    accepted: 1,
    declined: 2,
    blocked:  3
  }

  before_create :set_status_to_pending
  belongs_to :user, foreign_key: :user_2

  def self.find_pair(user_1, user_2)
    where('user_1 = ? AND user_2 = ? OR user_1 = ? AND user_2 = ?', user_1, user_2, user_2, user_1)
  end

  private

  def set_status_to_pending
    self.status ||= STATUS[:pending]
  end
end
