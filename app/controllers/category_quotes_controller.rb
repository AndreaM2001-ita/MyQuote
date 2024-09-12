class CategoryQuotesController < ApplicationController
  before_action :set_category_quote, only: %i[ show edit update destroy ]

  # GET /category_quotes or /category_quotes.json
  def index
    @category_quotes = CategoryQuote.all
  end

  # GET /category_quotes/1 or /category_quotes/1.json
  def show
  end

  # GET /category_quotes/new
  def new
    @category_quote = CategoryQuote.new
  end

  # GET /category_quotes/1/edit
  def edit
  end

  # POST /category_quotes or /category_quotes.json
  def create
    @category_quote = CategoryQuote.new(category_quote_params)

    respond_to do |format|
      if @category_quote.save
        format.html { redirect_to category_quote_url(@category_quote), notice: "Category quote was successfully created." }
        format.json { render :show, status: :created, location: @category_quote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category_quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /category_quotes/1 or /category_quotes/1.json
  def update
    respond_to do |format|
      if @category_quote.update(category_quote_params)
        format.html { redirect_to category_quote_url(@category_quote), notice: "Category quote was successfully updated." }
        format.json { render :show, status: :ok, location: @category_quote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category_quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /category_quotes/1 or /category_quotes/1.json
  def destroy
    @category_quote.destroy

    respond_to do |format|
      format.html { redirect_to category_quotes_url, notice: "Category quote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category_quote
      @category_quote = CategoryQuote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_quote_params
      params.require(:category_quote).permit(:quote_id, :category_id)
    end
end
