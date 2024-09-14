class HomeController < ApplicationController
  def index

    @quotes=Quote.includes(:Philosopher).take(3)
  end

  def urecipes
    @quotes = Quote.includes(:Philosopher).where(user_id: session[:user_id])
   end
end
