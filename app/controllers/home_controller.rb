class HomeController < ApplicationController
  def index

    @quotes=Quote.includes(:Philosopher).take(3)
  end
end
