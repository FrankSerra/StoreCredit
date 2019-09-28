class Customer < ApplicationRecord
  has_many :transactions
  
  def localtimestring
    return lastmodified.localtime.strftime("%m/%d/%Y %I:%M %p")
  end
end
