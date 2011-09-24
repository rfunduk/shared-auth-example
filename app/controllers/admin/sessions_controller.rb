class Admin::SessionsController < ApplicationController
  def new
  end

  def create
    params[:email] = params[:email].downcase
    warden.authenticate! :admin
    redirect_to '/admin'
  end

  def destroy
    warden.logout
    redirect_to new_admin_session_url
  end
end
