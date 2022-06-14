class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.references :transaction, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :rend
      t.references :borrow
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
