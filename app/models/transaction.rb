class Transaction < ApplicationRecord
  belongs_to :customer

  def stampstring
    return stamp.localtime.strftime("%m/%d/%Y %I:%M %p")
  end
end
