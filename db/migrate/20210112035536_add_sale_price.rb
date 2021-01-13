class AddSalePrice < ActiveRecord::Migration[6.1]
  def change 
    add_column :products, :sale_price, :integer
  end
end
