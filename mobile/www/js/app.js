// Ionic Starter App

// angular.module is a global place for creating, registering and retrieving Angular modules
// 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
// the 2nd parameter is an array of 'requires'

angular.module('starter', ['ionic', 'ionic.contrib.ui.tinderCards'])
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
.factory('SentenceFactory', ['$resource', function ($resource) {
    return $resource('http://localhost:3000/sentences');
}])
.controller('SentenceController', ['$scope', 'SentenceFactory', function ($scope, SentenceFactory) {
    var sentence = SentenceFactory.get(function() {
        console.log(sentence);
    });
}])
.controller('CardsCtrl', function($scope, TDCardDelegate) {
  var sentences = [
    { sentence: 'クッション性あるし軽いし履いてないみたいだし走ったら飛べる気がする',
      level: 2
    },
    { sentence: 'え、ちょっと待ったやばい😨わたしがＮＹにいる時にちょーど、Flo ridaのコンサートあんだけど…コレは……。',
      level: 2
    },
    {
        sentence: '僕はアニメとかが好きです。',
        level: 2
    },
  ];

  $scope.cardDestroyed = function(index) {
    $scope.cards.splice(index, 1);
    $scope.addCard();
  };

  $scope.addCard = function() {
    var newCard = sentences[Math.floor(Math.random() * sentences.length)];
    newCard.id = Math.random();
    $scope.cards.push(angular.extend({}, newCard));
  }

  $scope.cardPartialSwipe = function (amount) {
      console.log("Partially swiping");
      console.log(amount);
  }

  $scope.cards = [];

  for (var i = 0; i < 3; i++) {
      $scope.addCard();
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
});
