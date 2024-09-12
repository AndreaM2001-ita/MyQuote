json.extract! user, :id, :firstName, :lastName, :email, :password_digest, :status, :is_admin, :created_at, :updated_at
json.url user_url(user, format: :json)
