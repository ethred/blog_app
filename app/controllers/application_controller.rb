class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.includes(posts: %i[comments likes]).first
  end
end
