window.Shutter = {}
['Controller', 'State'].forEach (obj) ->
  Shutter[obj] = {}

$ ->
  signUpLink = $ '#sign-up'
  logInLink = $ '#log-in'
  signUpModal = $ '#sign-up-modal'
  logInModal = $ '#log-in-modal'

  signUpLink.on 'click', ->
    signUpModal.modal 'show'

  logInLink.on 'click', ->
    logInModal.modal 'show'

angular.module 'Shutter', ['ui.router']
       .run ['$http', ($http) ->
         $http.defaults.headers.common.Accept = 'application/json'
       ]
