json.array!(@comments) do |comment|
  json.extract! comment, :id, :text, :question_id, :comment_id, :rating, :user_id
  json.url comment_url(comment, format: :json)
end
