require 'jwt'

module Authable
  extend ActiveSupport::Concern

  def self.private_key
    OpenSSL::PKey::RSA.new(ENV['AUTH_PRIVATE_KEY'])
  end

  def self.public_key
    OpenSSL::PKey::RSA.new(ENV['AUTH_PUBLIC_KEY'])
  end

  def self.id_token_for(user)
    payload = { user_id: user.id }
    JWT.encode(payload, private_key, 'RS256')
  end

  def self.user_from_id_token(token)
    payload, header = JWT.decode(token, public_key, true, { algorithm: 'RS256'}) rescue return nil

    User.includes(:roles).find(payload['user_id'])
  end

  private
    def auth_params
      client_id = params.require(:client_id)
      redirect_uri = params.require(:redirect_uri)
      response_type = params.require(:response_type)
      state = params[:state]

      app = App.find_by(client_id: client_id)
      raise unless app

      app_redirect = app.app_redirects.find_by(uri: redirect_uri)
      raise unless app_redirect

      [app, app_redirect, client_id, redirect_uri, response_type, state]
    end

    def bearer_token
      patt = /^Bearer /
      header = request.authorization
      header.gsub(patt, '') if header.present? && header.match(patt)
    end

    def require_auth
      return head :forbidden unless bearer_token.present?

      @current_user = Authable.user_from_id_token(bearer_token)

      head :forbidden if @current_user.nil?
    end

    def require_role_any_of(names)
      raise unless @current_user

      assigned = @current_user.roles.map{ |r| r.name }

      head :forbidden unless (assigned & names).size > 0
    end
end