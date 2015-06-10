angular.module 'Shutter', ['ui.router']
       .run ['$http', ($http) ->
          $http.defaults.headers.common.Accept = 'application/json'
       ]
       .config ['$stateProvider', '$urlRouterProvider', '$locationProvider', ($stateProvider, $urlRouterProvider, $locationProvider) ->
        $locationProvider.html5Mode(true)
        extend = (object, views) ->
          newObject = {}

          for k, v of views
            newObject[k] = v

          for k, v of object
            newObject[k] = v

          newObject

        baseView =
          nav:
            template: JST['nav']()
            controller: ($element) ->
              $element.find('#sign-up').on 'click', ->
                $('#sign-up-modal').modal('show')

              $element.find('#sign-in').on 'click', ->
                $('#sign-in-modal').modal('show')

        $stateProvider
          .state 'home',
            url: '/'
            views:
              extend baseView,
                content:
                  template: JST['home']()
          .state 'dashboard',
            url: '/dashboard'
            views:
              extend baseView,
                content:
                  template: JST['dashboard']()
       ]
