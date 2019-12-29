class Composition < ApplicationRecord
  include AudioUploader::Attachment(:audio)

  belongs_to :song

  has_many :composition_authors, dependent: :destroy
  has_many :authors, through: :composition_authors

  has_many :composition_instruments, dependent: :destroy
  has_many :instruments, through: :composition_instruments

  accepts_nested_attributes_for :authors, update_only: true
  accepts_nested_attributes_for :instruments, update_only: true

  validates :audio, presence: true
  validates :identifier, uniqueness: true

  before_validation do
    self.identifier = generate_identifier
  end

  def generate_identifier
    authors = self.authors.map(&:name).join(', ')
    title = song.title
    [authors, title].select(&:present?).join(' - ')
  end
end
