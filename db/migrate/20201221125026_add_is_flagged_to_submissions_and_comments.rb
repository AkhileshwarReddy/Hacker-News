class AddIsFlaggedToSubmissionsAndComments < ActiveRecord::Migration[6.1]
  def change
    add_column :submissions, :is_flagged, :boolean, default: false
    add_column :comments, :is_flagged, :boolean, default: false
  end
end
