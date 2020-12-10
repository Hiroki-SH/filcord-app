import {showGoogleMapPoint} from "./google_map.js"

var lat = document.getElementById("lat").textContent;
var lng = document.getElementById("lng").textContent;

showGoogleMapPoint(lat, lng);
