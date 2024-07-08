class AuthController < ApplicationController
  include Authable

  def index
  end

  def login
    @app, @app_redirect, @client_id, @redirect_uri, @response_type, @state = auth_params

    raise "id_token implicit flow supported only" unless @response_type.eql? "id_token"
  end

  def authenticate
    app, app_redirect, client_id, redirect_uri, response_type, state = auth_params

    username = params.require(:username)
    password = params.require(:password)

    user = User.find_by(username: username)&.authenticate(password)
    if user
      token = Authable.id_token_for user

      form = [['id_token', token]]
      form.push(['state', state]) if state.present?

      uri = URI.parse app_redirect.uri
      uri.fragment = URI.encode_www_form(form)

      redirect_to uri.to_s
    else
      redirect_back(fallback_location: login_path, alert: "Invalid username and/or password combo")
    end
  end
end
