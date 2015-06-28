class Relationship < ActiveRecord::Base
  STATUS = {
    pending:  0,
    accepted: 1,
    declined: 2,
    blocked:  3
  }.with_indifferent_access

  ALLOW_CHANGES_TO = [:status]

  validates_uniqueness_of :user_1, scope: :user_2
  validates_presence_of :user_1, :user_2

  before_create :set_status_to_pending
  belongs_to :user, foreign_key: :user_2
  validate :no_disallowed_attributes_changed

  private

  def no_disallowed_attributes_changed
    return unless persisted?

    changes.each_key do |attribute|
      if !ALLOW_CHANGES_TO.include?(attribute.to_sym)
        errors.add(attribute, 'cannot be changed once persisted')
      end
    end
  end

  def set_status_to_pending
    self.status ||= STATUS[:pending]
  end
end
