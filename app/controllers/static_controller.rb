class StaticController < ApplicationController
  before_action :authenticate_user!, only: [:info]
  def index
  end

  def info
  end
end
