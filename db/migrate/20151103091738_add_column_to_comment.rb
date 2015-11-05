class AddColumnToComment < ActiveRecord::Migration
  def change
    #add_column :comments, :post_id, :integer
    add_reference :comments, :post, index: true, foreign_key: true
  end
end
