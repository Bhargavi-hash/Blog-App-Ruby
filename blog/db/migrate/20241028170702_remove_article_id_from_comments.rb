class RemoveArticleIdFromComments < ActiveRecord::Migration[7.1]
  def change
    remove_column :comments, :article_id, :integer
  end
end
