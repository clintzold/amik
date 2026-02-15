class RenameLikesIntegerColumnToLikesCounter < ActiveRecord::Migration[8.1]
  def change
    rename_column :posts, :likes, :likes_counter
    rename_column :comments, :likes, :likes_counter
  end
end
