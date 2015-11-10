class ChangeFieldsToFriendship < ActiveRecord::Migration
  def change
  	change_column :friendships, :is_declined, :boolean, :default => false
  end
end
