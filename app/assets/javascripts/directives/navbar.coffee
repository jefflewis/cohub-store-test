angular.module('navbar', [ 'controllers' ]).directive 'navbar', ->
{
  restrict: 'E'
  replace: true
  transclude: true
  templateUrl: 'navbar.html'
}