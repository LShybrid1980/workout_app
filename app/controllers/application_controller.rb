class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def after_sign_in_path_for(resource)
    workout_datas_path
  end
end
