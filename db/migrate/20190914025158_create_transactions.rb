class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.text :note
      t.datetime :stamp
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
