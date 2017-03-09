angular.module('ehApp').controller('incidentMap2Controller',

    function ($scope, $location, $rootScope, $compile, cfpLoadingBar, ehConstants, dbManagerService) {

        //******************* VIEW INITIALIZATION  *************************
        $scope.incident = ehConstants.selectedIncident;
        $scope.selMarker;  //stores the ID of the selected marker


        //pull user locations from server
        dbManagerService.syncUserLocations().then(function () {
            dbManagerService.getRefTable('user_locations').then(function (res) {
                $scope.user_locations = res;
                //then populate map after data is retrieved
                setMap();
            })
        });


        //*****MAPPING START *****
        function setMap() {

            $scope.offlineMap = '';
            try {
                angular.element(document).ready(function () {

                    //display map
                    var posLat = 35.982;
                    var posLng = -96.1473;

                    var mapOptions = {
                        center: new google.maps.LatLng(posLat, posLng),
                        zoom: 13,
                        mapTypeId: google.maps.MapTypeId.HYBRID
                    };
                    var map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
                    var myinfowindow = new google.maps.InfoWindow({ content: 'holding...' });     //define 1 infowindow
                    var markers = [];

                    //display initial marker if there is one
                    if ($scope.incident.incidenT_LAT != null) {
                        var marker = new google.maps.Marker({
                            position: new google.maps.LatLng($scope.incident.incidenT_LAT, $scope.incident.incidenT_LONG),
                            map: map,
                            title: 'incident location',
                            icon: 'images/pin9a.png',
                        });
                        var center = new google.maps.LatLng($scope.incident.incidenT_LAT, $scope.incident.incidenT_LONG);
                        map.panTo(center);
                    }
                    else {
                        //otherwise recenter map on user's current location
                        if (navigator.geolocation) {
                            navigator.geolocation.getCurrentPosition(onSuccess, onError, { enableHighAccuracy: true });
                            function onSuccess(position) {
                                var center = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
                                map.panTo(center);
                            }
                            function onError(error) {
                                console.log("Geolocation failed: " + error.code + " Error:" + error.message);
                            }
                        }
                    }


                    //people display
                    if ($scope.user_locations) {
                        console.log($scope.user_locations.length);
                        //place markers
                        for (i = 0; i < $scope.user_locations.length; i++) {
                            try {
                                if ($scope.user_locations[i].lATITUDE != null) {

                                    var content2 = '<div id="reparse_helper_ ' + $scope.user_locations[i].uSER_IDX + '">' +
                                                '<div id="siteNotice">' +
                                                '</div>' +
                                                '<h4 id="firstHeading" class="firstHeading">' + $scope.user_locations[i].uSER_FULL_NAME + '</h4>' +
                                                '<div id="bodyContent">' +
                                                ($scope.user_locations[i].useR_PHONE ? '<p><a href="tel: ' + $scope.user_locations[i].useR_PHONE + '" target="_blank"><span class="btn btn-rounded btn-default fa fa-phone"></span></a>' : '') +
                                                ($scope.user_locations[i].useR_PHONE ? '<p><a href="sms: ' + $scope.user_locations[i].useR_PHONE + '" target="_blank"><span class="btn btn-rounded btn-default fa fa-comments-o"></span></a></p>' : '') +
                                                '</div>' +
                                                '</div>';

                                    setMarker(map, new google.maps.LatLng($scope.user_locations[i].lATITUDE, $scope.user_locations[i].lONGITUDE), $scope.user_locations[i].uSER_FULL_NAME, content2, 'r', $scope.user_locations[i].uSER_IDX);
                                }
                            }
                            catch (err)
                            { }
                        }
                    }


                    //global map variables
                    var selBtn = 'option1';      //selected button group

                    //click handler for map legend - will set the map click function
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



                    // generic function for adding a marker to map
                    function setMarker(map2, position, title, content, typ, id) {
                        var marker;
                        var markerOptions = {
                            position: position,
                            map: map2,
                            icon: 'images/pin-male.png',
                            title: title
                        };

                        marker = new google.maps.Marker(markerOptions);
                        markers.push(marker); // add marker to array

                        google.maps.event.addListener(marker, 'click', function () {
                            // close window if not undefined
                            if (myinfowindow !== void 0) {
                                myinfowindow.close();
                            }
                            // create new window
                            var compiled = $compile(content)($scope);

                            var infoWindowOptions = {
                                content: compiled[0]
                            };
                            $scope.selMarker = id;
                            $scope.$apply();
                            myinfowindow = new google.maps.InfoWindow(infoWindowOptions);
                            myinfowindow.open(map2, marker);
                        });

                        bounds.extend(marker.position);

                        //now fit the map to the newly inclusive bounds
                        if (bounds.contains(marker.getPosition()))
                            map2.fitBounds(bounds);

                    }


                });



            }
            catch (err) {
                $scope.offlineMap = 'Maps are unavailable in offline mode';
            }
            //*****MAPPING END *****
        }


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