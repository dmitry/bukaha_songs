class Song < ApplicationRecord
  has_many :compositions, dependent: :destroy

  validates :title, presence: true, uniqueness: true

  scope :title_like, -> query { where(arel_table[:title].matches("%#{query}%")) }

  # normalization
  def text=(text)
    if text.present?
      super(text)
    end
  end

  def chords?
    text.present? && text.include?('[')
  end

  def lyrics
    if text.present?
      text.gsub(/\[[^\]+]\]/, '')
    end
  end

  def lyrics_with_chords
    if text.present?
      if chords?
        # TODO: add here logic that makes chords above the lyrics text
        lyrics
      else
        lyrics
      end
    end
  end
end
