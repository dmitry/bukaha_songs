class CompositionInstrument < ApplicationRecord
  belongs_to :composition
  belongs_to :instrument
end
