class RemovePrivateFromArticles < ActiveRecord::Migration[7.0]
  def change
    remove_column :articles, :private, :string
  end
end
