class ApplicationController < ActionController::Base
  include JSONAPI::ActsAsResourceController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery unless: -> { request.format.json? }

  protected

  def not_found
    render json: {
      errors:
        [{ code: 404,
           status: 404,
           title: 'not_found',
           detail: 'Record not found' }]
    }, status: :not_found
  end
end
