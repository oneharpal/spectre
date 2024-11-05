class MessagesController < ApplicationController
  before_action :set_room, only: :create
  before_action :authenticate_user!

  def create
    @room.messages.create!(message_params.merge(user: current_user))
    respond_to do |format|
      format.html { head :no_content }          # Empty HTML response
      format.turbo_stream { head :no_content }  # Empty Turbo Stream response
    end
  end

  def index
    @messages = Message.all
  end

  private

    def set_room
      @room = Room.find(params[:room_id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:content)
    end
end
