// Ionic Starter App


//*************************** Sandra :start ***************************************
angular.module('starter', ['ionic','ngCordova','starter.controllers','starter.factories'])

//*************************** Sandra :end ***************************************
.run(function($ionicPlatform) {
  $ionicPlatform.ready(function() {
    if(window.cordova && window.cordova.plugins.Keyboard) {
      // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
      // for form inputs)
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);

      // Don't remove this line unless you know what you are doing. It stops the viewport
      // from snapping when text inputs are focused. Ionic handles this internally for
      // a much nicer keyboard experience.
      cordova.plugins.Keyboard.disableScroll(true);
    }
    if(window.StatusBar) {
      StatusBar.styleDefault();
    }
  });
})
//*************************** Jose :start ***************************************
.config(function($stateProvider, $urlRouterProvider,$ionicConfigProvider,$httpProvider){
  $stateProvider
    .state('page1',{
      url: "/page1",
      templateUrl:'templates/page1.html'
    })
    .state('page2',{
      url:"/page2",
      templateUrl: 'templates/page2.html',
      controller: 'customersCtrl'
      
    })
    .state('map',{
      url:"/map",
      templateUrl: 'templates/map.html',
      controller: 'mapController'
      
    })
    
    $urlRouterProvider.otherwise('/page1');
    //$ionicConfigProvider.views.swipeBackEnabled(false);
    $httpProvider.defaults.useXDomain = true;
    delete $httpProvider.defaults.headers.common['X-Requested-With'];
    
});
//*************************** Jose :end ***************************************
