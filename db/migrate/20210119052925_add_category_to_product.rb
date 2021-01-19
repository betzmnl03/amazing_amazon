class AddCategoryToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :category, :text
    add_column :products, :image, :string
  end
end
