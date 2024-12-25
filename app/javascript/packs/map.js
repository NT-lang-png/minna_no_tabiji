// ブートストラップ ローダ
//(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
  //key: process.env.Maps_API_Key
//});


// ライブラリの読み込み
let map;

async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");
  const {AdvancedMarkerElement} = await google.maps.importLibrary("marker");

  // `data-itinerary-id` を map div から取得
  const itineraryId = document.getElementById('map').getAttribute('data-itinerary-id');
  console.log("itineraryId:", itineraryId);                                        // 取得したIDを確認

  if (!itineraryId) {
    console.error("Error: itineraryId is not defined");
    return;                                                         // itineraryId が取得できなければ終了
  }



  //tryが処理できなかったらerror処理へ
  try {
    const response = await fetch(`/itineraries/${itineraryId}.json`);
    if (!response.ok) throw new Error('Network response was not ok');

    const data = await response.json();
    const  { data: { items, earliest } } = data;


    if (!Array.isArray(items)) throw new Error("Items is not an array");
    if (!earliest) throw new Error("Earliest is not defined");

    // 地図の中心を設定
    //const center = { lat: earliest.latitude, lng: earliest.longitude };
    const center = (earliest && typeof earliest.latitude === 'number' && typeof earliest.longitude === 'number')
    ? { lat: earliest.latitude, lng: earliest.longitude }
    : { lat: 35.681236, lng: 139.767125 };  // 東京駅のデフォルト座標
    console.log("Map center:", center);                                    // デバッグ用

    // 地図を初期化
    map = new Map(document.getElementById("map"), {
      center: center,
      zoom: 14,
      mapId: "DEMO_MAP_ID",
      mapTypeControl: false
    });

    items.forEach( item => {
      const { latitude, longitude, name , start_time ,day_number } = item;

      console.log("Marker data:", { latitude, longitude, name ,start_time, day_number});                // デバッグ用

       // Dateオブジェクトをローカライズしてフォーマット
      const formattedStartTime = new Date(start_time).toLocaleString('ja-JP', {
        hour: 'numeric',
        minute: 'numeric',
        hour12: false, // 24時間表記
      });



      const marker = new google.maps.marker.AdvancedMarkerElement ({
        position: { lat: latitude, lng: longitude },
        map,
        title: name,
        // 他の任意のオプションもここに追加可能
      });

      // 追記
      const contentString = `
      <div class="container p-0">
        <p class="lead m-0">${day_number}日目</p>
        <p class="lead m-0">${formattedStartTime}～</p>
        <p class="lead m-0">${name}</p>
      </div>
    `;
    
    const infowindow = new google.maps.InfoWindow({
      content: contentString,
      ariaLabel: name,
    });

    // マーカーが地図に追加された時点で、InfoWindowを常に表示
    infowindow.open({
      anchor: marker,
      map,
    });




  });
  } catch (error) {
    console.error('Error fetching or processing destinations:', error);
  }
}

document.addEventListener("DOMContentLoaded", initMap);