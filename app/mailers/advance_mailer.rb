class AdvanceMailer < ApplicationMailer
    def send_the_day_before(user)
    mail to:      user.email,
    subject: 'これは期日前日に送られるめーる'
      @greeting = ""

    end
  end