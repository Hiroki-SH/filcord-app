export function showGoogleMapPoint(lat, lng){
  var phtotoLatLng = new google.maps.LatLng(lat, lng);
  var option = {
    zoom: 15,
    center: phtotoLatLng,
  };
  var map = new google.maps.Map(document.getElementById("map"), option);
  new google.maps.Marker({
    map: map,
    position: phtotoLatLng
  });
};

