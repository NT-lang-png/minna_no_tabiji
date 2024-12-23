json.data do

  json.earliest do
    if @earliest
      json.id @earliest.id
      json.name @earliest.name
      json.day_number @earliest.day_number
      json.start_time @earliest.start_time
      json.address @earliest.address
      json.latitude @earliest.latitude
      json.longitude @earliest.longitude
    end
  end

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