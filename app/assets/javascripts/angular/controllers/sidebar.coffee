angular.module 'Shutter'
       .controller 'SidebarCtrl', ['$scope', '$http', ($scope, $http) ->
         $scope.friends = []
         $scope.showFriendsList = false
         $scope.toggleFriendsList = ->
           $scope.showFriendsList = !$scope.showFriendsList

         $http.get '/friends'
              .success (friends) ->
                $scope.friends = friends
       ]
