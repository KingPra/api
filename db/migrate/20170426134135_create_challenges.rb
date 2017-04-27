class CreateChallenges < ActiveRecord::Migration[5.0]
  def change
    create_table :challenges do |t|
      t.integer :github_issue_id
      t.string :body, default: ""
      t.string :state, default: ""
      t.string :title
      t.string :url, default: ""
      t.json :labels, default: []

      t.timestamps
    end
  end
end
