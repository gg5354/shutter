angular.module 'Shutter'
       .controller 'ApplicationCtrl', ($scope) ->
        $scope.current_user = ->
          SHUTTER.current_user
