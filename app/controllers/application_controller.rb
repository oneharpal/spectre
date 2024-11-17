class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # before_action :set_paper_trail_whodunnit
  #   rescue_from StandardError do |e|
  #   flash[:alert] = e.message
  #   redirect_back(fallback_location: root_path)
  # end
end
