class AddUniqueIndexesToSongsAuthorsInstruments < ActiveRecord::Migration[6.0]
  def change
    add_index :songs, :title, unique: true
    add_index :authors, :name, unique: true
    add_index :instruments, :name, unique: true
  end
end
