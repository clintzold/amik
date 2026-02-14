class AddDefaultValueToLikesColumn < ActiveRecord::Migration[8.1]
  def change
    change_column_default :posts, :likes, from: nil, to: 0
    change_column_default :comments, :likes, from: nil, to: 0
  end
end
