class Shutter.Controller.ApplicationCtrl extends Shutter.Controller.Base
  __className__: 'ApplicationCtrl'

  dependencies: ['$scope']

  initialize: ->
    Object.defineProperty @$scope, 'currentUser',
      get: ->
        Shutter.currentUser
