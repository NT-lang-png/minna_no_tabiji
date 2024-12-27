# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Admin
admin = Admin.find_or_create_by!(email: ENV["ADMIN_EMAIL"]) do |admin|
  admin.password = ENV["ADMIN_KEY"]
end

# User
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

# Olivia's posts
hokkaido_trip = Itinerary.find_or_create_by!(title: "北海道旅行") do |itinerary|
  itinerary.region = :hokkaido
  itinerary.user = olivia
  itinerary.day_number = 2
  itinerary.key_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/hokkaido.jpeg"), filename:"hokkaido.jpeg")
end

hokkaido_trip.destinations.find_or_create_by!(name: "大通公園") do |destination|
  destination.day_number = 1
  destination.start_time = "09:00"
  destination.address = "北海道札幌市中央区大通"
  destination.notes = "広々とした公園で四季折々の景色が楽しめます"
end

hokkaido_trip.destinations.find_or_create_by!(name: "時計台") do |destination|
  destination.day_number = 1
  destination.start_time = "11:00"
  destination.address = "北海道札幌市中央区北1条西2丁目"
  destination.notes = "札幌の歴史的建造物"
end

hokkaido_trip.destinations.find_or_create_by!(name: "旭山動物園") do |destination|
  destination.day_number = 2
  destination.start_time = "10:00"
  destination.address = "北海道旭川市東旭川町倉沼"
  destination.notes = "動物たちの自然な姿が楽しめる動物園"
end

# James's posts
tohoku_trip = Itinerary.find_or_create_by!(title: "東北旅行") do |itinerary|
  itinerary.region = :tohoku
  itinerary.user = james
  itinerary.day_number = 3
  itinerary.key_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/onsen.jpeg"), filename:"onsen.jpeg")
end

tohoku_trip.destinations.find_or_create_by!(name: "松島湾クルーズ") do |destination|
  destination.day_number = 1
  destination.start_time = "10:00"
  destination.address = "宮城県松島町"
  destination.notes = "日本三景のひとつ、松島を船で巡る"
end

tohoku_trip.destinations.find_or_create_by!(name: "立石寺") do |destination|
  destination.day_number = 2
  destination.start_time = "09:30"
  destination.address = "山形県山形市山寺"
  destination.notes = "石段を登った先に広がる絶景"
end

tohoku_trip.destinations.find_or_create_by!(name: "銀山温泉") do |destination|
  destination.day_number = 3
  destination.start_time = "15:00"
  destination.address = "山形県尾花沢市銀山新畑"
  destination.notes = "大正ロマンを感じる温泉街"
end

# Additional regions
kanto_trip = Itinerary.find_or_create_by!(title: "関東旅行") do |itinerary|
  itinerary.region = :kanto
  itinerary.user = olivia
  itinerary.day_number = 2
  itinerary.key_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/asakusa.jpeg"), filename:"asakusa.jpeg")
end

kanto_trip.destinations.find_or_create_by!(name: "東京タワー") do |destination|
  destination.day_number = 1
  destination.start_time = "10:00"
  destination.address = "東京都港区芝公園4-2-8"
  destination.notes = "東京のランドマーク"
end

kanto_trip.destinations.find_or_create_by!(name: "浅草寺") do |destination|
  destination.day_number = 1
  destination.start_time = "13:00"
  destination.address = "東京都台東区浅草2-3-1"
  destination.notes = "日本最古のお寺"
end

kanto_trip.destinations.find_or_create_by!(name: "お台場") do |destination|
  destination.day_number = 2
  destination.start_time = "11:00"
  destination.address = "東京都港区台場"
  destination.notes = "ショッピングや観光が楽しめるエリア"
end

hokuriku_trip = Itinerary.find_or_create_by!(title: "北陸旅行") do |itinerary|
  itinerary.region = :hokuriku
  itinerary.user = james
  itinerary.day_number = 2
  itinerary.key_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/kenroku.jpeg"), filename:"kenroku.jpeg")
end

hokuriku_trip.destinations.find_or_create_by!(name: "兼六園") do |destination|
  destination.day_number = 1
  destination.start_time = "09:00"
  destination.address = "石川県金沢市兼六町1"
  destination.notes = "日本三名園の一つ"
end

