FactoryBot.define do
  factory :message do
    content {Faker::Lorem.sentence}
    association :user
    association :room

    after(:build) do |message|
      message.image.attach(io: File.open("public/images/test_image.png"), filename: 'test_image.png')
    end
  end
end

# afterメソッド
# afterメソッドは任意の処理の後に指定の処理を実行する事ができる。
# after(:build)とする事で、インスタンスがbuildされた後に指定の処理を実行できる。
# 8行目の記述では、io: File.openで設定したパスのファイル（public/images/test_image.png）を、test_image.pngというファイル名で保存をしています。

# もしKeyErrorというエラーが発生した場合は、下記コマンドを実行した後、もう一度コンソールでFactoryBotの確認を行ってください。
# # コンソールを終了する
# pry(main)> exit

# # Springを停止
# % spring stop