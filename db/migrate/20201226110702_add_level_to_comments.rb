class AddLevelToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :level, :string, default: "0"
  end
end
