class UsersController < ApplicationController

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

end

# 問題６
# ユーザー編集に必要なルーティングは、editとupdateなので、
# routes.rbに resources :users, only: [:edit, :update]と書く
# 次にrails g controller usersコマンドで編集機能の実装に必要なusersコントローラーを作成する
# 作成ができたら、users_controller.rbに、editアクションを定義します。
# editアクションでは、ビューファイルを表示するだけなので、アクションの定義のみになる。

# 問題７
# Usersモデルの更新を行うupdateアクションをusersコントローラーに定義しましょう。
# ストロングパラメーターを使用し、user_paramsを定義します。
# user_paramsの中でpermitメソッドを使用し、「name」と「email」の編集を許可します。
# そして、ユーザー情報が格納されているcurrent_userメソッドを使用して、ログインしているユーザーの
# 情報を更新する。

# 問題8
# updateアクションないで、保存できた場合とできなかった場合で条件分岐の処理を行います。
# current_user.updateに成功した場合、root(チャット画面)にリダイレクトします。
# 失敗した場合、render :editとeditのアクションを指定しているため、editのビューが表示される。

# renderメソッド
# renderは、呼び出すビューファイルを指定するメソッドです、コントローラー、ビューのどちらでも使えます。
# ここで、renderとredirect_toの違いを確認しておきましょう。
# renderとredirecit_toのいずれも、実行するとビューが表示されます。
# しかし、表示までの経路が異なる。
# redirect_toの場合は、新たなリクエストを送信された時と同じ動きになるので、再度コントローラーを経由してビューが表示されるのに対して、
# renderの場合は、新たにリクエストされる事なくそのままビューが表示される。
# これにより、「元のインスタンス変数の値が上書きされるかどうか」が違う。