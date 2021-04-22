class Message < ApplicationRecord

  belongs_to :user
  belongs_to :room
  has_one_attached :image

  validates :content, presence: true
end

# has_one_attachedメソッド
# 各レコードとファイルを１対１の関係で紐づけるメソッド
# has_one_attachedを記述したモデルの各レコードは、それぞれ１つのファイルを添付できるようになる。
# 書き方は、
# has_one_attaced :ファイル名
# :ファイル名には、添付するファイルがわかるような名前にする。
# この記述により、モデル.ファイル名で、添付されたファイルにアクセスできるようになる。
# また、このファイル名は、そのモデルが紐づいてフォームから送られるパラメーターのキーにもなる。
