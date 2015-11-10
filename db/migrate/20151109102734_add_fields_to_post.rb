class AddFieldsToPost < ActiveRecord::Migration
  def change
  	add_column :posts, :view_untill, :date
  end
end