hokuriku_trip.destinations.find_or_create_by!(name: "金沢21世紀美術館") do |destination|
  destination.day_number = 1
  destination.start_time = "13:00"
  destination.address = "石川県金沢市広坂1-2-1"
  destination.notes = "現代アートが楽しめる美術館"
end

hokuriku_trip.destinations.find_or_create_by!(name: "東茶屋街") do |destination|
  destination.day_number = 2
  destination.start_time = "10:00"
  destination.address = "石川県金沢市東山"
  destination.notes = "江戸時代の風情が残る茶屋街"
end

tokai_trip = Itinerary.find_or_create_by!(title: "東海旅行") do |itinerary|
  itinerary.region = :tokai
  itinerary.user = olivia
  itinerary.day_number = 3
  itinerary.key_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/jinjya.jpeg"), filename:"jinjya.jpeg")
end

tokai_trip.destinations.find_or_create_by!(name: "名古屋城") do |destination|
  destination.day_number = 1
  destination.start_time = "10:00"
  destination.address = "愛知県名古屋市中区本丸1-1"
  destination.notes = "金の鯱が有名なお城"
end

tokai_trip.destinations.find_or_create_by!(name: "熱田神宮") do |destination|
  destination.day_number = 1
  destination.start_time = "14:00"
  destination.address = "愛知県名古屋市熱田区神宮1-1-1"
  destination.notes = "名古屋の由緒ある神社"
end

tokai_trip.destinations.find_or_create_by!(name: "伊勢神宮") do |destination|
  destination.day_number = 2
  destination.start_time = "10:00"
  destination.address = "三重県伊勢市宇治館町"
  destination.notes = "日本最大級の神社"
end

tokai_trip.destinations.find_or_create_by!(name: "白川郷") do |destination|
  destination.day_number = 3
  destination.start_time = "13:00"
  destination.address = "岐阜県大野郡白川村"
  destination.notes = "世界遺産の合掌造り集落"
end

kansai_trip = Itinerary.find_or_create_by!(title: "関西旅行") do |itinerary|
  itinerary.region = :kansai
  itinerary.user = james
  itinerary.day_number = 2
  itinerary.key_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/yuniba.jpeg"), filename:"yuniba.jpeg")
end

kansai_trip.destinations.find_or_create_by!(name: "清水寺") do |destination|
  destination.day_number = 1
  destination.start_time = "09:00"
  destination.address = "京都府京都市東山区清水1丁目"
  destination.notes = "京都を代表する観光地"
end

kansai_trip.destinations.find_or_create_by!(name: "大阪城") do |destination|
  destination.day_number = 1
  destination.start_time = "14:00"
  destination.address = "大阪府大阪市中央区大阪城1-1"
  destination.notes = "日本の歴史を感じられる城"
end

kansai_trip.destinations.find_or_create_by!(name: "ユニバーサル・スタジオ・ジャパン") do |destination|
  destination.day_number = 2
  destination.start_time = "10:00"
  destination.address = "大阪府大阪市此花区桜島2丁目1-33"
  destination.notes = "世界的に有名なテーマパーク"
end

chugoku_trip = Itinerary.find_or_create_by!(title: "中国地方旅行") do |itinerary|
  itinerary.region = :chugoku
  itinerary.user = olivia
  itinerary.day_number = 2
end

chugoku_trip.destinations.find_or_create_by!(name: "厳島神社") do |destination|
  destination.day_number = 1
  destination.start_time = "09:00"
  destination.address = "広島県廿日市市宮島町1-1"
  destination.notes = "海に浮かぶ大鳥居が有名"
end

chugoku_trip.destinations.find_or_create_by!(name: "広島平和記念公園") do |destination|
  destination.day_number = 1
  destination.start_time = "14:00"
  destination.address = "広島県広島市中区中島町1"
  destination.notes = "平和を祈るモニュメントが立ち並ぶ"
end

chugoku_trip.destinations.find_or_create_by!(name: "大山") do |destination|
  destination.day_number = 2
  destination.start_time = "10:00"
  destination.address = "鳥取県西伯郡大山町"
  destination.notes = "中国地方最高峰の山"
end

shikoku_trip = Itinerary.find_or_create_by!(title: "四国旅行") do |itinerary|
  itinerary.region = :shikoku
  itinerary.user = james
  itinerary.day_number = 2
