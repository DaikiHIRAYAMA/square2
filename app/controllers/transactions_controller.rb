class TransactionsController < ApplicationController
  before_action :authenticate_user!
  
    def index
        @transactions = Transaction
        #.where(render_id: current_user.id)
        #.or(Transaction.where(borrower_id: current_user.id))
        .where("render_id = ? OR borrower_id = ?",'current_user.id', 'current_user.id')
    end



    def create
        unless @transaction = Transaction.where(render_id: params[:render_id], borrower_id: params[:borrower_id])
        .or(Transaction.where(render_id: params[:render_id], borrower_id: params[:borrower_id])).take
          @transaction = Transaction.create!(transaction_params)
        end
        redirect_to transaction_messages_path(@transaction)
    end
    
      private
    
      def transaction_params
        params.permit(:render_id, :borrower_id)
      end




end
