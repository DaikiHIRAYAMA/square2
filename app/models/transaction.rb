class Transaction < ApplicationRecord
    belongs_to :render, foreign_key: :render_id, class_name: 'User', dependent: :destroy
    belongs_to :borrower, foreign_key: :borrower_id, class_name: 'User', dependent: :destroy
    has_many :records, dependent: :destroy
    validates_uniqueness_of :render_id, scope: :borrower_id


    def target_user(current_user)
        if render_id == current_user.id
          User.find(borrower_id)
        elsif borrower_id == current_user.id
          User.find(render_id)
        end
     end

end
