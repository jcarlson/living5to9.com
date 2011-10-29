class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate!
    authenticate_or_request_with_http_digest(Living5to9Com::Admin::Realm) do |username|
      Living5to9Com::Admin::Users[username]
    end unless (Rails.env == 'development')
  end

end
