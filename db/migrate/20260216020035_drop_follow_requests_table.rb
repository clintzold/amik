class DropFollowRequestsTable < ActiveRecord::Migration[8.1]
  def change
    drop_table :follow_requests
  end
end
