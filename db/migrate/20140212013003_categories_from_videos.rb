class CategoriesFromVideos < ActiveRecord::Migration
  def change
    remove_column :videos, :categories, :string
  end
end
