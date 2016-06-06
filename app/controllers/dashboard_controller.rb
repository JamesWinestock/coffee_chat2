class DashboardController < ApplicationController
  def index
      if signed_in?
      @user = User.find(current_user.id)
    end
  end
end
