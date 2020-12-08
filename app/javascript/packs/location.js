import {showGoogleMapPoint} from "./google_map.js"

function successFunc(position) {
  var data = position.coords; //取得した位置情報を整理
  var lat = data.latitude; //緯度
  var lng = data.longitude; //経度

  showGoogleMapPoint(lat, lng);
}

function errorFunc(error){
  var errorMessage = {
    0: "原因不明のエラーが発生しました",
    1: "位置情報の取得が許可されませんでした",
    2: "電波状況により位置情報が取得できませんでした",
    3: "タイムアウトしました",
  };

  alert(errorMessage[error.code]);
}

var optionObj = {
  "enableHighAccuracy": false ,
	"timeout": 8000 ,
	"maximumAge": 5000 ,
};

document.getElementById("text-button").onclick = function(){ //htmlのid"text_button"が押された時
// 使用端末が位置情報に対応している場合
  if (navigator.geolocation)
  {
    navigator.geolocation.getCurrentPosition(successFunc, errorFunc, optionObj);
  }
  // 対応していない場合
  else
  {
    alert("お使いの端末はGeoLocation APIに対応していません");
  }
};

