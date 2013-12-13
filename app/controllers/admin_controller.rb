class AdminController < ApplicationController
  before_filter :authenticate_user!
  # TODO: check authorization

  def index
  end
end