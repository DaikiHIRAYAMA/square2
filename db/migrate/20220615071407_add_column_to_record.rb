class AddColumnToRecord < ActiveRecord::Migration[6.0]
  def change
    add_column :records, :item_name, :string
    add_column :records, :time_limit, :datetime
    add_column :records, :start_time, :datetime
    add_column :records, :description, :string
    add_column :records, :rending_state , :boolean , default: false
    add_column :records, :borrowing_state , :boolean , default: false
  end
end
