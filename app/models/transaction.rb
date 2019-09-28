class Transaction < ApplicationRecord
  belongs_to :customer

  def stampstring
    if stamp != nil
      return stamp.localtime.strftime("%m/%d/%Y %I:%M %p")
    else
      return "<none>"
    end
  end
end
