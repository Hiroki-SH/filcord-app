import React from "react"
import  ReactDOM  from "react-dom"
import {showGoogleMapPoint} from "../packs/google_map"

const successFunc = (position) =>  {
  const data = position.coords; //取得した位置情報を整理
  const lat = data.latitude; //緯度
  const lng = data.longitude; //経度

  document.getElementById("photo_lat").value = lat;
  document.getElementById("photo_lng").value = lng;

  showGoogleMapPoint(lat, lng);
};

const errorFunc = (error) => {
  var errorMessage = {
    0: "原因不明のエラーが発生しました",
    1: "位置情報の取得が許可されませんでした",
    2: "電波状況により位置情報が取得できませんでした",
    3: "タイムアウトしました",
  };

  alert(errorMessage[error.code]);
};

const optionObj = {
  "enableHighAccuracy": false ,
	"timeout": 8000 ,
	"maximumAge": 5000 ,
};

const onClickButton = () => {
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

export const Location = () => {
  return (
  <button onClick={onClickButton}>位置情報を取得</button>
  );
};

ReactDOM.render(<Location />, document.getElementById("map-b"));
export default Location
