class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def name
    render html: "peter kona"
  end
end
