describe "ProductsController", ->
  scope        = null
  ctrl         = null
  location     = null
  routeParams  = null
  resource     = null
  httpBackend  = null

  setupController =(keywords,results)->
    inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      httpBackend = $httpBackend
      routeParams = $routeParams
      routeParams.keywords = keywords

      if results
        request = new RegExp("\/products.*keywords=#{keywords}")
        httpBackend.expectGET(request).respond(results)

      ctrl        = $controller('ProductsController',
                                $scope: scope
                                $location: location)
    )

  beforeEach(module("cohub-test-store"))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
    describe 'when no keywords present', ->
      beforeEach(setupController())

      it 'defaults to no products', ->
        expect(scope.products).toEqualData([])

    describe 'with keywords', ->
      keywords = 'ball'
      products = [
        {
          id: 2
          name: "Soccer Ball"
          description: "black and white"
          quantity: 3
          sku: "ch-938"
          price: 75.80
        },
        {
          id: 5
          name: "Baseball Bat"
          description: "Louisville Slugger"
          quantity: 78
          sku: "ch-938"
          price: 13.67
        }
      ]
      beforeEach ->
        setupController(keywords,products)
        httpBackend.flush()

      it 'calls the back-end', ->
        expect(scope.products).toEqualData(products)

  describe 'search()', ->
    beforeEach ->
      setupController()

    it 'redirects to itself with a keyword param', ->
      keywords = 'foo'
      scope.search(keywords)
      expect(location.path()).toBe("/")
      expect(location.search()).toEqualData({keywords: keywords})
