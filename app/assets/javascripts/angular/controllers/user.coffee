# refactor later
class Shutter.Controller.UserCtrl extends Shutter.Controller.Base
  __className__: 'UserCtrl'

  dependencies: ['$scope', '$http']

  scopeMethods:
    logOut: ->
      @$http.delete '/users/sign_out'
            .success ->
              Shutter.currentUser = null
              window.location.replace('/')
              console.log 'success'
            .error ->
              console.log 'error'

    signIn: ->
      return unless @$scope.user

      @$http.post '/users/sign_in', user: @$scope.user
            .success (user) ->
              Shutter.currentUser = user
              $('#sign-in-modal').modal('hide')
              console.log 'success'
            .error ->
              console.log 'error'

    signUp: ->
      return unless @$scope.user

      delete @$scope.user.password_confirmation
      @$http.post '/users', user: @$scope.user
            .success ->
              console.log 'success'
            .error ->
              console.log 'error'
