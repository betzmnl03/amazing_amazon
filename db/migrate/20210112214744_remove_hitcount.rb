class RemoveHitcount < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :hit_count, :integer
  end
end
