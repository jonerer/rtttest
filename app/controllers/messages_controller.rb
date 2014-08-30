class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def create
    m = Message.create(message_params)
    redirect_to m
  end

  def show
    @m = Message.find(params[:id])
    render :json => @m
  end

  private
    def message_params
      params.require(:message).permit(:text)
    end
end
