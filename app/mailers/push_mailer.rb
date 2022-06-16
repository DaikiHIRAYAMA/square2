class PushMailer < ApplicationMailer
    def send_when_push(user)
      @user = user
      mail  to: user.email,
            subject: "そろそろ返しや"
    end
  end