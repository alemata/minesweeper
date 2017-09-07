// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require angular/angular
//= require_tree .

minesweeper = angular.module('minesweeper',[
])

minesweeper.directive('ngRightClick', function($parse) {
    return function(scope, element, attrs) {
        var fn = $parse(attrs.ngRightClick);
        element.bind('contextmenu', function(event) {
            scope.$apply(function() {
                event.preventDefault();
                fn(scope, {$event:event});
            });
        });
    };
});

minesweeper.controller('EventsCtrl', ['$scope', '$http', function($scope, $http) {
  $scope.reveal = function(tile) {
    if ($scope.game.status == 'started' && !tile.revealed){
      $scope.doReveal(tile);
    }
  }

  // Api Methods
  $scope.doReveal = function(tile){
    $http.post("http://localhost:3000/api/games/" + $scope.game.id + "/tiles/" + tile.id + "/reveal").
          then(function(response) {
              $scope.loadGameData(response.data)
          });
  }

  $scope.toggleFlag = function(tile){
    $http.post("http://localhost:3000/api/games/" + $scope.game.id + "/tiles/" + tile.id + "/toggle_flag").
          then(function(response) {
              tile.flagged = !tile.flagged;
          });
  }

  $scope.createNewGame = function(tile){
    $http.post("http://localhost:3000/api/games", { rows: 2, columns: 2, mines_count: 2}).
          then(function(response) {
              $scope.loadGameData(response.data)
          });
  }

  $scope.loadGameData = function(data){
    $scope.game = data;
    $scope.tile_rows = [], size = $scope.game.rows;

    while ($scope.game.tiles.length > 0)
      $scope.tile_rows.push($scope.game.tiles.splice(0, size));
  }

  // Initially create a new game
  $scope.createNewGame();
}]);
