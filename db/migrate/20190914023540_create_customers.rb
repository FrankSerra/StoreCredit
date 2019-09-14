class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.decimal :balance
      t.datetime :lastmodified
      t.text :notes

      t.timestamps
    end
  end
end
