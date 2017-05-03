class CreateCredTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :cred_transactions do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
      t.float :delta, required: true

      t.timestamps
    end
  end
end
