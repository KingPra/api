class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :category
      t.references :user, foreign_key: true
      t.integer :quantity, default: 1
      t.json :info, default: {}

      t.timestamps
    end
  end
end
