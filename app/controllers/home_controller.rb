class HomeController < ApplicationController
  def index

    @quotes=Quote.includes(:philosopher).all.order(datePosted: :desc)
  end
end
