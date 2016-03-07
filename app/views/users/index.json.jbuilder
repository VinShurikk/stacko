json.array!(@users) do |user|
  json.extract! user, :id, :login, :password, :last_login
  json.url user_url(user, format: :json)
end
