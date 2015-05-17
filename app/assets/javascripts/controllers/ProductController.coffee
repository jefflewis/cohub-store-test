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
          toastr.error 'Sorry, your attachment is too big. <br/> Maximum ' + $scope.fileSizeLabel() + ' file attachment allowed', 'File Too Large'
          return false
        # Prepend Unique String To Prevent Overwrites
        uniqueFileName = $scope.uniqueString() + '-' + $scope.file.name
        params =
          Key: uniqueFileName
          ContentType: $scope.file.type
          Body: $scope.file
          ServerSideEncryption: 'AES256'
        bucket.putObject(params, (err, data) ->
          if err
            toastr.error err.message, err.code
            return false
          else
            # Upload Successfully Finished
            toastr.success 'File Uploaded Successfully', 'Done'
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
        toastr.error 'Please select a file to upload'
      return

      $scope.fileSizeLabel = ->
        # Convert Bytes To MB
        Math.round($scope.sizeLimit / 1024 / 1024) + 'MB'

      $scope.uniqueString = ->
        text = ''
        possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
        i = 0
        while i < 8
          text += possible.charAt(Math.floor(Math.random() * possible.length))
          i++
        text


    # $scope.upload = ->
    #   # Configure The S3 Object
    #   AWS.config.update
    #     accessKeyId: $scope.creds.access_key
    #     secretAccessKey: $scope.creds.secret_key
    #   AWS.config.region = 'us-east-1'
    #   bucket = new (AWS.S3)(params: Bucket: $scope.creds.bucket)
    #   if $scope.file
    #     params =
    #       Key: $scope.file.name
    #       ContentType: $scope.file.type
    #       Body: $scope.file
    #       ServerSideEncryption: 'AES256'
    #     bucket.putObject(params, (err, data) ->
    #       if err
    #         # There Was An Error With Your S3 Config
    #         alert err.message
    #         return false
    #       else
    #         # Success!
    #         alert 'Upload Done'
    #       return
    #     ).on 'httpUploadProgress', (progress) ->
    #       # Log Progress Information
    #       console.log Math.round(progress.loaded / progress.total * 100) + '% done'
    #       $scope.s3_path = $scope.creds.bucket + '/' + $scope.file.name
    #       $scope.product.image = 'https://s3.amazonaws.com/' + $scope.s3_path
    #       return
    #   else
    #     # No File Selected
    #     alert 'No File Selected'
    #   return


      $scope.delete = ->
        $scope.product.$delete()
        $scope.back()


])
