class MessagesController < ApplicationController
  def index
    if params[:last_id]
      @messages = Message.where('id > ?', params[:last_id])
    else
      @messages = Message.all
    end
    respond_to do |format|
      format.html { render }
      format.json { render :json => @messages }
    end
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
