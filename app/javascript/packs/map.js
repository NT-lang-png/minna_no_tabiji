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

  if (!itineraryId) {
    console.error("Error: itineraryId is not defined");
    return;           // itineraryId が取得できなければ終了
  }

  //住所登録がない場合に、東京駅の経度と緯度を指定
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
    //経度と緯度の初期値を東京駅に設定
    let earliest = { latitude: tokyoLatitude, longitude: tokyoLongitude }


    if (!Array.isArray(items)) throw new Error("Items is not an array");


    // 地図の中心を設定　住所登録があるモデルを絞り込み、行き先の一番早いものを抽出。
    const trueAddressItems = items.filter(item => (item.address != ""))
    console.log(trueAddressItems)
    if (trueAddressItems.length != 0) {
      earliest = trueAddressItems[0]
    }

    const center = { lat: earliest.latitude, lng: earliest.longitude }
    console.log(center)

    // 地図を初期化
    map = new Map(document.getElementById("map"), {
      center: center,
      zoom: 14,
      mapId: "DEMO_MAP_ID",
      mapTypeControl: false
    });

    //item内のオブジェクト（@destinations)を取り出す
    items.forEach( item => {
      console.log(item)
    // マーカーに表示したい情報を定義
    const { latitude, longitude, name, start_time ,day_number, destination_image, image, address } = item;

    //日付表示を変更
      const formattedStartTime = new Date(start_time).toLocaleString('ja-JP', {
        hour: 'numeric',
        minute: 'numeric',
        hour12: false,
      })

      //マーカーを付ける。住所表示がなければ東京駅にマーカーが立つ
      const marker = new google.maps.marker.AdvancedMarkerElement ({
        position: { lat: address ? latitude : tokyoLatitude, lng: address ? longitude : tokyoLongitude },
        map,
        title: name,
      });

    //マーカーの中身
      const contentString = `
      <div class="container p-0">
        <img class="rounded-circle mr-2" src="${image}" width="40" height="40">
        <p class="lead m-0">${day_number}日目</p>
        <p class="lead m-0">${formattedStartTime}～</p>
        <p class="lead m-0">${name}</p>
        <p class="lead m-0">${address ? address : "住所登録はありません"}</p>
      </div>
    `;


    //infowindowを表示させる
    const infowindow = new google.maps.InfoWindow({
      content: contentString,
      ariaLabel: name,
    });

    //クリックするとマーカー内のinfoが見れるようにする
    marker.addListener("click", () => {
      infowindow.open({
      anchor: marker,
      map,
    })


  });


  });
  } catch (error) {
    console.error('Error fetching or processing destinations:', error);
  }
}

document.addEventListener("DOMContentLoaded", initMap);