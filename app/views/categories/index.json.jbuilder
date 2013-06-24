json.array!(@categories) do |category|
  json.extract! category, :name, :cssclass
  json.url category_url(category, format: :json)
end