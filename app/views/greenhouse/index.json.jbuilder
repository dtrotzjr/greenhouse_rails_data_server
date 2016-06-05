json.array!(@greenhouses) do |greenhouse|
  json.extract! greenhouse, :id
  json.url greenhouse_url(greenhouse, format: :json)
end
