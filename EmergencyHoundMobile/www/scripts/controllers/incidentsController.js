angular.module('ehApp').controller('incidentsController',

    function ($scope, $location, $http, $compile, cfpLoadingBar, ehConstants, dbManagerService) {

        console.log('Start Incidents Controller');
        cfpLoadingBar.start();

        //******************* POPULATE SCOPE DATA  *************************
        $scope.incidents = [];
        $scope.orgs = [];
        dbManagerService.getIncidents().then(function (res) {
            $scope.incidents = res;

            //populate orgs lookup
            var orgs = dbManagerService.getOrganizations().then(function (orgs) {
                $scope.orgs = orgs;
            });

        });


        //*****MAPPING START *****
        $scope.offlineMap = '';
        $scope.selMarker;  //stores the ID of the selected marker

        try {

            angular.element(document).ready(function () {
                //global map variables
                var map_options2 = {
                    zoom: 9,
                    center: { lat: 35.479, lng: -95.510 },
                    mapTypeId: google.maps.MapTypeId.HYBRID
                };
                var map2 = new google.maps.Map(document.getElementById('map_canvas2'), map_options2);
                var markers = [];
                var bounds = new google.maps.LatLngBounds();
                var myinfowindow = new google.maps.InfoWindow({ content: 'holding...' });     //define 1 infowindow

                //create an event when tab is clicked to resize map
                $("a[href='mapz']").on('shown.bs.tab', function () {

                    //resize map so all tiles display properly
                    google.maps.event.trigger(map2, 'resize');

                    // generic function for adding a marker to map
                    function setMarker(map2, position, title, content, id) {
                        var markerOptions = {
                            position: position,
                            map: map2,
                            icon: 'images/pin9a.png',
                            title: title
                        };

                        var marker = new google.maps.Marker(markerOptions);
                        markers.push(marker); // add marker to array

                        google.maps.event.addListener(marker, 'click', function () {
                            // close any open infowindow 
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

                    //place markers
                    for (i = 0; i < $scope.incidents.length; i++) {
                        try {
                            if ($scope.incidents[i].incidenT_LAT != null) {

                                var content2 = '<div id="reparse_helper_ ' + $scope.incidents[i].incidenT_IDX + '">' +
                                            '<div id="siteNotice">' +
                                            '</div>' +
                                            '<h4 id="firstHeading" class="firstHeading">' + $scope.incidents[i].orG_NAME + '</h4>' +
                                            '<div id="bodyContent">' +
                                            '<p><b>Name: </b> ' + $scope.incidents[i].incidenT_NAME + '</p>' +
                                            '<p><b>Description: </b><span style="white-space: pre-line">' + $scope.incidents[i].incidenT_DESC + '</span></p>' +
                                            '<a ng-click="editIncidentMap()" class="btn btn-rounded btn-xs btn-default"><i class="fa fa-pencil fa-success"></i></a>' +
                                            '</div>' +
                                            '</div>';

                                setMarker(map2, new google.maps.LatLng($scope.incidents[i].incidenT_LAT, $scope.incidents[i].incidenT_LONG), $scope.incidents[i].incidenT_NAME, content2, $scope.incidents[i].incidenT_IDX);
                            }
                        }
                        catch (err)
                        { }
                    }
                });
            });



        }
        catch (err) {
            console.log(err);
            $scope.offlineMap = 'Maps are unavailable in offline mode';
        }
        //*****MAPPING END  *****


        cfpLoadingBar.complete();
        console.log('End Incidents Controller');

        //******************************************
        //method for clicking Add new button
        //******************************************
        $scope.addIncident = function () {
            ehConstants.selectedIncident = dbManagerService.newIncident();
            $location.path('/incidentEdit');
        };

        //******************************************
        //method for clicking Edit button
        //******************************************
        $scope.editIncident = function (id) {
            ehConstants.selectedIncident = _.findWhere($scope.incidents, { incidenT_IDX: id });
            $location.path('/incidentEdit');
        };

        //******************************************
        //method for clicking Edit on Map button
        //******************************************
        $scope.editIncidentMap = function () {
            ehConstants.selectedIncident = _.findWhere($scope.incidents, { incidenT_IDX: $scope.selMarker });
            $location.path('/incidentEdit');
        };


    }
);