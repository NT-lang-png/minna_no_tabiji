// ブートストラップ ローダ
(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
  key: process.env.Maps_API_Key
});


// ライブラリの読み込み
let map;


async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");
  const {AdvancedMarkerElement} = await google.maps.importLibrary("marker");

  // `data-itinerary-id` を map div から取得
  const itineraryId = document.getElementById('map').getAttribute('data-itinerary-id');
  //console.log("itineraryId:", itineraryId);                                        // 取得したIDを確認

  if (!itineraryId) {
    console.error("Error: itineraryId is not defined");
    return;                                                         // itineraryId が取得できなければ終了
  }

  const tokyoLatitude = 35.681236;
  const tokyoLongitude = 139.767125;

  //tryが処理できなかったらerror処理へ
  try {

    //jsonファイル読み込み
    const response = await fetch(`/itineraries/${itineraryId}.json`);
    if (!response.ok) throw new Error('Network response was not ok');


    //jsonファイル内のデータを定義
    const data = await response.json();
    const  { data: { items } } = data;
    let earliest = { latitude: tokyoLatitude, longitude: tokyoLatitude }


    if (!Array.isArray(items)) throw new Error("Items is not an array");
    //if (!earliest) throw new Error("Earliest is not defined");


    //console.log(earliest)

    // 地図の中心を設定

    // // destinationの中から、一番行き先順の早いものを抽出し、定義する



    // if (addresses.every(address => address)) {
    //   //  addressカラムがすべて入っている場合
    //   console.log("すべてのdestinationsにaddressが存在します。");
    //   const earliest = 
    
    // } else if (addresses.some(address => address) && addresses.some(address => !address)) {
    //   //  addressカラムがあるものとないものが混在している場合
    //   const destinationsWithAddress = itinerary.destinations.filter(dest => dest.address);
    //   console.log("addressがあるものとないものが混在しています。");
    
    // } else if (addresses.every(address => !address)) {
    //   //  すべてのaddressカラムがない場合
    //   console.log("すべてのdestinationsにaddressがありません。");
    // }






    const trueAddressItems = items.filter(item => (item.address != ""))
    if (trueAddressItems.length != 0) {
      earliest = trueAddressItems[0]
    }

    console.log(items.filter(item => (item.address != "")))
    const center = { lat: earliest.latitude, lng: earliest.longitude }
    //? { lat: earliest.latitude, lng: earliest.longitude }
    //: { lat: tokyoLatitude, lng: tokyoLongitude };  // 行き先がなければ東京駅のデフォルト座標
    //console.log("Map center:", center);      // デバッグ用

    // 地図を初期化
    map = new Map(document.getElementById("map"), {
      center: center,
      zoom: 14,
      mapId: "DEMO_MAP_ID",
      mapTypeControl: false
    });


    //console.log(data)
    //console.log('--------')
    //console.log(items)
    //console.log('--------')


    //item内のオブジェクト（@map_destination)を取り出す
    items.forEach( item => {
      console.log(item)
    //   console.log(item) //　items(@map_destinationの中身を確認)
    //   //マーカーに表示したい情報を定義
    const { latitude, longitude, name, start_time ,day_number, destination_image, image, address } = item;
    //   console.log("Marker data:", { latitude, longitude, name ,start_time, day_number,destination_image, image });                // デバッグ用

    //    // Dateオブジェクトをローカライズしてフォーマット
      const formattedStartTime = new Date(start_time).toLocaleString('ja-JP', {
        hour: 'numeric',
        minute: 'numeric',
        hour12: false, // 24時間表記
      })

      const marker = new google.maps.marker.AdvancedMarkerElement ({
        position: { lat: address ? latitude : tokyoLatitude, lng: address ? longitude : tokyoLongitude },
        map,
        title: name,
        // 他の任意のオプションもここに追加可能
      });

    //   // 追記
      const contentString = `
      <div class="container p-0">
        <img class="rounded-circle mr-2" src="${image}" width="40" height="40">
        <p class="lead m-0">${day_number}日目</p>
        <p class="lead m-0">${formattedStartTime}～</p>
        <p class="lead m-0">${name}</p>
        <p class="lead m-0">${address ? address : "住所登録はありません"}</p>
      </div>
    `;
    
    const infowindow = new google.maps.InfoWindow({
      content: contentString,
      ariaLabel: name,
    });

    marker.addListener("click", () => {
      infowindow.open({
      anchor: marker,
      map,
    })


  });


    // // マーカーが地図に追加された時点で、InfoWindowを常に表示
    // infowindow.open({
    //   anchor: marker
    //   // map,
    // });






  });
  } catch (error) {
    console.error('Error fetching or processing destinations:', error);
  }
}

document.addEventListener("DOMContentLoaded", initMap);