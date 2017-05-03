class CreateCredits < ActiveRecord::Migration[5.0]
  def change
    create_table :credits do |t|
      t.string :name
      t.float :points_per_unit, default: 0.0
      t.timestamps
    end

    add_reference :events, :credit, index: true
  end
end
