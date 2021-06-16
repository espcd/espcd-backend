class BoardTypesController < ApplicationController
  before_action :set_board_type, except: [:index]

  before_action :require_session!

  def index
    @board_types = BoardType.all
    json_response(@board_types)
  end

  private

  def set_board_type
    @board_type = BoardType.find(params[:id])
  end
end
