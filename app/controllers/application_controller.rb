class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :gon_user

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { render json: [exception.message], status: :forbidden}
      format.html { redirect_to root_url, alert: exception.message, status: :forbidden}
      format.js   { head :forbidden }
    end
  end

  private

  def gon_user
    gon.is_user_signed_in = user_signed_in?
  end
end
