class RoomUser < ApplicationRecord
  belongs_to :room
  belongs_to :user
end

# 問題５
# 1つのチャットルームには、２人のユーザーが存在します。
# また、１人のユーザーは複数のチャットルームに参加できます。
# どのユーザーがどのチャットルームに参加しているかを管理するのが、中間テーブルである「room_userテーブルとなる。」

# 中間テーブルを通じて、レコードをテーブルに保存する方法
# Room.create(name: "ルーム1", user_ids: [1,2])
# user_idsというキー名がポイントで、モデル名 + _idsというキーを使用すると、
# そのキーは特別な意味を持ちます。roomという親要素を保存するときに、user_idsで所属させたいユーザー
# を「配列」で指定すると、その情報が「中間テーブルに保存される」という仕組みになっている。

# dependentオプション
# 親モデルを削除した時に、親モデルと関連している子モデルに対する挙動を指定するオプションです。
# :destroyを指定した時は、親モデルが削除された時に、それに紐づいている子モデルも一緒に削除される。
