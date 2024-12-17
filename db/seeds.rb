# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Admin
admin = Admin.find_or_create_by!(email: ENV["ADMIN_EMAIL"]) do |admin|
  admin.password = ENV["ADMIN_KEY"]
end



#User

olivia = User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.handle_name = "Olivia"
  user.password = "password"
  user.user_id = "olivia-1"
end

james = User.find_or_create_by!(email: "james@example.com") do |user|
  user.handle_name = "James"
  user.password = "password"
  user.user_id = "james-2"
end


#Olivaの投稿

tokyo_trip = Itinerary.find_or_create_by!(title: "東京旅行") do |itinerary|
  itinerary.region = "関東"
  itinerary.user = olivia
  itinerary.day_number = 2
end

tokyo_trip.destinations.find_or_create_by!(name: "観光地A") do |destination|
  destination.day_number = 1
  destination.start_time = "09:00"
  destination.address = "東京都テスト市サンプル区123-456"
  destination.notes = "歴史的な観光地"
end


tokyo_trip.destinations.find_or_create_by!(name: "レストランB") do |destination|
  destination.day_number = 1
  destination.start_time = "11:30"
  destination.address = "東京都テスト市サンプル区789-10"
  destination.notes = "オムライスがおいしいお店"
end


tokyo_trip.destinations.find_or_create_by!(name: "植物園C") do |destination|
  destination.day_number = 1
  destination.start_time = "14:00"
  destination.address = "東京都テスト市サンプル区1112-13"
  destination.notes = "東京都最大の植物園"
end

tokyo_trip.destinations.find_or_create_by!(name: "旅館D") do |destination|
  destination.day_number = 1
  destination.start_time = "18:00"
  destination.address = "東京都テスト市サンプル区1415-16"
  destination.notes = "美肌になれる温泉"
end

tokyo_trip.destinations.find_or_create_by!(name: "遊園地E") do |destination|
  destination.day_number = 2
  destination.start_time = "9:00"
  destination.address = "東京都テスト市サンプル区1718-19"
  destination.notes = "日本で一番大きな遊園地"
end


#jamesの投稿

osaka_trip = Itinerary.find_or_create_by!(title: "大阪旅行") do |itinerary|
  itinerary.region = "関西"
  itinerary.user = james
  itinerary.day_number = 2
end

osaka_trip.destinations.find_or_create_by!(name: "水族館A") do |destination|
  destination.day_number = 1
  destination.start_time = "10:00"
  destination.address = "大阪府テスト市サンプル区123-456"
  destination.notes = "イルカショーがおすすめ"
end


osaka_trip.destinations.find_or_create_by!(name: "城B") do |destination|
  destination.day_number = 1
  destination.start_time = "14:00"
  destination.address = "大阪府テスト市サンプル区789-10"
  destination.notes = "歴史に残る城"
end


osaka_trip.destinations.find_or_create_by!(name: "旅館C") do |destination|
  destination.day_number = 1
  destination.start_time = "17:00"
  destination.address = "大阪府テスト市サンプル区1112-13"
  destination.notes = "新鮮な海鮮を客室でいただけます"
end

osaka_trip.destinations.find_or_create_by!(name: "観光地D") do |destination|
  destination.day_number = 2
  destination.start_time = "11:00"
  destination.address = "大阪府テスト市サンプル区1415-16"
  destination.notes = "歴史上有名な建造物を見学"
end



