angular.module('ehApp').controller('peopleController',

    function ($scope, $location, $http, cfpLoadingBar, ehConstants, dbManagerService) {

        console.log('Start People Controller');
        cfpLoadingBar.start();

        $scope.people = [];
        $scope.orgs = [];

        dbManagerService.getPeople().then(function (people) {
            $scope.people = people;

            //populate orgs lookup
            var orgs = dbManagerService.getOrganizations().then(function (orgs) {
                $scope.orgs = orgs;
            });
        });

        cfpLoadingBar.complete();
        console.log('End People Controller');


        //******************************************
        //method for clicking Add new button
        //******************************************
        $scope.addPerson = function () {
            ehConstants.selectedPerson = dbManagerService.newPerson();
            $location.path('/personEdit');
        };

        //******************************************
        //method for clicking Edit button
        //******************************************
        $scope.editPerson = function (id) {
            ehConstants.selectedPerson =
                _.findWhere($scope.people, { individuaL_IDX: id });
            $location.path('/personEdit');
        };

        //******************************************
        //method for clicking Delete button
        //******************************************
        $scope.deletePerson = function (id) {

        };

}
);