class RoomUser < ApplicationRecord
  belongs_to :room
  belongs_to :user
end

# 問題５
# 1つのチャットルームには、２人のユーザーが存在します。
# また、１人のユーザーは複数のチャットルームに参加できます。
# どのユーザーがどのチャットルームに参加しているかを管理するのが、中間テーブルである「room_userテーブルとなる。」