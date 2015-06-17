class Shutter.Controller.Base
  __className__: null
  dependencies: []
  scopeMethods: {}
  initialize: ->

  constructor: ->
    angular.module 'Shutter'
           .controller @__className__, @dependencies.concat [@_preInit]

  _preInit: =>
    for i in [0...arguments.length]
      dependency = @dependencies[i]
      @[dependency] = arguments[i]

    @initialize()
    @_includeScopeMethods()

  _includeScopeMethods: ->
    return unless @$scope

    for k, v of @scopeMethods
      @$scope[k] = v.bind(@)
