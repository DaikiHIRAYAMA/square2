class RecordsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_transaction
    before_action :correct_users

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

    def note
        @record = Record.find(params[:id])


            respond_to do |format|
              format.html
              format.pdf do
               # require 'prawn'
                pdf = Prawn::Document.new(
                  :page_size       => "A4",      # 用紙サイズ
                  :page_layout     => :portrait, # 用紙向き ( 縦:portrait、横:landscape )
                  :left_margin     => 20,        # 余白（左）
                  :right_margin    => 20         # 余白（右）
                )
                pdf.font 'app/assets/fonts/KosugiMaru-Regular.ttf'
                pdf.text "借用書", :align => :center, :size => 58
                pdf.move_down 30

                pdf.text "貸し借りするもの",:size => 16, :align => :center
                pdf.text "#{@record.item_name}",:size => 32, :align => :center
                pdf.move_down 10






        if @record.user == current_user 

            if @record.current_situation == "rend" 

                rows = [
                    ['貸した人', '借りた人'],
                    ["#{@record.user.name}", "#{@transaction.target_user(current_user).name}"]
                  ]


                  pdf.text "#{@record.user.name}は#{@transaction.target_user(current_user).name}に", :size => 16, :align => :center
                  pdf.text "#{@record.item_name}を確かに借用しました", :size => 16, :align => :center
            
        
            elsif @record.current_situation == "borrow" 
                rows = [
                    ['貸した人', '借りた人'],
                    ["#{@transaction.target_user(current_user).name}", "#{@record.user.name}"]
                  ]


                  pdf.text "#{@record.user.name}は#{@transaction.target_user(current_user).name}に", :size => 16, :align => :center
                  pdf.text "#{@record.item_name}を確かに借用しました", :size => 16, :align => :center
            else

                rows = [
                    ['貸し借りをした人', '貸し借りをした人'],
                    ["#{@record.user.name}", "#{@transaction.target_user(current_user).name}"]
                  ]

                pdf.text "こちらの貸し借りは終了しています。自分が主体",:size => 20, :align => :center

                

            end 
        else
        
            if @record.current_situation == "rend"
                rows = [
                    ['貸した人', '借りた人'],
                    ["#{@transaction.target_user(current_user).name}", "#{current_user.name}"]
                  ]


                pdf.text "#{current_user.name}は#{@transaction.target_user(current_user).name}に", :size => 16, :align => :center
                pdf.text "#{@record.item_name}を確かに借用しました", :size => 16, :align => :center
        
            elsif @record.current_situation == "borrow"

                rows = [
                    ['貸した人', '借りた人'],
                    ["#{current_user.name}", "#{@transaction.target_user(current_user).name}"]
                  ]


                pdf.text "#{@transaction.target_user(current_user).name}は#{current_user.name}に", :size => 16, :align => :center
                pdf.text "#{@record.item_name}を確かに借用しました", :size => 16, :align => :center
        
            else
                rows = [
                    ['貸し借りをした人', '貸し借りをした人'],
                    ["#{current_user.name}", "#{@transaction.target_user(current_user).name}"]
                  ]

                pdf.text "こちらの貸し借りは終了しています。ほかのユーザーが主体",:size => 20, :align => :center


            end
        end

        pdf.table rows, cell_style: { width: 277} do
            cells.borders = []
             row(0).height = 26
             row(0).align = :center
             row(0).size = 16
             row(1).height = 41
             row(1).align = :center
             row(1).size = 32


         end

         pdf.move_down 20




                pdf.move_down 20

               # pdf.image "app/assets/images/sample.jpg", :position => :center


        
                #貸したときと借りたとき
        
                pdf.move_down 20
                pdf.text "記",:size => 22, :align => :center
                pdf.move_down 20
                pdf.text "返済期限：#{@record.time_limit.strftime("%Y年 %m月 %d日")}",:size => 20
                pdf.move_down 20
                pdf.text "詳細：#{@record.description}",:size => 20
                pdf.move_down 20
        
                pdf.text "以上",:size => 18, :align => :right
                pdf.move_down 20
                pdf.text "借用日：#{@record.start_time.strftime("%Y年 %m月 %d日")}",:size => 20, :align => :right
        
        
                send_data pdf.render,
                  filename: "#{@record.id}.pdf",
                  type: 'application/pdf',
                  disposition: 'inline' # 外すとダウンロード
              end
            end
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

        PushMailer.send_when_push(target).deliver 
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

    def correct_users
        @transaction = Transaction.find(params[:transaction_id])
    unless  current_user.id == @transaction.render_id
        unless current_user.id == @transaction.borrower_id
        redirect_to current_user
    end
    end
    end
end
