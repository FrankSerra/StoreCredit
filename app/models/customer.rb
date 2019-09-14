class Customer < ApplicationRecord
  def localtimestring
    return lastmodified.localtime.strftime("%m/%d/%Y %I:%M %p")
  end
end
