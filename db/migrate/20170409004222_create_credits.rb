class CreateCredits < ActiveRecord::Migration[5.0]
  def change
    create_table :credits do |t|
      t.string :name
      t.float :points
      t.timestamps
    end

    add_reference :events, :credit, index: true
  end
end
