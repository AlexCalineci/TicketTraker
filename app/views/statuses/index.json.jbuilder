json.array!(@statuses) do |status|
  json.extract! status, :code, :description
  json.url status_url(status, format: :json)
end