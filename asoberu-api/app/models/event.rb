class Event < ApplicationRecord
  belongs_to :schedule
  belongs_to :member
end
