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

  private

  def room_params
    params.require(:room).permit(:name, user_ids: [])
  end
end

# 配列に対して保存を許可したい場合は、キー(user_ids)に対して[]を「値」として記述する。