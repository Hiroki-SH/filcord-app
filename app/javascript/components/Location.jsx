import React from "react"
import  ReactDOM  from "react-dom"
import PropTypes from "prop-types"
import {showGoogleMapPoint} from "../packs/google_map"

// class Location extends React.Component {
//   render () {
//     return (
//       <>
//         Greeting: {this.props.greeting}
//         lat: {this.props.lat}
//         lng: {this.props.lng}
//       </>
//     );
//   }
// }

function successFunc(position) {
  var data = position.coords; //取得した位置情報を整理
  var lat = data.latitude; //緯度
  var lng = data.longitude; //経度

  // console.log(Object.prototype.toString.call(lat));

  document.getElementById("photo_lat").value = lat;
  document.getElementById("photo_lng").value = lng;

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

ReactDOM.render(<Location />, document.getElementById("map-button"));

// Location.propTypes = {
//   greeting: PropTypes.string,
//   lat: PropTypes.string,
//   lng: PropTypes.string
// };
export default Location
