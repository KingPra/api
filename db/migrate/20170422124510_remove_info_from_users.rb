class RemoveInfoFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :info
    add_column :users, :codewars_handle, :string, default: ''
    add_column :users, :github_handle, :string, default: ''
    add_column :users, :linkedin_url, :string, default: ''
    add_column :users, :resume_site_url, :string, default: ''
    add_column :users, :stackoverflow_url, :string, default: ''
    add_column :users, :twitter_handle, :string, default: ''
  end
end
