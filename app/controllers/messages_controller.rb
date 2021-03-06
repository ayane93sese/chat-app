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
      render :index
    end
  end

  private

  def message_params #プライベートメソッドとしてmessage_paramsを定義
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id) #contentをmessagesテーブルへ保存できるようにする
  end
end