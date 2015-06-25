//= require_tree ./states

angular.module 'Shutter'
       .config ['$stateProvider', '$locationProvider', ($stateProvider, $locationProvider) ->
         $locationProvider.html5Mode(true)

         for state, obj of Shutter.State
           $stateProvider.state state, obj
       ]

