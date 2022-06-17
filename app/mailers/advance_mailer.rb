class AdvanceMailer < ApplicationMailer

    def send_the_day_before
      @records = Record.where(current_situation: "borrow").or(Record.where(current_situation: "rend"))
      @records.each do |record|
       if record.time_limit == DateTime.tomorrow #期日前日で

        @transaction = Transaction.find(record.transaction_id)

        target1 = User.find(@transaction.render_id)
        target2 = User.find(@transaction.borrower_id) 

        mail to: "#{target1.email},#{target2.email}"
        mail subject: "返済期日が迫っております"
 
      end

    end
 
  end
end