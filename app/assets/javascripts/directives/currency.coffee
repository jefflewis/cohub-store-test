'use strict'

angular.module('cohub-test-store').directive 'currency', ->
  restrict: 'AE'
  return ->
    require: 'ngModel'
    link: (scope, element, attrs, ngModel) ->
      ngModel.$formatters.push((value)->
        return '$' + value
      )
      ngModel.$parsers.push((value)->
        return value.replace(/^\$/, '')
      )
