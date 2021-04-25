require 'rails_helper'

RSpec.describe "チャットルームの削除機能", type: :system do
  before do
    @room_user = FactoryBot.create(:room_user)
  end

  it 'チャットルームを削除すると、関連するメッセージが全て削除されていること' do
    # サインインする
    sign_in(@room_user.user)
    # 作成されたチャットルームへ遷移する。
    click_on(@room_user.room.name)
    # メッセージ情報を5つDBに追加する。 
    FactoryBot.create_list(:message, 5, room_id: @room_user.room.id, user_id: @room_user.user.id)
    # 「チャットを終了する」ボタンをクリックすることで、作成した5つのメッセージが削除されていることを確認する。
    expect {
      find_link('チャットを終了する', href: room_path(@room_user.room)).click
    }.to change{@room_user.room.messages.count}.by(-5)
    # トップページに遷移していることを確認する。
    expect(current_path).to eq(root_path)
  end
end

# create_list
# FactoryBotの設定ファイルに存在しているレコードを、複数作成したい場合に使用するメソッド。
# create_listを用いることで、一度に複数のテストデータを生成できる。
# 書き方は
# FactoryBot.create_list(:hoge, 3)
# 第一引数には作成したいインスタンスをシンボル型で記述し、第二引数に作成するレコードの個数の数値を設定する。

# 問題８
# チャットルームを削除した際に、投稿されていたメッセージも、同時に削除されたかを確認後、トップページに遷移する挙動を確認する。
# create_listを用いる事で、messageテーブルのレコードをまとめて生成できる。
# メッセージが削除されているかを確認するために、create_listを用いて、メッセージと紐づいたユーザーとチャットルームを中間テーブル生成する。
# その後、find_linkメソッドで「チャットを終了する,href:room_path(@rooom_user.room)」を取得し、クリック。
