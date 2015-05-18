'use strict'

angular.module('cohub-test-store').directive 'file', ->
  restrict: 'AE'
  scope:
    file: '@'
  link: (scope, element, attrs) ->
    element.bind('change', (event)->
      files = event.target.files
      file = files[0]
      scope.file = file
      scope.$parent.file = file
      scope.$apply()
    )
