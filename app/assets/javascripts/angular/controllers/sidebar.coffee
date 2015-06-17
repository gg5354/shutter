class Shutter.Controller.SidebarCtrl extends Shutter.Controller.Base
  __className__: 'SidebarCtrl'

  dependencies: ['$scope', '$http']

  initialize: ->
    @$scope.friends = []
    @$scope.albums = []
    @$scope.showFriendsList = false
    @$scope.showAlbumsList = false

  scopeMethods:
    toggleFriendsList: ->
      @$scope.showFriendsList = !@$scope.showFriendsList
      @$scope.fetchFriends()

    fetchFriends: ->
      @$http.get '/friends'
            .success (friends) =>
              @$scope.friends = friends
            .error ->
              console.log 'error'

    toggleAlbumsList: ->
      @$scope.showAlbumsList = !@$scope.showAlbumsList
      @$scope.fetchAlbums()

    fetchAlbums: ->
      @$http.get '/albums'
            .success (albums) =>
              @$scope.albums = albums
            .error ->
              console.log 'error'
