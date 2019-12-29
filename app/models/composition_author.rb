class CompositionAuthor < ApplicationRecord
  belongs_to :composition
  belongs_to :author
end
