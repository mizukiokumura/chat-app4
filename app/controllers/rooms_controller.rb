class RoomsController < ApplicationController

  def index
  end
  
  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    redirect_to root_path
  end

  private

  def room_params
    params.require(:room).permit(:name, user_ids: [])
  end
end

# 配列に対して保存を許可したい場合は、キー(user_ids)に対して[]を「値」として記述する。

# 問題１０
# routesにdestroyをルーティングを記載した後、roomsコントローラーにdestroyアクションを定義し、
# どのチャットルームを削除するのかを特定したいので.fin(params[:id])を使用して削除したいチャットルームの情報を取得する。
# destroyアクションは、削除するだけなので、ビューの表示は必要ない。
# そのため、インスタンス変数ではなく変数としてroomを定義し、destroyメソッドを使用する。
# destroyメソッドが実行されたら、root(roomsのindex)にリダイレクトする記述をする。