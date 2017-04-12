class AddTitleAndDescriptionToCredits < ActiveRecord::Migration[5.0]
  def change
    add_column :credits, :title, :string, default: ''
    add_column :credits, :description, :string, default: ''
  end
end
