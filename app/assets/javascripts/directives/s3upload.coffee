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


# // angular.module('cohub-test-store')
# //   .directive('file', function() {
# //   return {
# //     restrict: 'AE',
# //     scope: {
# //       file: '@'
# //     },
# //     link: function(scope, element, attrs){
# //       element.bind('change', function(event){
# //         var files = event.target.files;
# //         var file = files[0];
# //         scope.file = file;
# //         scope.$parent.file = file;
# //         scope.$apply();
# //       });
# //     }
# //   };
# // });
