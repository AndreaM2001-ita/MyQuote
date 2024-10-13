class SearchController < ApplicationController
  def index 
    Rails.logger.debug "Search Type: #{params[:search_type]}"
    if params[:search_type] == "Search Quotes"
      philosophers_query = params[:philosopher_query]
      if philosophers_query.present?
        # Split the query into parts
        query_parts = philosophers_query.split(' ')
        
        if query_parts.size == 1
          # search with one word
          search_query = "%#{query_parts.first}%"
          @quotematch = Quote.joins(:philosopher)
                            .where("philosophers.firstName LIKE ? OR philosophers.lastName LIKE ?", 
                                    search_query, 
                                    search_query)
                                    .where(isPublic: true)
                            .distinct
        elsif query_parts.size >= 2
          # search with 2 words
          first_name_query = "%#{query_parts.first}%"
          last_name_query = "%#{query_parts.last}%"
          @quotematch = Quote.joins(:philosopher)
                            .where("philosophers.firstName LIKE ? AND philosophers.lastName LIKE ?", 
                                    first_name_query, 
                                    last_name_query)
                                    .where(isPublic: true)
                            .distinct
        end
      else
        @quotematch = [] # If no query is present
      end
    elsif params[:search_type] == "Search for Anonymous"
      @quotematch = Quote.where(philosopher_id: nil)
    else
      @quotematch = [] # Default case
    end
  end
end