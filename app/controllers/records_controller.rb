class RecordsController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    before_action :set_transaction
    #before_action :correct_user, only: [:show] これを自分と相手の場合だけにしたらOK

    def index
        @records = @transaction.records.order(:created_at)
        @records.where.not(user_id: current_user.id).update_all(read: true)
        if @records.length > 10
          @records = @records.last(10)
        end
        @record = Record.new
    end

    def create
        @record = @transaction.records.build(record_params)
        if @record.save!
            redirect_to transaction_records_path(@transaction)
        else
            render 'index'
        end
    end

    def show
        @record = Record.find(params[:id])
    end

    def edit
    end

    def update
        @record = Record.find(params[:id])
        if @record.update_attribute(:current_situation, "square")
            redirect_to transaction_records_path(@record.transaction_id)
        else
            render :edit
        end
    end

    def push_mail

        target = @transaction.target_user(current_user)

        PushMailer.send_when_push(target).deliver #宛先を相手にしないといけない
        #push_mail_transaction_record_path
        flash[:notice] = "催促メールを送信しました" 
        redirect_to transaction_records_path(@transaction)
    end

    private


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

    def correct_user #ここに相手も追加する。
        @user = User.find(params[:id])
        redirect_to current_user unless current_user?(@user)
    end
end
