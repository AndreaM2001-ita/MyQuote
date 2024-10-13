class PhilosophersController < ApplicationController
  before_action :set_philosopher, only: %i[ show edit update destroy ]

  # GET /philosophers or /philosophers.json
  def index
    @philosophers = Philosopher.all
  end

  # GET /philosophers/1 or /philosophers/1.json
  def show
  end

  # GET /philosophers/new
  def new
    @philosopher = Philosopher.new
  end

  # GET /philosophers/1/edit
  def edit
  end

  def create
    @philosopher = Philosopher.new(philosopher_params)
  
    respond_to do |format|
      #check if first name, last name and birth year are present as mandatory for creation
      if @philosopher.firstName.blank? || @philosopher.lastName.blank? || @philosopher.birthYear.blank?
        @philosopher.errors.add(:base, "First Name , Last Name and Birth Year are mandatory Fields.")
      end
      # check if birth year is after today's date -> impossible
      if @philosopher.birthYear.to_i > Date.current.year
        @philosopher.errors.add(:birthYear, "must be less than or equal to the current year.")
      end
  
      #if the death year is present check that the death yeqh is  after the birth year
      if @philosopher.deathYear.present? && @philosopher.deathYear.to_i <= @philosopher.birthYear.to_i
        @philosopher.errors.add(:deathYear, "must be greater than the birth year.")
      end
      
      #if a phisosopher with those attributes already exists, no need to create a new one ->check
      existing_philosopher = Philosopher.find_by(
        firstName: @philosopher.firstName,
        lastName: @philosopher.lastName,
        birthYear: @philosopher.birthYear
      )
      
      #phisosopher exists in databse
      if existing_philosopher
        @philosopher.errors.add(:base, "Philosopher with the same first name, last name, and birth year already exists.")
      end
      
      #arethere any errors for the philosopher 
      if @philosopher.errors.empty?
        begin
          if @philosopher.save
            format.html { redirect_to philosopher_url(@philosopher), notice: "Philosopher was successfully created." }
            format.json { render :show, status: :created, location: @philosopher }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @philosopher.errors, status: :unprocessable_entity }
          end
        rescue StandardError => e
          #left out errors are caught here
          @philosopher.errors.add(:base, "An error occurred: #{e.message}")
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @philosopher.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @philosopher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /philosophers/1 or /philosophers/1.json
  def update
    respond_to do |format|
      # when updating the three initial fields are still mandatory
      if @philosopher.firstName.blank? || @philosopher.lastName.blank? || @philosopher.birthYear.blank?
        @philosopher.errors.add(:base, "All philosopher fields (first name, last name, birth year) cannot be empty.")
      end

      #check that birth year is smaller tahn today's year
      if @philosopher.birthYear.to_i > Date.current.year
        @philosopher.errors.add(:base, " Birth Year must be less than or equal to the current year.")
      end
  
      #if the death year is present make suyre that it is after birth year mathematically
      if @philosopher.deathYear.present? && @philosopher.deathYear.to_i <= @philosopher.birthYear.to_i
        @philosopher.errors.add(:base, " Death Year must be greater than the birth year.")
      end
      #check if the same phisosopher exists, if he does do not create a new one
      existing_philosopher = Philosopher.find_by(
        firstName: @philosopher.firstName,
        lastName: @philosopher.lastName,
        birthYear: @philosopher.birthYear
      )
  
      if existing_philosopher
     
        @philosopher.errors.add(:base, "Philosopher with the same first name, last name, and birth year already exists.")
      end
     
      if @philosopher.errors.empty?
        if @philosopher.update(philosopher_params)
          format.html { redirect_to philosopher_url(@philosopher), notice: "Philosopher was successfully updated." }
          format.json { render :show, status: :ok, location: @philosopher }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @philosopher.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @philosopher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /philosophers/1 or /philosophers/1.json
  def destroy
    @philosopher.destroy

    respond_to do |format|
      format.html { redirect_to philosophers_url, notice: "Philosopher was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_philosopher
      @philosopher = Philosopher.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def philosopher_params
      params.require(:philosopher).permit(:firstName, :lastName, :birthYear, :deathYear, :biography)
    end
end
