cohubTestStore = angular.module('cohub-test-store',[
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])

cohubTestStore.config([ '$routeProvider', 'flashProvider',
  ($routeProvider,flashProvider)->

    flashProvider.errorClassnames.push("alert-danger")
    flashProvider.warnClassnames.push("alert-warning")
    flashProvider.infoClassnames.push("alert-info")
    flashProvider.successClassnames.push("alert-success")

    $routeProvider
      .when('/',
        templateUrl: "index.html"
        controller: 'ProductsController'
      ).when('/products/new',
        templateUrl: "form.html"
        controller: 'ProductController'
      ).when('/products/:productId',
        templateUrl: "show.html"
        controller: 'ProductController'
      ).when('/products/:productId/edit',
        templateUrl: "form.html"
        controller: 'ProductController'
      )
])

controllers = angular.module('controllers',[])