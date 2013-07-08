json.array!(@advertises) do |advertise|
  json.extract! advertise, :title, :description, :show_for_days, :cost, :cost_per_day
  json.url advertise_url(advertise, format: :json)
end
