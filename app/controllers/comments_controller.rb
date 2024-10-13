class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :set_quote, only: %i[new create]
  before_action :require_login, except: [:index, :show]

  # GET /comments or /comments.json
  def index
    @quote = Quote.find(params[:quote_id]) 
    @comments = @quote.comment
  end

  #when you wnat to show a comment, look for the quote it refers to and find the comments of that quote.
  #find one comment based on IDs
  # GET /comments/1 or /comments/1.json
  def show
    @quote = Quote.find(params[:quote_id]) 
    @comment = @quote.comment.find(params[:id]) 
  end

  #when a new quote is being created lod a new comment and load the quote it refers to 
  # GET /comments/new
  def new
    @quote = Quote.find(params[:quote_id])  # Ensure this line is present
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  #each comment has to save the user who wrote it and the quote that it refers to 
  # POST /comments or /comments.json
  def create
    @quote = Quote.find(params[:quote_id])
    @comment = Comment.new(comment_params)
    @comment.User_id = params[:comment][:user_id] 
    @comment.Quote_id = params[:comment][:quote_id] 
    @comment.datePosted = Time.current
    

    respond_to do |format|
      if @comment.save
        format.html { redirect_to quote_comments_path(@quote), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  #don't allow update if comments

  # DELETE /comments/:id or /comments/:id.json
def destroy
  @comment = Comment.find(params[:id])

  respond_to do |format|
    if @comment.destroy
      format.html { redirect_to quote_comments_url(@comment.Quote_id), notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    else
      format.html { redirect_to quote_comments_url(@comment.Quote_id), alert: "Comment could not be destroyed." }
      format.json { render json: @comment.errors, status: :unprocessable_entity }
    end
  end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end
    def set_quote
      @quote = Quote.find(params[:quote_id]) 
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:comment)
    end
end
