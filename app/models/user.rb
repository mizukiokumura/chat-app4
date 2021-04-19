class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :room_users
  has_many :rooms, through: :room_users
  has_many :messages


  validates :name, presence: true

end

# 問題１１
# Userモデルに、validates :name, presence: trueを追記します。
# nameカラムに、presence: trueを設けることで、からの場合はDBに保存しないという
# バリデーションを設定しています。
# つまり、ユーザー登録時に「name」を空欄にして登録しようとすると、エラーが発生する。