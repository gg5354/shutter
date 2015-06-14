class Friend < ActiveRecord::Base
  STATUS = {
    pending:  0,
    accepted: 1,
    declined: 2,
    blocked:  3
  }

  belongs_to :user
end
