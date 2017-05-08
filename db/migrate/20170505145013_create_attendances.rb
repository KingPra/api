class CreateAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :attendances, primary_key: [:user_id, :meetup_id] do |t|
      t.references :user, foreign_key: true
      t.references :meetup, foreign_key: true

      t.timestamps
    end

  end
end
