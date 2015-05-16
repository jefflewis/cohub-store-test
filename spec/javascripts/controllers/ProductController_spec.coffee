describe "ProductController", ->
  scope        = null
  ctrl         = null
  routeParams  = null
  httpBackend  = null
  flash        = null
  location     = null
  productId     = 42

  fakeProduct   =
    id: productId
    name: "Football"
    description: "brown leather"
    qty: 1
    sku: "CH-001"
    price: 25.50

  setupController =(productExists=true,productId=42)->
    inject(($location, $routeParams, $rootScope, $httpBackend, $controller, _flash_)->
      scope       = $rootScope.$new()
      location    = $location
      httpBackend = $httpBackend
      routeParams = $routeParams
      routeParams.productId = productId if productId
      flash = _flash_

      if productId
        request = new RegExp("\/products/#{productId}")
        results = if productExists
          [200,fakeProduct]
        else
          [404]

        httpBackend.expectGET(request).respond(results[0],results[1])

      ctrl        = $controller('ProductController',
                                $scope: scope)
    )

  beforeEach(module("cohub-test-store"))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
    describe 'product is found', ->
      beforeEach(setupController())
      it 'loads the given product', ->
        httpBackend.flush()
        expect(scope.product).toEqualData(fakeProduct)
    describe 'product is not found', ->
      beforeEach(setupController(false))
      it 'loads the given product', ->
        httpBackend.flush()
        expect(scope.product).toBe(null)
        expect(flash.error).toBe("There is no product with ID #{productId}")

  describe 'create', ->
    newProduct =
      id: 42
      name: 'Soccer Ball'
      description: 'FIFA regulation size 5'
      quantity: 1
      sku: "CH-795"
      price: 37.75

    beforeEach ->
      setupController(false,false)
      request = new RegExp("\/products")
      httpBackend.expectPOST(request).respond(201,newProduct)

    it 'posts to the backend', ->
      scope.product.name          =   newProduct.name
      scope.product.description   =   newProduct.description
      scope.prduct.quantity       =   newProduct.quantity
      scope.prduct.sku            =   newProduct.sku
      scope.prduct.price          =   newProduct.price
      scope.save()
      httpBackend.flush()
      expect(location.path()).toBe("/products/#{newProduct.id}")

  describe 'update', ->
    updatedProduct =
      name: 'Two Person Tent'
      description: 'Coleman Original. Camp out like your parents used to!'

    beforeEach ->
      setupController()
      httpBackend.flush()
      request = new RegExp("\/products")
      httpBackend.expectPUT(request).respond(204)

    it 'posts to the backend', ->
      scope.product.name        =   updatedProduct.name
      scope.product.description =   updatedProduct.description
      scope.prduct.quantity     =   updatedProduct.quantity
      scope.prduct.sku          =   updatedProduct.sku
      scope.prduct.price        =   updatedProduct.price
      scope.save()
      httpBackend.flush()
      expect(location.path()).toBe("/products/#{scope.product.id}")

  describe 'delete' ,->
    beforeEach ->
      setupController()
      httpBackend.flush()
      request = new RegExp("\/products/#{scope.product.id}")
      httpBackend.expectDELETE(request).respond(204)

    it 'posts to the backend', ->
      scope.delete()
      httpBackend.flush()
      expect(location.path()).toBe("/")
