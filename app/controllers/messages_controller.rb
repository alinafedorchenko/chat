class MessagesController < ApplicationController
  before_action :set_user

  def index
    @messages = Message.current_dialog_messages(params[:user_id], current_user.try(:id))
    @messages.where(recipient_id: current_user.try(:id)).update(read: true)
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @message.sender_id = current_user.try(:id)
    @message.recipient_id = params[:user_id]
    respond_to do |format|
      if @message.save
        format.html { redirect_to user_messages_path }
      else
        format.html { render :new }
      end
    end
  end

  private
    def message_params
      params.require(:message).permit(:topic, :content, :recipient_id)
    end

  def set_user
    @user = User.find(params[:user_id])
  end
end
