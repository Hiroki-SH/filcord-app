export function showGoogleMapPoint(lat, lng){
  var photoLatLng = new google.maps.LatLng(lat, lng);
  var geocoder = new google.maps.Geocoder();
  var infowindow = new google.maps.InfoWindow();
  var option = {
    zoom: 15,
    center: photoLatLng,
  };
  var map = new google.maps.Map(document.getElementById("map"), option);
  geocoder.geocode({location: photoLatLng},function(results, status) {
    if (status == 'OK') {
      var marker = new google.maps.Marker({
        map: map,
        position: photoLatLng
      });

      infowindow.setContent(results[0].formatted_address);
      infowindow.open(map, marker);
    }
    else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
  // new google.maps.Marker({
  //   map: map,
  //   position: photoLatLng
  // });
};

