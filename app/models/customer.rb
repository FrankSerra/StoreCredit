require 'csv'

class Customer < ApplicationRecord
  has_many :transactions

  def localtimestring
    return lastmodified.localtime.strftime("%m/%d/%Y %I:%M %p")
  end

  def notesstring
    if notes.strip.empty?
      return "---"
    else
      return notes
    end
  end
end
