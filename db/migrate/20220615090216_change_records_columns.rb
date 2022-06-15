class ChangeRecordsColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :records, :rending_state , :boolean 
    remove_column :records, :borrowing_state , :boolean
    remove_column :records, :rend_id , :integer
    remove_column :records, :borrow_id , :integer
    add_column :records, :current_situation , :integer

  end
end
