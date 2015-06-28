class Shutter.Controller.ApplicationCtrl extends Shutter.Controller.Base
  dependencies: ['$scope', '$rootScope', 'authentication']

  initialize: ->
    @authentication.loadCurrentUser()

    @__bindErrorHandler__()
    @__defineCurrentUser__()

  __defineCurrentUser__: ->
    Object.defineProperty @$scope, 'currentUser',
      get: =>
        @authentication.currentUser

  __bindErrorHandler__: ->
    @$rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error) =>
      @$scope.error = error

    @$rootScope.$on '$stateChangeSuccess', =>
      @$scope.error = null

  scopeMethods:
    dismissAlert: ->
      @$scope.error = null
