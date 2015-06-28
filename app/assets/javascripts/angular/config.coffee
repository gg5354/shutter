//= require_tree ./states

auth = ['authentication', '$q', (authentication, $q) ->
  return if authentication.currentUser

  deferred = $q.defer()

  authentication.loadCurrentUser()
    .success (user) ->
      if user
        deferred.resolve()
      else
        deferred.reject 'You must be signed in!'
    .error (e) ->
      deferred.reject e

  deferred.promise
]

angular.module 'Shutter'
       .config ['$stateProvider', '$locationProvider', ($stateProvider, $locationProvider) ->
         $locationProvider.html5Mode(true)

         for state, obj of Shutter.State
           if obj.authenticate
             delete obj.authenticate
             obj.resolve =
               auth: auth
           $stateProvider.state state, obj
       ]
