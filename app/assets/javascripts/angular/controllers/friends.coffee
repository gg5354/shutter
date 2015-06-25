class Shutter.Controller.FriendsCtrl extends Shutter.Controller.Base
  dependencies: ['$scope', '$http']

  asyncLoad: ['fetchFriends']

  fetchFriends: ->
    @$http.get '/friends'
          .success (friends) =>
            @$scope.friends = friends
