angular.module('ehApp').controller('dashboardController', 

    function ($scope, $http, $location, $compile, cfpLoadingBar, ehConstants, dbManagerService) {

        console.log('Start Dashboard Controller');
        cfpLoadingBar.start();

        $scope.offlineMap = '';
        $scope.selMarker;  //stores the ID of the selected marker

        //****************** POPULATE SCOPE DATA *****************************
        dbManagerService.getIncidents().then(function (res) {
            $scope.incidents = res;
            $scope.IncidentCount = res.length;

            dbManagerService.getResources().then(function (res) {
                $scope.resources = res;
                $scope.ResourceCount = res.length;

                //then populate map after data is retrieved
                setMap();
           });
        });

        dbManagerService.getPeople().then(function (res) {
            $scope.PeopleCount = res.length;
       });

        dbManagerService.getOrganizations().then(function (res) {
            $scope.OrgCount = res.length;
        });

        //check if sync is needed
        //dbManagerService.getDataByIndex('people', 'synced', 0).then(function (res) {
        //    $scope.needSync = res.length;
        //});


        //****************** MAPPING START *****************************
        function setMap() {
            try {

                angular.element(document).ready(function () {
                    //global map variables
                    var map_options = {
                        center: new google.maps.LatLng(35.5403, -95.5463),
                        zoom: 9,
                        maxZoom: 14,
                        mapTypeId: google.maps.MapTypeId.HYBRID
                    }
                    var map = new google.maps.Map(document.getElementById('map_canvas'), map_options);
                    var markers = [];
                    var bounds = new google.maps.LatLngBounds();
                    var myinfowindow = new google.maps.InfoWindow({ content: 'holding...' });     //define 1 infowindow
                    var poly;       //impacted area polygon
                    var polyOptions = {
                        strokeWeight: 2,
                        fillColor: "#fb6b5b",
                        geodesic: true
                    };
                    var polyThreatened;       //threatened area polygon
                    var polyThreatenedOptions = {
                        strokeWeight: 2,
                        fillColor: "#ffc333",
                        geodesic: true
                    };

                    //resource display
                    if ($scope.resources) {
                        //place markers
                        for (i = 0; i < $scope.resources.length; i++) {
                            try {
                                if ($scope.resources[i].resourcE_LAT != null) {

                                    var content2 = '<div id="reparse_helper_ ' + $scope.resources[i].resourcE_IDX + '">' +
                                                '<div id="siteNotice">' +
                                                '</div>' +
                                                '<h4 id="firstHeading" class="firstHeading">' + $scope.resources[i].orG_NAME + '</h4>' +
                                                '<div id="bodyContent">' +
                                                '<p><b>Type: </b> ' + $scope.resources[i].resourcE_TYPE_NAME + '</p>' +
                                                '<p><b>Description: </b><span style="white-space: pre-line">' + $scope.resources[i].resourcE_DESC + '</span></p>' +
                                                '<p><b>Status: </b> ' + $scope.resources[i].resourcE_STATUS_CD + '</p>' +
                                                '<button ng-click="editResource()" class="btn btn-rounded btn-default">Go To</button>' +
                                                '</div>' +
                                                '</div>';

                                    setMarker(map, new google.maps.LatLng($scope.resources[i].resourcE_LAT, $scope.resources[i].resourcE_LONG), $scope.resources[i].resourcE_TYPE_NAME, content2, 'r', $scope.resources[i].resourcE_IDX);
                                }
                            }
                            catch (err)
                            { }
                        }
                    }

                    if ($scope.incidents)
                    {
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
                                                '<a ng-click="editIncident()" class="btn btn-rounded btn-xs btn-default"><i class="fa fa-pencil fa-success"></i></a>' +
                                                '</div>' +
                                                '</div>';

                                    setMarker(map, new google.maps.LatLng($scope.incidents[i].incidenT_LAT, $scope.incidents[i].incidenT_LONG), $scope.incidents[i].incidenT_NAME, content2, 'i', $scope.incidents[i].incidenT_IDX);
                                }
                            }
                            catch (err)
                            { }
                        }
                    }

                    // generic function for adding a marker to map
                    function setMarker(map2, position, title, content, typ, id) {
                        var marker;
                        var markerOptions = {
                            position: position,
                            map: map2,
                            icon: typ === 'r' ? 'images/pin8.png' : 'images/pin9a.png',
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


                    //add google map listener for idle (retrieve EPA data)
                    google.maps.event.addListener(map, 'idle', function () {
                        // send the new bounds back to your server
                        latTop = this.getBounds().getNorthEast().lat();
                        longEast = this.getBounds().getNorthEast().lng();
                        latBot = this.getBounds().getSouthWest().lat();
                        longWest = this.getBounds().getSouthWest().lng();
                        PopulateEPAData(latBot, latTop, longWest, longEast, map, myinfowindow);
                    });

                });
            }
            catch (err) {
                $scope.offlineMap = 'Maps are unavailable in offline mode';
            }
        }


        //function to populate data from EPA
        function PopulateEPAData(latBot, latTop, longWest, longEast, map, info_window) {

            var i = 0;

            //GET DATA FROM EPA
            var site = 'http://iaspub.epa.gov/enviro/efservice/multisystem/minLatitude/' + latBot + '/maxLatitude/' + latTop + '/minLongitude/' + longWest + '/maxLongitude/' + longEast + '/rows/1:100';
            var yql = 'http://query.yahooapis.com/v1/public/yql?q=' + encodeURIComponent('select * from xml where url="' + site + '"') + '&format=xml&callback=?';
            // Request that YSQL string, and run a callback function.
            // Pass a defined function to prevent cache-busting.
            $.getJSON(yql, function (data) {

                //convert to XML
                var xml = $.parseXML(data.results[0]);

                //loop through each FacilitySite
                $(xml).find("FacilitySite").each(function () {

                    // create a marker
                    var facid = $(this).find("FacilityRegistryIdentifier").text();
                    var fac = $(this).find("FacilitySiteName").text();
                    var addy = $(this).find("LocationAddressText").text() + "<br/>" + $(this).find("LocalityName").text() + ", " + $(this).find("StateUSPSCode").text() + $(this).find("LocationZIPCode").text()
                    var link = "<a href='http://oaspub.epa.gov/enviro/multisys2_v2.get_list?facility_uin=" + facid + "' target='blank'>EPA Data</a>"
                    var latlng1 = new google.maps.LatLng($(this).find("LatitudeMeasure").text(), $(this).find("LongitudeMeasure").text());
                    var marker1 = new google.maps.Marker({
                        position: latlng1,
                        map: map,
                        //animation: google.maps.Animation.DROP,
                        icon: "images/circle_b.png",
                        title: 'Facility'
                    });

                    //create an info window
                    (function (i, marker1) {
                        google.maps.event.addListener(marker1, 'click', function () {
                            info_window.setContent("<b>" + fac + "</b><br/><br/>" + link + "<br/><br/>" + addy);
                            info_window.open(map, marker1);
                            map.panTo(latlng1);
                        });

                    })(i, marker1);

                    i++;
                });
            });

        };


        //****************** MAPPING END *******************************



        //declare method when sync link is clicked
        $scope.sync = function () {
            console.log('starting sync');
            dbManagerService.sync();
            $location.path('/confirm');
        };

        $scope.editResource = function () {
            ehConstants.selectedResource =
                _.findWhere($scope.resources, { resourcE_IDX: $scope.selMarker });
            $location.path('/resourceEdit2');
        };

        $scope.editIncident = function () {            
            ehConstants.selectedIncident =
                _.findWhere($scope.incidents, { incidenT_IDX: $scope.selMarker });
            $location.path('/incidentEdit');
        };


        cfpLoadingBar.complete();
        console.log('End Dashboard Controller');
    }

);
    