class Song < ApplicationRecord
  has_many :compositions

  validates :title, presence: true

  # normalization
  def text=(text)
    if text.present?
      super(text)
    end
  end

  def has_chords?
    text.include?('[')
  end

  def lyrics
    if text
      text.gsub(/\[[^\]+]\]/, '')
    end
  end

  def lyrics_with_chords
    if has_chords?
      # TODO: add here logic that makes chords above the lyrics text
      lyrics
    else
      lyrics
    end
  end
end
