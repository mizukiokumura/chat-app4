require 'rails_helper'

RSpec.describe "メッセージ投稿機能", type: :system do
  before do
    @room_user = FactoryBot.create(:room_user)
  end

  context '投稿に失敗した時' do
    it '送る値がからの為、メッセージの送信に失敗すること' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する。
      click_on(@room_user.room.name)
      #DBに保存されていないことを確認する。
      expect{
        find('input[name="commit"]').click
      }.not_to change {Message.count }
      # 元のページに戻ってくることを確認する。
      expect(current_path).to eq(room_messages_path(@room_user.room))
    end
  end

  context '投稿に成功した時' do
    it 'テキストの投稿に成功すると、投稿一覧に遷移して、投稿した内容が表示されている' do
      # サインインする
      sign_in(@room_user.user)
      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)
      # 値をテキストフォームに入力する。
      fill_in "message_content", with: "hogehoge"
      # 送信した値がDBに保存されていることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Message.count}.by(1)
      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq(room_messages_path(@room_user.room))
      # 送信した値がブラウザに表示されていることを確認する。
      expect(page).to have_content("hogehoge")
    end

    it '画像の投稿に成功すると、投稿一覧に遷移して、投稿した画像が表示されている' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')

      # 画像選択フォームに画像を添付する
      attach_file("message[image]", image_path, make_visible: true)
      # 送信した値がDBに保存されていることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change{ Message.count}.by(1)
      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq(room_messages_path(@room_user.room))
      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector('img')
    end

    it 'テキストと画像の投稿に成功すること' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')

      # 画像選択フォームに画像を添付する
      attach_file("message[image]", image_path, make_visible: true)
      # 値をテキストフォームに入力する
      fill_in "message_content", with: "hogehoge"
      # 送信した値がDBに保存されていることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change{Message.count}.by(1)
      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content("hogehoge")
      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector("img")
    end
  end
end

# どうして下記のような書き方ができるのか
# before do 
#   # 中間テーブルを作成して、associationによりusersテーブルとroomsテーブルのレコードも作成する。
#   @room_user = FactoryBot.create(:room_user)
# end
# これはroomusers.rbに定義したFactoryBotのassociationメソッドによるものです。
# assosiactionを利用すると、associationで定義した「インスタンス」も一緒に生成される。
# この生成したユーザー情報を用いてログインする。その後、生成したチャットルームのページに遷移する。
# spec/system/messages_spec.rb
#   # サインインする。@room_userに紐づくuserが生成されているため、@room_user.userというアソシエーションの記述で取得できる
#   sign_in(@room_user.user)

#   # 作成されたチャットルームへ遷移する。roomについても上と同様。最終的にnameカラムの値を取得しclick_onメソッドの引数にして、チャットルームの名前のリンクをクリックしている
#   click_on(@room_user.room.name)

#   チャットルームのページへ遷移した後からそれぞれの処理を再現しましょう。

# また、Rails.root.join('public/images/test_image.png')という記述によって前のカリキュラムで作成したテスト用の画像のパスを生成している。

# ・Rails.root.join
# Rails.rootとすると、このRailsアプリケーションのトップ階層のディレクトリまでの絶対パスを取得できる。
# パス情報に対してjoinメソッドを利用することで、引数として渡した文字列でのパス情報を、Rails.rootのパスの情報につける事ができる。
# Rails.rootとjoin
# # /Users/ユーザー名/projects/に「sample-app」というRailsアプリがある場合
# pry(main)> Rails.root
# => #<Pathname:/Users/ユーザー名/projects/sample-app>

# pry(main)> Rails.root.join('public/images/test_image.png')
# => #<Pathname:/Users/ユーザー名/projects/sample-app/public/images/test_image.png>

# 問題４
# チャットルームに入りメッセージを送信する際に、何も入力せずに送信したため、送信が失敗している挙動を確認する。
# # DBに保存されていないことを確認する。
# expect {
#   find('input[name="commit"]').click
# }.not_to change {Message.count}
# メッセージを送信するために、fingメソッドを使用して、送信ボタンの'input[name="commit"]'要素を取得して、
# クリックする。しかし、何も入力を行っていないので、データベースのmessageモデルのカウントが増えていないことを確認している。

# attach_fileメソッド
# タイプがfileのinput要素、つまり画像などのアップロード用のinput要素に、画像投稿のテスト用の画像を添付(アタッチ)できるメソッド
# 第一引数に画像をアップロードするinput要素のname属性の値、第二引数にアップロードする画像のパス、第三引数以降にはオプションで様々な値を撮る事ができる。
# 今回は予めimage_pathという変数に、テスト用の画像のパスを代入しているのでそれを使う。
# attach_fileメソッド
# attach_file('message[image]', image_path)
# ただし、この画像アップロード用のinput要素は、hidden属性がついていて非表示になっているので、
# このような状態のinput要素に画像を添付するには、オプションの引数を渡す必要がある。第三引数に
# make_visible: trueを渡す。
# attach_file('message[image]', image_path, make_visible: true)