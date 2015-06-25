# refactor later
class Shutter.Controller.UserCtrl extends Shutter.Controller.Base
  dependencies: ['$scope', '$http']

  scopeMethods:
    logOut: ->
      @$http.delete '/users/sign_out'
            .success ->
              Shutter.currentUser = null
              window.location.replace('/')
            .error ->
              console.log 'error'

    logIn: ->
      return unless @$scope.user

      @$http.post '/users/sign_in', user: @$scope.user
            .success (user) ->
              Shutter.currentUser = user
              $('#log-in-modal').modal('hide')
            .error ->
              console.log 'error'

    signUp: ->
      return unless @$scope.user

      delete @$scope.user.password_confirmation
      @$http.post '/users', user: @$scope.user
            .success (user) ->
              Shutter.currentUser = user
              $('#log-in-modal').modal('hide')
            .error ->
              console.log 'error'
