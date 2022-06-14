class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.integer :render_id
      t.integer :borrower_id

      t.timestamps
    end
    add_index :transactions, :render_id
    add_index :transactions, :borrower_id
    add_index :transactions, [:render_id, :borrower_id], unique: true
  end
end
