'use strict'

controllers = angular.module('controllers')
controllers.controller("ProductsController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->

    Product = $resource('/products/:productId', { productId: "@id", format: 'json' })

    $scope.products = Product.query();

    $scope.view = (productId)-> $location.path("/products/#{productId}")

    $scope.newProduct = -> $location.path("/products/new")

    $scope.edit      = (productId)-> $location.path("/products/#{productId}/edit")
    
])
