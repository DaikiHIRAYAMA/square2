class AdvanceMailer < ApplicationMailer

    def send_the_day_before
      @records1 = Record.where(current_situation: "borrow").or(Record.where(current_situation: "rend")) #貸している状態か借りている状態のもの
      @records2 = @records1.where(time_limit: DateTime.tomorrow.strftime("%Y-%m-%d"))
       #{DateTime.tomorrow}" ).or(@records1.where("time_limit > #{DateTime.yesterday}"))
       #期日が明日のもの      
      @records2.each do |record| #それら一つづつに

        AdvanceMailer.send_mail(record).deliver_now



      #  mail to: "#{ User.find(@transaction.render_id).email},#{User.find(@transaction.borrower_id).email }"
      #  mail subject: "返済期日が迫っております"
 
        end
    end

     def send_mail(record)

      @transaction = Transaction.find(record.transaction_id)

      mail to: "#{ User.find(@transaction.render_id).email},#{User.find(@transaction.borrower_id).email }"
      mail subject: "返済期日が迫っております"
     end
end