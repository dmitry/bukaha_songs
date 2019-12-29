class Composition < ApplicationRecord
  include AudioUploader::Attachment.new(:audio)

  belongs_to :composition

  has_many :composition_authors, dependent: :destroy
  has_many :authors, through: :composition_authors

  has_many :composition_instruments, dependent: :destroy
  has_many :instruments, through: :composition_instruments

  accepts_nested_attributes_for :authors, only: :update
  accepts_nested_attributes_for :instruments, only: :update

  validates :audio, presence: true
end
