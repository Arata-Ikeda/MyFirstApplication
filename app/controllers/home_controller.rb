class HomeController < ApplicationController
  def index
    @is_logged_in = current_user.present?
  end
end
