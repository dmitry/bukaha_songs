class CreateCompositions < ActiveRecord::Migration[6.0]
  def change
    create_table :compositions do |t|
      t.references :song
      t.text :audio_data
      t.timestamps
    end
  end
end
