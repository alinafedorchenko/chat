class NotReadMessagesController < ApplicationController
  def index
    @messages = current_user ? current_user.received_messages.not_read : []
    @messages.update(read: true)
  end
end
