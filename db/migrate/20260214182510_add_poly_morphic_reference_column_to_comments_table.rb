class AddPolyMorphicReferenceColumnToCommentsTable < ActiveRecord::Migration[8.1]
  def change
    remove_column :comments, :post_id
    remove_column :comments, :user_id

    add_reference :comments, :commentable, polymorphic: true, index: true
  end
end
