class Shutter.Controller.UserCtrl extends Shutter.Controller.Base
  dependencies: ['$scope', 'authentication']

  scopeMethods:
    logOut: ->
      @authentication.logOut()
        .success =>
          window.location.replace('/')

    logIn: ->
      return unless @$scope.user

      @authentication.logIn @$scope.user
            .success ->
              window.location.reload()

    signUp: ->
      return unless @$scope.user

      delete @$scope.user.password_confirmation
      @authentication.signUp @$scope.user
            .success (user) ->
              window.location.reload()
