class StaticPagesController < ApplicationController
  def home
    if logged_in?
      redirect_to user_url
    end
  end
end
