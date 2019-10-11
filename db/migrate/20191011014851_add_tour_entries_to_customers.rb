class AddTourEntriesToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :tourentries, :int
  end
end
