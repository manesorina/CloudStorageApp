class ApplicationController < ActionController::Base
  
  def not_found
    render file: Rails.root.join('public', '404.html'), status: :not_found, layout: false
  end

  
  protected

  def after_sign_in_path_for(resource)
    files_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end



  
end
