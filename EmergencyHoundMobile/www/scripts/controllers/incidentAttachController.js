angular.module('ehApp').controller('incidentAttachController', 
    
    function ($scope, $http, $location, $rootScope, cfpLoadingBar, ehConstants, dbManagerService, cameraService) {

        //******************* VIEW INITIALIZATION  *************************
        $scope.incident = ehConstants.selectedIncident;
        $scope.urls = $rootScope.serverBaseUrl;

        //* GET EXISTING ATTACHMENTS (ONLY IF ONLINE)
        if ($rootScope.online) {
            dbManagerService.syncIncidentAttach(ehConstants.selectedIncident.incidenT_IDX).then(function (res) {
                $scope.gallery = res;
            });
        }

        //******************* METHOD FOR TAKING PICTURE*************************
        $scope.takePicture = function () {
            var options = {
                    quality: 50,
                    //destinationType: Camera.DestinationType.DATA_URL,
                    destinationType: Camera.DestinationType.FILE_URI,
                    sourceType: Camera.PictureSourceType.CAMERA,
                    allowEdit: true,
                    encodingType: Camera.EncodingType.JPEG,
                    targetWidth: 300,
                    targetHeight: 300,
                    popoverOptions: CameraPopoverOptions,
                    saveToPhotoAlbum: false
                };

            cameraService.getPicture(options).then(function (imageData) {
                $scope.picData = imageData;
//                $scope.cameraPic = "data:image/jpeg;base64," + imageData;
            }, function (err) {
                console.log(err);
            });
        };


        //******************* METHOD FOR CHOOSING PICTURE*************************
        $scope.choosePicture = function () {
            var options = {
                quality: 75,
                destinationType: Camera.DestinationType.DATA_URL,
                sourceType: Camera.PictureSourceType.PHOTOLIBRARY,
                allowEdit: true,
                encodingType: Camera.EncodingType.JPEG,
                targetWidth: 300,
                targetHeight: 300,
                popoverOptions: CameraPopoverOptions,
                saveToPhotoAlbum: false
            };

            cameraService.getPicture(options).then(function (imageData) {
                $scope.cameraPic = "data:image/jpeg;base64," + imageData;
                console.log(imageData);
            }, function (err) {
                console.err(err);
            });
            console.log('choose picture');
        };

        //******************** METHOD FOR SENDING PICTURE *************************
        $scope.sendPicture = function () {
            function win(r) {
                console.log("Code = " + r.responseCode);
                console.log("Response = " + r.response);
                console.log("Sent = " + r.bytesSent);

                //* GET EXISTING ATTACHMENTS (ONLY IF ONLINE)
                if ($rootScope.online) {
                    dbManagerService.syncIncidentAttach(ehConstants.selectedIncident.incidenT_IDX).then(function (res) {
                        $scope.gallery = res;
                    });
                }

            }

            function fail(error) {
                alert("An error has occurred: Code = " + error.code);
                console.log("upload error source " + error.source);
                console.log("upload error target " + error.target);
            }


            console.log($scope.picData);
            var myImg = $scope.picData;
            var serverPath = encodeURI($rootScope.serverBaseUrl + "api/incident/AttachImageUpload/");
            var options = {
                fileKey: "file",
                fileName: "file.jpg",
                chunkedMode: false,
                mimeType: "image/jpg",
                params: { 'directory': 'upload', 'fileName': $scope.incident.incidenT_IDX }
            };
            options.headers = {
                Connection: "close"
            };

            var ft = new FileTransfer();
         //   ft.onprogress = function (progressEvent) {
         //       if (progressEvent.lengthComputable) {
         //           loadingStatus.setPercentage(progressEvent.loaded / progressEvent.total);
         //       } else {
         //           loadingStatus.increment();
         //       }
         //   };

            console.log(serverPath);
            ft.upload(myImg, serverPath, win, fail, options);
        };
    }

);