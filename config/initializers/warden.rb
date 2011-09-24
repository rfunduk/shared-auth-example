Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.default_strategies :admin
  manager.failure_app = Admin::SessionsController.action(:new)
end

Warden::Manager.serialize_into_session do |user|
  user.id.to_s
end

Warden::Manager.serialize_from_session do |id|
  Administrator.find( id )
end

Warden::Strategies.add( :admin ) do
  def valid?
    params[:email] || params[:password]
  end

  def authenticate!
    begin
      admin = Administrator.where( :email => params[:email] ).first
      raise StandardError unless admin.authenticate( params[:password] )
      success! admin
    rescue
      admin = nil
      fail!
    end
  end
end

class MountedAdminAppAuth
  def initialize( app )
    @app = app
  end

  def call( env )
    env['rack.session.options'] = {
      key: '_shared-auth-example_session',
      secret: SharedAuthExample::Application.config.secret_token
    }
    env['warden'].authenticate!
    @app.call( env )
  end
end

# here's a micro app
require 'sinatra/base'

module MrMicro
  class Web < Sinatra::Base
    use Rack::Logger
    set :logging, true

    get '/' do
      "<h3>Mr. Micro!</h3><p>Seeing this means you're an admin in the parent app!</p>"
    end
  end
end

MrMicro::Web.use MountedAdminAppAuth
