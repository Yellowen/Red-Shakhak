json.array!(@advertises) do |advertise|
  json.extract! advertise, :id, :title, :description, :show_for_days, :cost, :cost_per_day, :get_size, :category, :likes, :views
  json.tags advertise.tags.join(",")
  json.url advertise_url(advertise, format: :json)
end
