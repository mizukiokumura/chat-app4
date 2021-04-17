Rails.application.routes.draw do
  devise_for :users
  get 'messages/index'
  root to: "messages#index"
  resources :users, only: [:edit, :update]
  resources :rooms, only: [:new, :create]
end
# 問題３
# 新規チャットルームの作成で動くアクションは「new」と「create」のみなので、上記のようなコードになる。