json.array!(@comments) do |comment|
  json.extract! comment, :text
  json.url comment_url(comment, format: :json)
end