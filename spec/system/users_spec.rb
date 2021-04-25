require 'rails_helper'

RSpec.describe "ユーザーログイン機能", type: :system do
  it 'ログインしていない状態でトップページにアクセスした場合、サインインページに移動する' do
    # トップページに遷移する
      visit root_path
    # ログインしていない場合、サインインページに遷移していることを確認する。
      expect(current_path).to eq(new_user_session_path)
  end
  
  it 'ログインに成功し、トップページに遷移する'do
    # 予め、ユーザーをDBに保存する。
    @user = FactoryBot.create(:user)
    # サインインページへ移動する
    visit new_user_session_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq(new_user_session_path)
    # すでに保存されているユーザーのemailとpasswordを入力する
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    # ログインボタンをクリックする。
    click_on('Log in')
    # トップページに遷移している事を確認する。
    expect(current_path).to eq(root_path)
  end

  it 'ログインに失敗し、再びサインインページに戻ってくる' do
    
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    # トップページに遷移する
    visit root_path
    # ログインしていない場合、サインインページに遷移している事を確認する。
    expect(current_path).to eq(new_user_session_path)
    # 誤ったユーザー情報を入力する。
    fill_in 'Email', with: "hogehoge@mail"
    fill_in 'Password', with: "hogehoge"
    # ログインボタンをクリックする。
    click_on('Log in')
    # サインインページに戻ってきていることを確認する。
    expect(current_path).to eq(new_user_session_path)
  end

  
end

# 問題1
# ログインしていないユーザーがトップページにアクセスした場合の挙動
# visit root_path
# visitは visit 〇〇_pathと記述すると、００のページへ遷移することを表現できる。
# RequestSpecで学んだgetと似ているが、getはあくまでリクエストを送るだけのことを意味したが、
# visitはそのページに移動できる。ということ

# ログインしていない状態のユーザーがトップページにアクセスした場合は、サインインページに遷移される。
# 「current_path」は、今アクセスしているページの情報が含まれている。
# expect(X).to eq(Y)メソッドを用いて、「x」を「current_path」、「Y」を
# 「new_user_session_path」とする。

# 問題２
# ユーザーがログインに成功した後に、トップページに遷移する挙動を確認する
# @user = FactoryBot.create(:user)
# データベースにcreateメソッドでユーザーをテスト用のDBに保存する。
# 保存したユーザーは、ログインを行っていないので、ログイン画面に遷移
# vsiit new_user_session_path
# その後、保存したユーザーの「メールアドレス」や「パスワード」をfill_inメソッドで入力を行う。
# その後click_onメソッドでLog inをクリックしてログイン
# そしてログインが成功した場合は、トップページに遷移