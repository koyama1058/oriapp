class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:image, :nickname, :birthday, :gender_id, :introduction, :job_id, :hobby, :prefectures_id])
  end
end
