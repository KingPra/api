class CreateUnknownUser < ActiveRecord::Migration[5.0]
  def up
    User.create!(first_name: "unknown", last_name: "user", email: "unknown")
  end

  def down
    User.find_by(email: "unknown").destroy
  end
end
