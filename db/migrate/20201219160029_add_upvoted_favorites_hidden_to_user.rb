class AddUpvotedFavoritesHiddenToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :hidden_submissions, :uuid, array: true
    add_column :users, :upvoted_submissions, :uuid, array: true
    add_column :users, :upvoted_comments, :uuid, array: true
    add_column :users, :favorite_submissions, :uuid, array: true
    add_column :users, :favorite_comments, :uuid, array: true
    add_column :users, :karma, :integer, default: 0
    add_column :users, :about, :text
    add_column :users, :showdead, :boolean, default: false
    add_column :users, :noprocrast, :boolean, default: false
    add_column :users, :max_visit, :integer, default: 20
    add_column :users, :minaway, :integer, default: 180
    add_column :users, :delay, :integer, default: 0
  end
end
