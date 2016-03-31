class Admin::BaseController < ApplicationController
  before_action :require_platform_admin

  def require_platform_admin
    render file: "/public/404" unless platform_admin?
  end
end
