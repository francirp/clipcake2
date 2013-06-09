class StaticController < ApplicationController

  def index
  end

  def authorize

    respond_to do |format|
      format.html
    end
  end

end
