class Record < ApplicationRecord
  belongs_to :conversation, class_name: "Transaction", dependent: :destroy, optional: true
  belongs_to :user, dependent: :destroy, optional: true
  has_many :rends


  validates_presence_of :item_name, :time_limit, :start_time, :description, :user_id, :transaction_id

  def set_time
    created_at.strftime("%m/%d %H:%M")
  end

  enum current_situation: { rend: 0, borrow: 1, square: 2 }

  validate :date_before_start
  validate :date_before_finish



  def date_before_start
    return if start_time.blank?
    errors.add(:start_time, "は今日以降のものを選択してください") if start_time =! DateTime.now
  end

  def date_before_finish
    return if time_limit.blank? || start_time.blank?
    errors.add(:time_limit, "は開始日以降のものを選択してください") if time_limit < start_time
  end
  
end
