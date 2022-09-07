class AirlinesController < ApplicationController
  def index
    @airlines = Airline.all.order('name ASC')
  end

  def show
    @airline = Airline.find(params[:id])
  end
end
