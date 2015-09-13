// Ionic Starter App

// angular.module is a global place for creating, registering and retrieving Angular modules
// 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
// the 2nd parameter is an array of 'requires'

// var APP_URL = "http://10.1.10.79:3000/";
var APP_URL = "http://glossapp.herokuapp.com/";

angular.module('starter', ['ionic', 'ngResource', 'ngStorage', 'ionic.contrib.ui.tinderCards'])
.run(function($ionicPlatform) {
  $ionicPlatform.ready(function() {
    // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
    // for form inputs)
    if(window.cordova && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
    }
    if(window.StatusBar) {
      StatusBar.styleDefault();
    }
  });
})
.directive('noScroll', function() {

  return {
    restrict: 'A',
    link: function($scope, $element, $attr) {

      $element.on('touchmove', function(e) {
        e.preventDefault();
      });
    }
  }
})
.factory('UserFactory', ['$resource', '$localStorage', function ($resource, $localStorage) {
    return {
        getUser: function () {
            if ( ! $localStorage.user ) {
                $resource(APP_URL + 'user/create').get(function (response, error) {
                    $localStorage.user = response;
                    return $localStorage.user;
                });
            } else {
                return $localStorage.user;
            }
        }
    }
}])
.factory('SentenceFactory', ['$resource', 'UserFactory', function ($resource, UserFactory) {

    var user = UserFactory.getUser();

    console.log("What's the user?", user);
    return {

        getSentences: function (amount) {
            return $resource(APP_URL + 'sentences/:userId/:count', {}, {
                query: { method: 'GET', isArray: true, params: {userId: user.uuid, count: amount} }
            });
        },

        scoreSentence: function (understood) {
            console.log("What's understood?", understood);
            return $resource(APP_URL + 'sentences/:userId', {}, {
                query: { method: 'POST', params: {userId: user.uuid, understood: understood}}
            })
        }

    }
}])
.controller('CardsCtrl', function($scope, $rootScope, SentenceFactory, TDCardDelegate) {

    SentenceFactory.getSentences(3).query({}).$promise.then(function(data) {
        $scope.cards = data;
        $rootScope.$emit('tdCard.sortCards');
        console.log("data", data);
    });

  $scope.cardDestroyed = function(index) {
    $scope.cards.splice(index, 1);
    console.log("Yep, destroyed this bitch.");
    $scope.addCard();
  };

  $scope.addCard = function() {
    // var newCard = sentences[Math.floor(Math.random() * sentences.length)];
    // newCard.id = Math.random();
    SentenceFactory.getSentences(1).query({}).$promise.then(function (data) {
        $scope.cards.push(data[0]);
    });
  }

  $scope.cardPartialSwipe = function (amount) {
      console.log("Partially swiping");
      console.log(amount);
  }

  $scope.cardSwipedRight = function ($index) {
      SentenceFactory.scoreSentence(true).query({}).$promise.then(function (data) {
          console.log("Will something get returned here?", data);
      });
      // console.log("The card got swipped right.");
  }

  $scope.cardSwipedLeft = function ($index) {
      SentenceFactory.scoreSentence(false).query({}).$promise.then(function (data) {
          console.log("Will something get returned here?", data);
      });
      console.log("The card got swipped left.");
  }

})
.controller('CardCtrl', function($scope, TDCardDelegate) {
  $scope.cardSwipedLeft = function(index) {
    console.log('LEFT SWIPE');
    $scope.addCard();
  };
  $scope.cardSwipedRight = function(index) {
    console.log('RIGHT SWIPE');
    $scope.addCard();
  };
})
/* .directive('levelRange', function () {
    return {
        restrict: 'E',
        templateUrl: 'js/templates/levelrange.html',
        scope: {
            currentLevel: '=',
            nextLevel: '=',
            progress: '='
        },
        link: function (scope, element, attrs, controllers) {
            console.log("scope", scope);
            console.log("element", element);
            console.log("attrs", attrs);
            console.log("controllers", controllers);
        }
    }
}) */