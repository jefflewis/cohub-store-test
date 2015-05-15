cohubStore = angular.module('cohubStore',[
	'templates',
	'ngRoute',
	'controllers',
])

cohubStore.config([ '$routeProvider',
	($routeProvider)->
		$routeProvider
			.when('/',
				templateUrl: "index.html"
				controller: 'ProductsController'
			)
])

products = [
	{
		id: 1
		name: 'Tennis Ball'
	},
	{
		id: 2
		name: 'Soccer Cleats'
	},
	{
		id: 3
		name: 'Football'
	},
	{
		id: 4
		name: 'Jumprope'
	},
]

controllers = angular.module('controllers', [])
controllers.controller('ProductsController', ['$scope' , '$routeParams', '$location',
	($scope, $routeParams, $location)->
		$scope.search = (keywords)-> $location.path('/').search('keywords', keywords)

		if $routeParams.keywords
			keywords = $routeParams.keywords.toLowerCase()
			$scope.products = products.filter (product)-> product.name.toLowerCase().indexOf(keywords) != -1
		else
			$scope.products = []
])