end

shikoku_trip.destinations.find_or_create_by!(name: "道後温泉") do |destination|
  destination.day_number = 1
  destination.start_time = "09:00"
  destination.address = "愛媛県松山市道後湯之町"
  destination.notes = "日本最古の温泉とされる"
end

shikoku_trip.destinations.find_or_create_by!(name: "栗林公園") do |destination|
  destination.day_number = 1
  destination.start_time = "14:00"
  destination.address = "香川県高松市栗林町1丁目20-16"
  destination.notes = "大名庭園の傑作"
end

shikoku_trip.destinations.find_or_create_by!(name: "鳴門の渦潮") do |destination|
  destination.day_number = 2
  destination.start_time = "11:00"
  destination.address = "徳島県鳴門市鳴門町"
  destination.notes = "世界有数の渦潮スポット"
end

kyushu_trip = Itinerary.find_or_create_by!(title: "九州旅行") do |itinerary|
  itinerary.region = :kyushu
  itinerary.user = olivia
  itinerary.day_number = 3
end

kyushu_trip.destinations.find_or_create_by!(name: "熊本城") do |destination|
  destination.day_number = 1
  destination.start_time = "09:00"
  destination.address = "熊本県熊本市中央区本丸1-1"
  destination.notes = "日本三大名城のひとつ"
end

kyushu_trip.destinations.find_or_create_by!(name: "阿蘇山") do |destination|
  destination.day_number = 2
  destination.start_time = "10:00"
  destination.address = "熊本県阿蘇市"
  destination.notes = "世界有数のカルデラを持つ山"
end

kyushu_trip.destinations.find_or_create_by!(name: "別府温泉") do |destination|
  destination.day_number = 3
  destination.start_time = "13:00"
  destination.address = "大分県別府市"
  destination.notes = "湯けむり立ち上る温泉地"
end

okinawa_trip = Itinerary.find_or_create_by!(title: "沖縄旅行") do |itinerary|
  itinerary.region = :okinawa
  itinerary.user = james
  itinerary.day_number = 2
end

okinawa_trip.destinations.find_or_create_by!(name: "首里城") do |destination|
  destination.day_number = 1
  destination.start_time = "10:00"
  destination.address = "沖縄県那覇市首里金城町1-2"
  destination.notes = "琉球王国の象徴"
end

okinawa_trip.destinations.find_or_create_by!(name: "美ら海水族館") do |destination|
  destination.day_number = 1
  destination.start_time = "14:00"
  destination.address = "沖縄県国頭郡本部町字石川424"
  destination.notes = "日本最大級の水族館"
end

okinawa_trip.destinations.find_or_create_by!(name: "古宇利島") do |destination|
  destination.day_number = 2
  destination.start_time = "11:00"
  destination.address = "沖縄県国頭郡今帰仁村"
  destination.notes = "美しい海に囲まれた小島"
end

overseas_trip = Itinerary.find_or_create_by!(title: "海外旅行") do |itinerary|
  itinerary.region = :overseas
  itinerary.user = olivia
  itinerary.day_number = 3
end

overseas_trip.destinations.find_or_create_by!(name: "エッフェル塔") do |destination|
  destination.day_number = 1
  destination.start_time = "10:00"
  destination.address = "フランス パリ シャン・ド・マルス"
  destination.notes = "パリの象徴的なランドマーク"
end

overseas_trip.destinations.find_or_create_by!(name: "ルーブル美術館") do |destination|
  destination.day_number = 1
  destination.start_time = "14:00"
  destination.address = "フランス パリ ルーブル通り"
  destination.notes = "世界最大級の美術館"
end

overseas_trip.destinations.find_or_create_by!(name: "モン・サン・ミッシェル") do |destination|
  destination.day_number = 2
  destination.start_time = "09:00"
  destination.address = "フランス ノルマンディー"
  destination.notes = "潮の満ち引きで島になる修道院"
end

overseas_trip.destinations.find_or_create_by!(name: "ヴェルサイユ宮殿") do |destination|
  destination.day_number = 3
  destination.start_time = "10:00"
  destination.address = "フランス ヴェルサイユ"
  destination.notes = "豪華絢爛な宮殿と庭園"
end
