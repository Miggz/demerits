function DemeritCtrl ($scope) {
  $scope.demerit_count = 1;

  $scope.addDemerit = function () {
    console.log('add-Demerit');
    $scope.demerit_count = $scope.demerit_count + 1;
  };

  $scope.removeDemerit = function () {
    $scope.demerit_count = $scope.demerit_count - 1;
  };
}
