class AddTextToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :text, :text
  end
end
