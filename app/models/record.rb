class Record < ApplicationRecord
  belongs_to :transaction
  belongs_to :user
  belongs_to :rend

  #validates_presence_of :content, :conversation_id, :user_id

  def set_time
    created_at.strftime("%m/%d %H:%M")
  end
end
