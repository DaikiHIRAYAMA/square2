class RecordsController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    before_action :set_transaction

    def index
        @records = @transaction.records.order(:created_at)
        @records.where.not(user_id: current_user.id).update_all(read: true)
        if @records.length > 10
          @records = @records.last(10)
        end
        @records = Record.new
    end

    def create
        @record = @transaction.records.build(record_params)
        if @record.save
            redirect_to transaction_records_path(@transaction)
        else
            render 'index'
        end
    end

    private

    def record_params
        params.require(:record).permit(:user_id, :rend_id , :borrow_id, :transaction_id) #ここに追加
    end
  
    def set_transaction
      @transaction = Transaction.find(params[:transaction_id])
    end

end
