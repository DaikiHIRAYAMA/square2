class AdvanceMailer < ApplicationMailer

    def send_the_day_before
      @records = Record.where(current_situation: "borrow").or(Record.where(current_situation: "rend"))
      @records.each do |record|
        
       if record.time_limit.strftime("%Y-%m-%d") == DateTime.tomorrow.strftime("%Y-%m-%d") #期日前日で

        @transaction = Transaction.find(record.transaction_id)


        mail to: "#{ User.find(@transaction.render_id).email},#{User.find(@transaction.borrower_id).email }"
        mail subject: "返済期日が迫っております"
 
        end

      end
    end
end