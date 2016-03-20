json.array!(@answers) do |answer|
  json.extract! answer, :id, :question_id, :text, :user_id, :rating
  json.url answer_url(answer, format: :json)
end
