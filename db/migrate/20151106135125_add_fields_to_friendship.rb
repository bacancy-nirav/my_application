class AddFieldsToFriendship < ActiveRecord::Migration
  def change
  	 add_column :friendships, :is_declined, :boolean
  end
end
