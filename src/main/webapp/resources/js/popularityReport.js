var popularityReportApp = angular.module('popularityReportPageApp',[]);

popularityReportApp.controller('popularityReportController', function($scope,$http) {
	$scope.csrfToken = {};
	
	$scope.initToken = function(name, token){
		console.log("In init");
		$scope.orders = {};
		$scope.csrfToken.name = name;
		$scope.csrfToken.token = token;
	}

	$scope.getData = function(){

		var fromTime = new Date($scope.fromDate+" "+$scope.fromTime+":00");
		var toTime = new Date($scope.toDate+" "+$scope.toTime+":00");
		 if(fromTime>toTime/*&&toTime>new Date()*/){
			 alert("Start time cannot be more than End Time");
		 } else {
			 var start = $scope.fromDate+" "+$scope.fromTime+":00";
			 var end = $scope.toDate+" "+$scope.toTime+":00";		
			 var xsrf = {
					_csrf : $scope.csrfToken.token,
					fromDate: start,
					toDate: end
				};
				$http({
					url:'./getPopularityReport',
					method:'GET',
					 params: xsrf,
					responseType: "json",
					headers: { 'Content-Type': 'application/x-www-form-urlencoded'},
					withCredentials : true
				}).success(function(data){
					console.log("getPopularity"+data.length);
					$scope.items = data;
				}).error(function(data){
					console.log("getPopularityReport Error");
				});
		 }		

	}
});
