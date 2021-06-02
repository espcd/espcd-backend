class TokensController < ApplicationController
  before_action :set_token, only: [:show, :update, :destroy]
  before_action :require_session!

  def index
    json_response(session_user.tokens)
  end

  def show
    json_response(@token)
  end

  def create
    @token = Token.create!(token_params)
    json_response(@token, :created)
  end

  def update
    @token.update!(token_params)
    json_response(@token)
  end

  def destroy
    @token.destroy!
    head :no_content
  end

  private

  def token_params
    params
      .require(:token)
      .permit(:id, :title, :token, :user_id)
  end

  def set_token
    @token = Token.find(params[:id])
  end
end
