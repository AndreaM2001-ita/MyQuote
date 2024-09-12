json.extract! comment, :id, :comment, :datePosted, :User_id, :Quote_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
