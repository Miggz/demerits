app = angular.module 'demerits', ['ngResource']

app.factory 'Victim', ['$resource', '$window', ($resource, $window) ->
  $resource($window.location.pathname + '/vote.json')
]

@DemeritCtrl = ['$scope', 'Victim', ($scope, Victim) ->
  $scope.victim = Victim.get()

  $scope.addDemerit = ->
    $scope.victim.$save flag: true

  $scope.removeDemerit = ->
    $scope.victim.$save flag: false
]
