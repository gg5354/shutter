class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  prepend_before_action :authenticate_user!
  after_filter :set_xsrf_token

  def set_xsrf_token
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def verified_request?
    if respond_to?(:valid_authenticity_token?, true)
      super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
    else
      super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
    end
  end
end
