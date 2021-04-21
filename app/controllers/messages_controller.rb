class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end

end

# 問題４
# @messageには、Message.newで生成した、Messageモデルのインスタンス情報を代入する。
# @roomには、Room.find(params[:room_id])と記述することで、paramsに含まれているroom_idを代入する。

# @tweet.comments.new(tweet_params)では、直前で取得した@tweetに紐づくCommentモデルのインスタンスを生成している。
# has_manyのアソシエーションを組んでいれば、親モデルのインスタンス.子モデルの複数形(小文字).new
# という記述方法で、親モデルのインスタンスに紐づく子モデルのインスタンスを生成できる。

