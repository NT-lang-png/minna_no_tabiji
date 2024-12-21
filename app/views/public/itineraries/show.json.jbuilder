json.data do
  json.items do
    json.array!(@destinations) do |destination|
      json.id destination.id
      json.user do
        json.name destination.user.name
      end
      json.name destination.name
      json.day_number destination.day_number
      json.start_time destination.start_time
      json.address destination.address
      json.latitude destination.latitude
      json.longitude destination.longitude
    end  
  end
end