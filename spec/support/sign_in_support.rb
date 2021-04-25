module SignInSupport
  def sign_in(user)
    visit root_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on("Log in")
    expect(current_path).to eq(root_path)
  end
end

# ログイン処理は、この後のメッセージ送信機能やチャット削除機能のテストの際にも使用するため、その度に毎回同じ記述をするのは非効率です。
# 一連の処理をまとめて、別の場所から呼び出すことで、短い記述でログイン処理を表現することが可能になる。

# 上記のようにsign_inメソッドを定義する事で、spec配下のテストファイルで、sign_inメソッドを使用する準備が整った。

# 最後に、このspec/supportディレクトリ配下のファイルが、テスト実行時に読み込まれるように設定すr。
# spec/rails_helper.rb
# # 中略

# # コメントアウトを外す
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# # 中略

# RSpec.configure do |config|
#   # 追記
#   config.include SignInSupport

#   # 中略

# この記述により、sign_inメソッドを利用できるようにしました。