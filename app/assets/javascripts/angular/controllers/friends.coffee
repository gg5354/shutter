class Shutter.Controller.FriendsCtrl extends Shutter.Controller.Base
  dependencies: ['$scope', '$http', '$q']

  asyncLoad: ->
    @$q.all {acceptedFriends: @fetchFriends('accepted'), pendingFriends: @fetchFriends('pending'), relationships: @fetchRelationships()}
       .then (obj) =>
         @_processData obj.acceptedFriends.data, obj.pendingFriends.data, obj.relationships.data

  initialize: ->
    @$scope.friends = {}
    @$scope.friends.accepted = []
    @$scope.friends.pending = []

  _processData: (acceptedFriends, pendingFriends, relationships) ->
    statuses = {}
    for r in relationships
      if r.user_1 is @$scope.currentUser.id
        statuses[r.user_2] = r
      else
        statuses[r.user_1] = r

    for friend in acceptedFriends.concat(pendingFriends)
      relationship = statuses[friend.id]
      friend.relationship = relationship

      if relationship.status is 'accepted'
        @$scope.friends.accepted.push friend
      else
        @$scope.friends.pending.push friend

  fetchFriends: (status) ->
    @$http.get "/friends?status=#{status}"

  fetchRelationships: ->
    @$http.get '/relationships'

  scopeMethods:
    isReceiver: (relationship) ->
      relationship.user_1 isnt @$scope.currentUser.id

    addFriend: (user) ->
      @$http.post '/relationships', relationship: {user: { email: user.email }}
            .success (relationship) =>
              delete @$scope.user
              @$scope.friends.pending.push({email: user.email})
            .error (error) =>
              throw error.message

    unfriend: (friend) ->
      @$http.delete "/relationships/#{friend.relationship.id}"
            .success =>
              status = friend.relationship.status
              friends = (f for f in @$scope.friends[status] when f.id isnt friend.id)
              @$scope.friends[status] = friends
