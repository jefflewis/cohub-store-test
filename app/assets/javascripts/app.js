var myApp = angular.module('myApp', ['templates', 'ui.router', 'ui.bootstrap', 'LocalStorageModule']);

myApp.config(['$stateProvider', '$urlRouterProvider', '$locationProvider', function($stateProvider, $urlRouterProvider, $locationProvider){
  $urlRouterProvider.otherwise('/');
  $locationProvider.html5Mode(true);

  $stateProvider
    .state('root', {
      url: '',
      abstract: true,
      controller: 'root',
      template: "<ui-view/>"
    })
    .state('root.splash', {
      url: "/",
      templateUrl: "pages/splash.html",
      controller: 'splash'
    });
}]);

myApp.config(['localStorageServiceProvider', function(localStorageServiceProvider) {
  // Localhost needs '' on chrome.
  var cookieDomain = window.location.origin == "http://localhost:3000" ? "" : window.location;

  localStorageServiceProvider
    .setPrefix('sweetdb')
    .setStorageCookie(0, '/')
    .setStorageCookieDomain(cookieDomain)
    .setNotify(true, true);
}]);



/* Controllers */
myApp.controller('root', ['$scope', '$http', function($scope, $http){
  
}]);

myApp.controller('splash', ['$scope', '$http', '$location', function($scope){
  
}]);
