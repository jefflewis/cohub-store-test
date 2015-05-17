'use strict'

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


    $scope.upload = ->
      AWS.config.update
        accessKeyId: 'AKIAJITSKLHVEFFSN5JQ'
        secretAccessKey: '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'
      AWS.config.region = 'us-east-1'
      bucket = new (AWS.S3)(params: Bucket: 'cohubteststoreimages')
      if $scope.file
        # Perform File Size Check First
        fileSize = Math.round(parseInt($scope.file.size))
        if fileSize > $scope.sizeLimit
          flash.error   = 'Sorry, your attachment is too big. <br/> Maximum ' + $scope.fileSizeLabel() + ' file attachment allowed -- File Too Large'
          return false
        # Prepend Unique String To Prevent Overwrites

        text = ''
        possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz012345678'
        i = 0
        while i < 8
          text += possible.charAt(Math.floor(Math.random() * possible.length))
          i++

        uniqueFileName = text + '-' + $scope.file.name
        params =
          Key: uniqueFileName
          ContentType: $scope.file.type
          Body: $scope.file
          ServerSideEncryption: 'AES256'
        bucket.putObject(params, (err, data) ->
          if err
            flash.error = err.message + err.code
            return false
          else
            # Upload Successfully Finished
            flash.success 'File Uploaded Successfully', 'Done'
            # Reset The Progress Bar
            setTimeout (->
              $scope.uploadProgress = 0
              $scope.$digest()
              return
            ), 4000
          return
        ).on 'httpUploadProgress', (progress) ->
          $scope.uploadProgress = Math.round(progress.loaded / progress.total * 100)
          $scope.$digest()
          return
      else
        # No File Selected
        flash.error = 'Please select a file to upload'
    return

    $scope.fileSizeLabel = ->
      # Convert Bytes To MB
      return Math.round($scope.sizeLimit / 1024 / 1024) + 'MB'

    $scope.uniqueString = ->
      text = ''
      possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz012345678'
      i = 0
      while i < 8
        text += possible.charAt(Math.floor(Math.random() * possible.length))
        i++
      return text

    $scope.delete = ->
      $scope.product.$delete()
      $scope.back()

])
