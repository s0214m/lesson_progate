class HomeController < ApplicationController
  before_action :be_login,{only:[:top]}

  def top
  end

  def about
  end

end
