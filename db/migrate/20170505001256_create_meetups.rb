class CreateMeetups < ActiveRecord::Migration[5.0]
  def change
    create_table :meetups do |t|
      t.date :meetup_date
      t.string :encrypted_verification_code
      t.string :encrypted_verification_code_iv
      t.string :name

      t.timestamps
    end
  end
end
