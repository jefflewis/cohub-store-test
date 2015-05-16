controllers = angular.module('controllers')
controllers.controller("ProductController", [ '$scope', '$routeParams', '$resource', '$location', 'flash',
  ($scope,$routeParams,$resource,$location, flash)->
    Product = $resource('/products/:productId', { productId: "@id", format: 'json' },
      {
        'save':   {method:'PUT'},
        'create': {method:'POST'}
      }
    )

    if $routeParams.productId
      Product.get({productId: $routeParams.productId},
        ( (product)-> $scope.product = product ),
        ( (httpResponse)->
          $scope.product = null
          flash.error   = "There is no product with ID #{$routeParams.productId}"
        )
      )
    else
      $scope.product = {}

    $scope.back   = -> $location.path("/")
    $scope.edit   = -> $location.path("/products/#{$scope.product.id}/edit")
    $scope.cancel = ->
      if $scope.product.id
        $location.path("/products/#{$scope.product.id}")
      else
        $location.path("/")

    $scope.save = ->
      onError = (_httpResponse)-> flash.error = "Something went wrong"
      if $scope.product.id
        $scope.product.$save(
          ( ()-> $location.path("/products/#{$scope.product.id}") ),
          onError)
      else
        Product.create($scope.product,
          ( (newProduct)-> $location.path("/products/#{newProduct.id}") ),
          onError
        )

    $scope.delete = ->
      $scope.product.$delete()
      $scope.back()


])
