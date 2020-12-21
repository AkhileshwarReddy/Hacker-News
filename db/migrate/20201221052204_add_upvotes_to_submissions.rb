class AddUpvotesToSubmissions < ActiveRecord::Migration[6.1]
  def change
    add_column :submissions, :upvotes, :integer, default: 1
  end
end
