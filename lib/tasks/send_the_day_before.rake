
namespace :send_the_day_before do
    desc '返済期日前日にメールを送信' #解説
    task send_the_day_before: :environment do  #タスク名
        AdvanceMailer.send_the_day_before.deliver_now #実行したい処理
        puts 'メールを送信しました'
    end
end
