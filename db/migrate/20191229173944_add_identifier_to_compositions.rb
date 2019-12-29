class AddIdentifierToCompositions < ActiveRecord::Migration[6.0]
  def change
    add_column :compositions, :identifier, :string, null: false, default: ''
    add_index :compositions, :identifier, unique: true
  end
end
