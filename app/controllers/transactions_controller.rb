class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_index , only: [:all_index , :rents_index , :borrows_index]


    def index
        @transactions = Transaction#.with_user(current_user)
        .where(render_id: current_user.id)
        .or(Transaction.where(borrower_id: current_user.id))
        # .where("render_id = ? OR borrower_id = ?",'current_user.id', 'current_user.id')
    end



    def create

        unless @transaction = Transaction
          #.where("render_id = ? OR borrower_id = ? OR render_id = ? OR borrower_id = ?" ,'params[:render_.id]', 'params[:borrower_id]','params[:render_.id]', 'params[:borrower_id]').take
        .where(render_id: params[:render_id], borrower_id: params[:borrower_id])
        .or(Transaction.where(render_id: params[:borrower_id], borrower_id: params[:render_id])).take
      
          @transaction = Transaction.create!(transaction_params)
        end
        redirect_to transaction_records_path(@transaction)
    end


    def all_index #全ての自分と関わる貸し借りを表示する
    end


    def rents_index #貸している物を表示する

     # @records = Record#.with_user(current_user)
     # .where(user: current_user , current_situation: "rend")
     # .or(Record.where.not(user: current_user) .where(current_situation: "borrow"))

    end

    def borrows_index #貸している物を表示する
      @records = Record
      .where(user: current_user , current_situation: "borrow")

     # .or(Record.where.not(user: current_user) .where(current_situation: "rend"))
    end


    
      private
    
      def transaction_params
        params.permit(:render_id, :borrower_id)
      end

      def record_params
        params.require(:record)
        .permit(
            :user_id,
            :transaction_id,
            :item_name,
            :time_limit,
            :start_time,
            :description,
            :current_situation) #ここに追加
    end

    def set_transaction
      @transaction = Transaction.find(params[:transaction_id])
    end

    def set_index
      @transactions = Transaction
      .where(render_id: current_user.id)
      .or(Transaction.where(borrower_id: current_user.id))
    end

end
