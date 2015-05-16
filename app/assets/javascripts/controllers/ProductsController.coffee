controllers = angular.module('controllers')
controllers.controller("ProductsController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.search = (keywords)->  $location.path("/").search('keywords',keywords)
    Product = $resource('/products/:productId', { productId: "@id", format: 'json' })

    if $routeParams.keywords
      Product.query(keywords: $routeParams.keywords, (results)-> $scope.products = results)
    else
      $scope.products = []

    $scope.view = (productId)-> $location.path("/products/#{productId}")

    $scope.newProduct = -> $location.path("/products/new")
    $scope.edit      = (productId)-> $location.path("/products/#{productId}/edit")
])
