class Shutter.Controller.Base
  dependencies: []
  asyncLoad: []
  scopeMethods: {}
  initialize: ->

  constructor: ->
    angular.module 'Shutter'
           .controller @constructor.name, @dependencies.concat [@__beforeInitialize__]

  __beforeInitialize__: =>
    for i in [0...arguments.length]
      dependency = @dependencies[i]
      @[dependency] = arguments[i]

    @initialize()
    @__includeScopeMethods__()
    @__asyncLoad__()

  __includeScopeMethods__: ->
    return unless @$scope

    for k, v of @scopeMethods
      @$scope[k] = v.bind(@)

  __asyncLoad__: ->
    for a in @asyncLoad
      if typeof a is 'function'
        a()
      else
        @[a]()
