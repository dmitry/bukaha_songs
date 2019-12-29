class CreateCompositionInstruments < ActiveRecord::Migration[6.0]
  def change
    create_table :composition_instruments do |t|
      t.references :composition, :instrument, null: false
      t.timestamps
    end
  end
end
