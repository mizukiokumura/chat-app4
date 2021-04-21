Rails.application.routes.draw do
  devise_for :users
  root to: "rooms#index"
  resources :users, only: [:edit, :update]
  resources :rooms, only: [:new, :create,] do
    resources :messages, only: [:index, :create]
  end
end
# 問題３
# 新規チャットルームの作成で動くアクションは「new」と「create」のみなので、上記のようなコードになる。

