class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def require_admin
    warden.authenticate! :admin
    @admin = warden.user
  end
end
