angular.module 'Shutter'
       .controller 'ApplicationCtrl', ($scope) ->
         Object.defineProperty $scope, 'current_user',
           get: ->
             SHUTTER.current_user
