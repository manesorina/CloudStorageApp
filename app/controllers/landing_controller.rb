class LandingController < ApplicationController
  def index
    if user_signed_in?
      redirect_to files_paths 
    end
  end
end