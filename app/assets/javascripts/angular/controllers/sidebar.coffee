angular.module 'Shutter'
       .controller 'SidebarCtrl', ['$scope', '$http', ($scope, $http) ->
         $scope.friends = []

         $http.get '/friends'
              .success (friends) ->
                $scope.friends = friends
       ]
