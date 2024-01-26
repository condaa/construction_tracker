class ApplicationController < ActionController::API

  # no sessions yet
  def current_user
    @current_user ||= User.find(params[:user_id])
  end

  def per_page
    10
  end

end
