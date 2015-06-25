class Shutter.Controller.ApplicationCtrl extends Shutter.Controller.Base
  dependencies: ['$scope']

  initialize: ->
    Object.defineProperty @$scope, 'currentUser',
      get: ->
        Shutter.currentUser
