class CreateCompositionAuthors < ActiveRecord::Migration[6.0]
  def change
    create_table :composition_authors do |t|
      t.references :composition, :author, null: false
      t.timestamps
    end
  end
end
