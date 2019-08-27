namespace :sns do
  desc "DBをtwitterユーザーの最新情報に更新するタスク"
  task twitter: :environment do
    Sns::Tw.batch
  end
end
