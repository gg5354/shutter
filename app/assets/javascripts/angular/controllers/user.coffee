# refactor later
angular.module 'Shutter'
       .controller 'UserCtrl', ['$scope', '$element', '$http', '$location', ($scope, $element, $http, $location) ->
         $scope.logOut = ->
           $http.delete '/users/sign_out'
                .success ->
                  SHUTTER.current_user = null
                  $location.path('/')
                  console.log 'success'
                .error ->
                  console.log 'error'

         $scope.signIn = ->
           return unless $scope.user

           $http.post '/users/sign_in', user: $scope.user
                .success (user) ->
                  SHUTTER.current_user = user
                  $location.path('/dashboard')
                  $('#sign-in-modal').modal('hide')
                  console.log 'success'
                .error ->
                  console.log 'error'

         $scope.signUp = ->
           return unless $scope.user
           if $scope.user.password != $scope.user.password_confirmation
           else
             delete $scope.user.password_confirmation
             $http.post '/users', user: $scope.user
                  .success ->
                    console.log 'success'
                  .error ->
                    console.log 'error'
       ]
