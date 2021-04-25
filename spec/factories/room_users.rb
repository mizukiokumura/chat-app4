FactoryBot.define do
  factory :room_user do
    association :user
    association :room
  end
end

# associationメソッドは、RSpecのレッスンでも登場した、FactoryBotによって
# 生成されるモデルを関連づけるメソッド。
# この記述で中間テーブルのテスト用モデルにアソシエーションが定義できた