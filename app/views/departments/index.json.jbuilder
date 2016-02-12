json.array!(@departments) do |department|
  json.extract! department, :code, :description
  json.url department_url(department, format: :json)
end