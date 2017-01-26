﻿angular.module('ehApp').factory('cameraService', ['$q',
    function ($q) {

        return {
            getPicture: function (options) {
                var q = $q.defer();
                
                navigator.camera.getPicture(function (result) {
                    // Do any magic you need
                    q.resolve(result);
                }, function (err) {
                    q.reject(err);
                }, options);

                return q.promise;
            }
        }
    }]);