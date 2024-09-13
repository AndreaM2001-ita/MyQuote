class SearchController < ApplicationController
  def index
    philosophers_query = params[:philosopher_query]
    if philosophers_query.present?
      # Split the query into parts
      query_parts = philosophers_query.split(' ')
      
      if query_parts.size == 1
        # search only with last or first name 
        search_query = "%#{query_parts.first}%"
        @quotematch = Quote.joins(:Philosopher)
                           .where("philosophers.firstName LIKE ? OR philosophers.lastName LIKE ?", 
                                  search_query, 
                                  search_query)
                           .distinct
      elsif query_parts.size >= 2
        # Search with first and last anem 
        first_name_query = "%#{query_parts.first}%"
        last_name_query = "%#{query_parts.last}%"
        @quotematch = Quote.joins(:Philosopher)
                           .where("philosophers.firstName LIKE ? AND philosophers.lastName LIKE ?", 
                                  first_name_query, 
                                  last_name_query)
                           .distinct
      end
    end
  end
end