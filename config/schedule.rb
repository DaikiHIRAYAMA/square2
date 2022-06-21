# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

require File.expand_path(File.dirname(__FILE__) + '/environment')
env :PATH, ENV['PATH']
rails_env = ENV['RAILS_ENV'] || :development
# cronを実行する環境変数をセット
set :environment, rails_env
# cronのログの吐き出し場所
set :output, "#{Rails.root}/log/cron.log"

#env :PATH, ENV['PATH']
# ログファイルの出力先
#set :output, 'log/cron.log'
#set :output, "/log/cron.log"
#set :environment, :development

 every 10.minutes do
# every 1.days, at: '9:00 am' do
  runner "AdvanceMailer.send_the_day_before"
#rake 'send_the_day_before:send_the_day_before'

end

# Learn more: http://github.com/javan/whenever
