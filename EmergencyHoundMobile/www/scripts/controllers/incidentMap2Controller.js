angular.module('ehApp').controller('incidentMap2Controller',

    function ($scope, $location, $rootScope, cfpLoadingBar, ehConstants, dbManagerService) {

        //******************* VIEW INITIALIZATION  *************************
        $scope.incident = ehConstants.selectedIncident;

        //*****MAPPING START *****
        $scope.offlineMap = '';
        try {
            angular.element(document).ready(function () {

                //getcurrentlatlong();

                //function getcurrentlatlong() {
                //    if (navigator.geolocation) {
                //        console.log('navigator.geolocation is supported');
                //        navigator.geolocation.getCurrentPosition(onSuccess, onError, { enableHighAccuracy: true });
                //    }
                //    else {
                //        console.log('navigator.geolocation not supported');
                //    }
                //}
                //function onSuccess(position) {     
                //    console.log("onSuccess called");
                //    var lat = position.coords.latitude;
                //    var longi = position.coords.longitude;
                //    console.log("latitude is: " + lat + " longitude is: " + longi);

                //    mapCenter = new google.maps.LatLng(lat, longi),
                //    myOptions = {
                //        zoom: 13,
                //        mapTypeId: google.maps.MapTypeId.HYBRID,
                //        center: mapCenter,
                //    },
                //    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions)
                //}
                //function onError(error) {
                //    console.log("Getting the error" + error.code + "\nerror mesg :" + error.message);
                //}


                var posLat = 35.982;
                var posLng = -96.1473;
                var marker;
                var mapOptions = {
                    center: new google.maps.LatLng(posLat, posLng),
                    zoom: 13,
                    mapTypeId: google.maps.MapTypeId.HYBRID
                };
                var map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);



                //global map variables
                var selBtn = 'option1';      //selected button group

                ////click handler for map legend - will set the map click function
                $('.lbl-btn-group').on('click', function () {

                //    google.maps.event.clearListeners(map, 'click');
                //    console.log('breakpoint3');

                    selBtn = $(this).find('input').attr('id');

                    if (selBtn === 'option1') {
                        google.maps.event.addListener(map, 'click', function (event) {
                            placeMarker(marker, event.latLng);
                        });
                    };
                //    else if (selBtn === 'option2') {
                //        AddImpactedPoly();
                //    }
                //    else if (selBtn === 'option3') {
                //        AddThreatenedPoly();
                //    };
                });

                //display initial marker if there is one
                if ($scope.incident.incidenT_LAT != null && $scope.incident.incidenT_LONG) {
                    marker = new google.maps.Marker({
                        position: new google.maps.LatLng($scope.incident.incidenT_LAT, $scope.incident.incidenT_LONG),
                        map: map,
                        title: 'incident location',
                        icon: 'images/pin9a.png',
                    });

                }

                //function when placing single incident location
                function placeMarker(marker, location) {
                    //clear any previous markers
                    if (marker) { marker.setMap(null); }

                    //add marker to map
                    marker = new google.maps.Marker({ position: location, map: map });

                    //populate textboxes
                    $scope.incident.incidenT_LAT = location.lat();
                    $scope.incident.incidenT_LONG = location.lng();
                    $scope.$apply()
                }

            });


            //*************************************************************************************   
            //************************************* functions *************************************   
            //*************************************************************************************   

    



        }
        catch (err) {
            $scope.offlineMap = 'Maps are unavailable in offline mode';
        }
        //*****MAPPING END *****




        //******************* METHOD FOR SAVING INCIDENT*************************
        $scope.save = function () {
            //START VALIDATION
            if (!$scope.submitForm.$valid) {
                console.log('falied validation');
                return;
            }
            //END VALIDATION

            $scope.incident.synced = false;
            $scope.incident.modifY_DT = moment().format();

            //save incident locally
            dbManagerService.saveIncident($scope.incident)
            .then(function () {
                $scope.saveState = 'Saved';

                //if online, attempt to save remotely
                if ($rootScope.online == true) {
                    dbManagerService.syncRowToServer($scope.incident, "incidents", "api/incident/SetIncidents", $scope.incident.incidenT_IDX)
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
            $location.path('/incidents');
        };


    }

);