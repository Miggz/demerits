angular.module('demerits', ['ngResource'])
  .factory('Victim', function ($resource, $window) {
    return $resource($window.location.pathname + '/vote.json');
  });

function DemeritCtrl ($scope, Victim) {
  $scope.victim = Victim.get();

  $scope.addDemerit = function () {
    $scope.victim.$save({flag: true});
  };

  $scope.removeDemerit = function () {
    $scope.victim.$save({flag: false});
  };
}
