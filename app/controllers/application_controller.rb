class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end

# 問題５
# railsでは、悪意のあるユーザーの入力に対してセキュリティ対策を行わないと保存できない仕組みがあります。
# 通常のテーブルに保存する際はストロングパラメータを使用しましたが、deviseを使ったモデルの場合は方法が異なります。
# application_controllerにbefore_actionを使用しているため、全てのアクションが実行される前に、before_aftion
# :configure_permitted_parameters, if: :decise_controller?が実行される事になります。
# deviseのコントローラーから呼び出された場合は、configure_permitted_parametersメソッドが呼ばります。
# deviseをインストールすることで、devise_parameter_sanitizerメソッドが使えるようになり、deviseでユーザー登録をする場合に使用でき、
# 「特定のカラムを許容する」メソッドがdevise_parameter_sanitizer
# 今回は「nameカラム」を追加したので、このメソッドを使用し、「name」キーの内容の保存を
# permitメソッドで許可しています。