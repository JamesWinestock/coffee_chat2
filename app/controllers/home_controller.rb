class HomeController < ApplicationController

  def index
      if signed_in?
      @user = User.find(current_user)
    end
  end
end
