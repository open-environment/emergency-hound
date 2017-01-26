angular.module('ehApp').controller('resourceEdit2Controller',
    
    function ($scope, $location, $rootScope, cfpLoadingBar, ehConstants, dbManagerService) {

        //******************* VIEW INITIALIZATION  *************************
        $scope.resource = [];
        $scope.resourcedtls = [];
        $scope.resource = ehConstants.selectedResource;

        // datetime-picker formatting
        jQuery('.datetime-picker').datetimepicker({
            format: 'm/d/Y h:i:s A'
        });


        //get resource types ddl
        dbManagerService.getRefTable('refResourceType').then(function (res) {
            $scope.ddlResourceType = res;
        });

        //get organization ddl
        dbManagerService.getRefTable('organizations').then(function (res) {
            $scope.ddlOrganizations = res;
        });

        //get ref share type ddl
        dbManagerService.getRefTable('refShareType').then(function (res) {
            $scope.ddlShareType = res;
        });

        //get ref status ddl
        dbManagerService.getRefTable('refResourceStatus').then(function (res) {
            $scope.ddlStatusType = res;
        });

        //get resource detail info
        if ($scope.resource.resourcE_TYPE_IDX != null) {
            dbManagerService.getRefTable('refResourceTypeDtl').then(function (res) {
                
                //first list all possible resource types
                $scope.resourcedtls =
                    _.where(res, { resourcE_TYPE_IDX: $scope.resource.resourcE_TYPE_IDX });

                for (i = 0; i < $scope.resourcedtls.length; i++) {
                    console.log($scope.resourcedtls[i].resourcE_TYPE_DTL_IDX);                
                }


            });
        }

        //var xx = [];
        //for (i = 0; i < $scope.resourcedtls.length; i++) {

        //    console.log($scope.resourcedtls[i].resourcE_TYPE_DTL_IDX);

        //    dbManagerService.getRefTable('resourcedetail').then(function (res) {
        //        xx =
        //            _.findWhere(res, { resourcE_TYPE_DTL_IDX: $scope.resourcedtls[i].resourcE_TYPE_DTL_IDX });
        //        console.log(xx);
        //    });
        //}



        //******************* START MAPPING ***********************************
        var map;
        var marker;
        angular.element(document).ready(function () {
            //global map variables
            var map_options = {
                center: new google.maps.LatLng(35.5403, -95.5463),
                zoom: 9,
                maxZoom: 14,
                mapTypeId: google.maps.MapTypeId.HYBRID
            }
            map = new google.maps.Map(document.getElementById('map_canvas'), map_options);
            

            google.maps.event.addListener(map, 'click', function (event) {
                placeMarker(event.latLng);
            });

        });

        //Adds marker to map and populates lat/long textboxes
        function placeMarker(location) {
            //clear any previous markers
            if (marker) { marker.setMap(null) }

            //add marker to map
            marker = new google.maps.Marker({ position: location, map: map });

            //center map on marker
            map.setCenter(location);

            //populate textboxes
            $scope.resource.resourcE_LAT = location.lat();
            $scope.resource.resourcE_LONG = location.lng();
            $scope.$apply()
        }

        //******************* END MAPPING *************************************


        //******************* METHOD FOR SAVING RESOURCE*************************
        $scope.save = function () {
            //START VALIDATION
            if (!$scope.submitForm.$valid) {
                console.log('failed validation');
                return;
            }
            //END VALIDATION

            $scope.resource.synced = 0;
            $scope.resource.modifY_DT = moment().format();

            //save incident locally
            dbManagerService.saveResource($scope.resource)
            .then(function () {
                $scope.saveState = 'Saved';

                //if online, attempt to save remotely
                if ($rootScope.online == true) {
                    dbManagerService.syncRowToServer($scope.resource, "resources", "api/resource/SetResources", $scope.resource.resourcE_IDX)
                    .then(function () {
                        $scope.saveState = 'Saved...and synced to server';
                    });
                }
                else {
                    $scope.saveState = 'Saved locally';
                }
            });
        };


        //******************* METHOD FOR CLOSE BUTTON*************************
        $scope.close = function () {
            $location.path('/resources');
        };


        //******************* METHOD FOR VERIFY BUTTON*************************
        $scope.verify = function () {

        };



    }
);

