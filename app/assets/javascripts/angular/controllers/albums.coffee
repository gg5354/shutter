class Shutter.Controller.AlbumsCtrl extends Shutter.Controller.Base
  dependencies: ['$scope', '$http']

  asyncLoad: ['fetchAlbums']

  fetchAlbums: ->
    @$http.get '/albums'
          .success (albums) =>
            @$scope.albums = albums
