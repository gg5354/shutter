angular.module 'Shutter'
  .service 'authentication', ['$http', ($http) ->
    @loadCurrentUser = ->
      $http.get '/current_user'
           .success (user) =>
             @currentUser = user

    @logIn = (user) ->
      $http.post '/users/sign_in', user: user
           .success (user) =>
             @currentUser = user

    @logOut = ->
      $http.delete '/users/sign_out'
           .success =>
             @currentUser = null

    @signUp = (user) ->
      $http.post '/users', user: user
           .success (user) =>
             @currentUser = user

     @
   ]
