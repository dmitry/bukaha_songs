class Instrument < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
