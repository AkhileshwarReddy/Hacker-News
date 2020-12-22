class SetDefaultsToUpvotedFavoriteHiddenForUser < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :hidden_submissions, []
    change_column_default :users, :upvoted_submissions, []
    change_column_default :users, :upvoted_comments, []
    change_column_default :users, :favorite_submissions, []
    change_column_default :users, :favorite_comments, []
  end
end
