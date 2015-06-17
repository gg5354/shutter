angular.module 'Shutter'
       .controller 'SidebarCtrl', ['$scope', '$http', ($scope, $http) ->
         $scope.friends = []
         $scope.albums = []

         $scope.showFriendsList = false
         $scope.showAlbumsList = false

         $scope.toggleFriendsList = ->
           $scope.showFriendsList = !$scope.showFriendsList
           fetchFriends() if $scope.showFriendsList

         $scope.toggleAlbumsList = ->
           $scope.showAlbumsList = !$scope.showAlbumsList
           fetchAlbums() if $scope.showAlbumsList

         fetchAlbums = ->
            $http.get '/albums'
              .success (albums) ->
                $scope.albums = albums
              .error ->
                console.log 'error'

         fetchFriends = ->
           $http.get '/friends'
                .success (friends) ->
                  $scope.friends = friends
                .error ->
                  console.log 'error'
       ]
