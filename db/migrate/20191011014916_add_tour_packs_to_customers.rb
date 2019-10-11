class AddTourPacksToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :tourpacks, :int
  end
end
