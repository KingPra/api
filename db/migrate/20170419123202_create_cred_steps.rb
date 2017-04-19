class CreateCredSteps < ActiveRecord::Migration[5.0]
  def change
    create_table :cred_steps do |t|
      t.references :credit, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :status, default: "incomplete"

      t.timestamps
    end
  end
end
