
//*************************** Evelyn :start ***************************************
angular.module('starter.controllers')
.controller('mapController', function($scope,$http,$rootScope,$state,$cordovaGeolocation,$compile,mapFactory) {
 //*************************** Evelyn :end ***************************************
    
        //*************************** Edwin :start ***************************************    
        var apiKey = false;
        var map = null;
        
        function initMap(){
        
            var options = {timeout: 10000, enableHighAccuracy: true};
        
            $cordovaGeolocation.getCurrentPosition(options).then(function(position){
        
            var latLng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
        
            var mapOptions = {
                center: latLng,
                zoom: 15,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
        
            map = new google.maps.Map(document.getElementById("map"), mapOptions);
        
            //Wait until the map is loaded
            google.maps.event.addListenerOnce(map, 'idle', function(){
        
                //Load the markers
                loadMarkers();
        
            });
        
            }, function(error){
            console.log("Could not get location");
                //Load the markers
                loadMarkers();
            });
        
        };
        //*************************** Edwin :end ***************************************
    
        //*************************** Anthony :start ***************************************
        function loadMarkers(){

            mapFactory.getMarkers().then(function(markers){
        
                console.log("Markers: ", markers);
        
                var records = markers;
        
                for (var i = 0; i < records.length; i++) {
        
                var record = records[i];   
                var markerPos = new google.maps.LatLng(record.Latitude, record.Length);
        
                // Add the markerto the map
                var marker = new google.maps.Marker({
                    map: map,
                    animation: google.maps.Animation.DROP,
                    position: markerPos,
                    icon : 'img/car_trans_min.png'
                });
        
                var infoWindowContent = "<h4>" + record.Name + "</h4>";          
        
                addInfoWindow(marker, infoWindowContent, record);
        
                }
        
            })
                .catch(function(err){
                });
        
        }
        //*************************** Anthony :end ***************************************
    
        //*************************** Jhon :start ***************************************
        function addInfoWindow(marker, message, record) {

            var infoWindow = new google.maps.InfoWindow({
                content: message
            });
        
            google.maps.event.addListener(marker, 'click', function () {
                infoWindow.setContent("<a href='asd'>Link</a>");
                infoWindow.open(map, marker);
            });
        
        };
        //*************************** Jhon :end ***************************************
        
        
        function clickTest(){
            console.log('ingreso link');
        }    


        initMap();
    
    
  

});