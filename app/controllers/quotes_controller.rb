class QuotesController < ApplicationController
  before_action :set_quote, only: %i[ show edit update destroy ]
  before_action :require_login, except: [:index, :show]

  # GET /quotes or /quotes.json
  def index
    @quotes = current_user.Quotes
  end

  # GET /quotes/1 or /quotes/1.json
  def show
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
    @categories = Category.all
    @selected_category_id = @quote.category_quotes.first&.category_id
    @quote.build_philosopher
    @users=User.all
  end

  # GET /quotes/1/edit
  def edit
    @quote = Quote.find(params[:id])

    if @quote.philosopher.present?
      @philosopher = @quote.philosopher
      @anonymous = false
    else
      @anonymous = true
      @quote.build_philosopher
    end
  
    @categories = Category.all
    @selected_category_id = @quote.category_quotes.first&.category_id
  end

  # POST /quotes or /quotes.json
  def create
    @quote = Quote.new(quote_params)
    @quote.datePosted = Time.current
    @quote.User_id = params[:quote][:user_id] # Corrected the attribute name to snake_case
    @categories = Category.all
  
    respond_to do |format|
     
      if @quote.quoteText.blank?
        @quote.errors.add(:base, "Quote cannot be empty")
      
  
    else
      if quote_params[:anonymous] == "true"
        @quote.philosopher = nil
      else
        philosopher_params = quote_params[:philosopher_attributes]
  
   
        if philosopher_params[:birthYear].to_i > Date.current.year
          @quote.errors.add(:base, "Philosopher's birth year must be less than or equal to the current year.")
        end

        existing_philosopher = Philosopher.find_by(
          firstName: philosopher_params[:firstName],
          lastName: philosopher_params[:lastName],
          birthYear: philosopher_params[:birthYear]
        )
  
        if existing_philosopher
    
          if philosopher_params[:deathYear].present? && existing_philosopher.deathYear.nil?
            if philosopher_params[:birthYear].to_i>philosopher_params[:deathYear].to_i
              @quote.errors.add(:base, "Death Year of Phisosopher cannot be before the Birth Year")
            else
              existing_philosopher.deathYear = philosopher_params[:deathYear]
              existing_philosopher.save
            end
          end
          @quote.philosopher = existing_philosopher
        else
 
          @quote.build_philosopher(philosopher_params)
        end
      end
  
    end
      if @quote.errors.empty?
        begin
        
          if @quote.save
            if params[:quote][:category_id].present?
              CategoryQuote.create(quote_id: @quote.id, category_id: params[:quote][:category_id])
            end
  
            format.html { redirect_to quote_url(@quote), notice: "Quote was successfully created." }
            format.json { render :show, status: :created, location: @quote }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @quote.errors, status: :unprocessable_entity }
          end
        rescue StandardError => e
          @quote.errors.add(:base, "Philosopher cannot be empty, unless anonymous")
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @quote.errors, status: :unprocessable_entity }
        end
      else
        unless quote_params[:anonymous] == "true"
          @quote.build_philosopher(quote_params[:philosopher_attributes]) if @quote.philosopher.nil?
        end
        
        @selected_category_id = params[:quote][:category_id]
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end
  
  

  # PATCH/PUT /quotes/1 or /quotes/1.json
  def update
  @quote = Quote.find(params[:id])  
  @categories = Category.all
  
  respond_to do |format|
    if quote_params[:anonymous] == "true"
      @quote.philosopher&.destroy
      @quote.philosopher = nil
    else
      philosopher_params = quote_params[:philosopher_attributes]

    
      if philosopher_params[:firstName].blank? || philosopher_params[:lastName].blank? || philosopher_params[:birthYear].blank?
        @quote.errors.add(:base, "Philosopher details must be provided.")
      else
        
        if philosopher_params[:birthYear].to_i > Date.current.year
          @quote.errors.add(:base, "Philosopher's birth year must be less than or equal to the current year.")
        else
          existing_philosopher = Philosopher.find_by(
            firstName: philosopher_params[:firstName],
            lastName: philosopher_params[:lastName],
            birthYear: philosopher_params[:birthYear]
          )
  
          if existing_philosopher
            existing_philosopher.update(philosopher_params)
            @quote.philosopher = existing_philosopher 
          else
            @quote.build_philosopher(philosopher_params)
          end
          if existing_philosopher
    
            if philosopher_params[:deathYear].present? && existing_philosopher.deathYear.nil?
              if philosopher_params[:birthYear].to_i>philosopher_params[:deathYear].to_i
                @quote.errors.add(:base, "Death Year of Phisosopher cannot be before the Birth Year")
              else
                existing_philosopher.update(philosopher_params)
              end
            end
            @quote.philosopher = existing_philosopher
          else
   
            @quote.build_philosopher(philosopher_params)
          end
        end
      end
    end

   
    filtered_quote_params = quote_params.except(:philosopher_attributes)

    # Only attempt to update if there are no errors
    if @quote.errors.empty?
      if @quote.update(filtered_quote_params)
        @quote.category_quotes.destroy_all
        
        if params[:quote][:category_id].present?
          category_id = params[:quote][:category_id]
          CategoryQuote.create(quote_id: @quote.id, category_id: category_id)
        end
        
        format.html { redirect_to quote_url(@quote), notice: "Quote was successfully updated." }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    else
      unless quote_params[:anonymous] == "true"
        @quote.build_philosopher(quote_params[:philosopher_attributes]) if @quote.philosopher.nil?
      end
      @selected_category_id = params[:quote][:category_id]
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @quote.errors, status: :unprocessable_entity }
    end
  end
end

  # DELETE /quotes/1 or /quotes/1.json
  def destroy
    @quote.destroy

    respond_to do |format|
      format.html { redirect_to quotes_url, notice: "Quote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quote_params
      params.require(:quote).permit(:quoteText, :isPublic, :datePosted,  :anonymous, 
          philosopher_attributes: [:Philosopher_id, :firstName, :lastName, :birthYear, :deathYear, :biography]
          )
    end
end
