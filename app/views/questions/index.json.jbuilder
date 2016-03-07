json.array!(@questions) do |question|
  json.extract! question, :id, :text, :answer_on, :rating
  json.url question_url(question, format: :json)
end
