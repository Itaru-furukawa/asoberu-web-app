class Member < ApplicationRecord
  has_many :events
  belongs_to :schedule
end
