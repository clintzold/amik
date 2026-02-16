class CHangeAcceptedColumnToDefaultFalse < ActiveRecord::Migration[8.1]
  def change
    change_column_default :follows, :accepted, from: nil, to: false
  end
end
