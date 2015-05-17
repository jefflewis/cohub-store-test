'use strict';

var directives = angular.module('directives', []);

directives.directive('file', function() {
  return {
    restrict: 'AE',
    scope: {
      file: '@'
    },
    link: function(scope, el, attrs){
      el.bind('change', function(event){
        var files = event.target.files;
        var file = files[0];
        scope.file = file;
        scope.$parent.file = file;
        scope.$apply();
      });
    }
  };
});

// Access Key ID:AKIAIITEQGUZQP2UYY4A
// Secret Access Key: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
