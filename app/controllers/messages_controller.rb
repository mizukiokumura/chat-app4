class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    @messages = @room.messages.includes(:user)
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user)
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

# 問題７
# チャットルームに紐づいている全てのメッセージ(@room.messages)を@messagesとして定義。
# この場合、メッセージに紐づくユーザー情報の取得に、メッセージの数と同じ回数のアクセスが必要になるので、
# N+1問題が発生する
# その場合は、includesを使用して解消し、全てのメッセージ情報に紐づくユーザー情報を、includes(:user)と記述することにより、
# ユーザー情報を１度のアクセスでまとめて取得が可能になる。
# この時に投稿に失敗した時の処理にも、同様に@messagesを定義しておくことでm
# renderを用いて、投稿に失敗した@messageの情報を保持しつつindex.html.erbを参照する事ができる。
