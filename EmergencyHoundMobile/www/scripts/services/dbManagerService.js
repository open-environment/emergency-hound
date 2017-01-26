angular.module('ehApp').factory('dbManagerService', ['$q', '$http', '$rootScope', 'dbConstants', 'ehConstants', 'uuidService', 'localStorageService',
    function ($q, $http, $rootScope, dbConstants, ehConstants, uuidService, localStorageService) {
        
        console.log('dbManager entered');
        //declare database object
        var db = window.indexedDB ||
                    window.mozIndexedDB ||
                    window.webkitIndexedDB ||
                    window.msIndexedDB ||
                    window.shimIndexedDB;
        var setUp = false;


    //**********************************************
    //method for initializing database
    //**********************************************
    function init2() {
        //console.log('Initialize database');

        var deferred = $q.defer();

        if (setUp) {
            deferred.resolve(true);
            return deferred.promise;
        }

        var openDB = window.indexedDB ||
                    window.mozIndexedDB ||
                    window.webkitIndexedDB ||
                    window.msIndexedDB ||
                    window.shimIndexedDB;

        openDB = window.indexedDB.open(dbConstants.name, dbConstants.version);

        //this is called the first time on the browser to create the database
        openDB.onupgradeneeded = function (e) {
            console.log('Running onupgradeneeded');

            //var thisDb = e.target.result;
            db = e.target.result;

            //***********************************************************************************************
            //****************** CREATE LOCAL DATABASE STRUCTURE ********************************************
            //***********************************************************************************************

            //****************** CREATE RESOURCES TABLE *****************************************************
            if (!db.objectStoreNames.contains('resources')) {
                console.log('creating resources table');
                var _resources = db.createObjectStore('resources', { keyPath: "resourcE_IDX" });
                _resources.createIndex('orG_IDX', 'orG_IDX', { unique: false });
                _resources.createIndex('resourcE_TYPE_IDX', 'resourcE_TYPE_IDX', { unique: false });
                _resources.createIndex('resourcE_COUNT', 'resourcE_COUNT', { unique: false });
                _resources.createIndex('resourcE_UNIT', 'resourcE_UNIT', { unique: false });
                _resources.createIndex('resourcE_DESC', 'resourcE_DESC', { unique: false });
                _resources.createIndex('resourcE_LAT', 'resourcE_LAT', { unique: false });
                _resources.createIndex('resourcE_LONG', 'resourcE_LONG', { unique: false });
                _resources.createIndex('sharE_TYPE', 'sharE_TYPE', { unique: false });
                _resources.createIndex('resourcE_STATUS_CD', 'resourcE_STATUS_CD', { unique: false });
                _resources.createIndex('resourcE_EXP_DT', 'resourcE_EXP_DT', { unique: false });
                _resources.createIndex('verifY_DT', 'verifY_DT', { unique: false });
                _resources.createIndex('acT_IND', 'acT_IND', { unique: false });
                _resources.createIndex('creatE_USERIDX', 'creatE_USERIDX', { unique: false });
                _resources.createIndex('creatE_DT', 'creatE_DT', { unique: false });
                _resources.createIndex('modifY_USERIDX', 'modifY_USERIDX', { unique: false });
                _resources.createIndex('modifY_DT', 'modifY_DT', { unique: false });

                _resources.createIndex('resourcE_TYPE_NAME', 'resourcE_TYPE_NAME', { unique: false });
                _resources.createIndex('resourcE_TYPE_DESC', 'resourcE_TYPE_DESC', { unique: false });
                _resources.createIndex('resourcE_KIND', 'resourcE_KIND', { unique: false });
                _resources.createIndex('resourcE_CATEGORY', 'resourcE_CATEGORY', { unique: false });
                _resources.createIndex('orG_NAME', 'orG_NAME', { unique: false });
                _resources.createIndex('resourcE_STATUS_NAME', 'resourcE_STATUS_NAME', { unique: false });
                _resources.createIndex('caN_EDIT', 'caN_EDIT', { unique: false });
                _resources.createIndex('synced', 'synced', { unique: false });
            }

            //****************** CREATE RESOURCE DETAIL TABLE *****************************************************
            if (!db.objectStoreNames.contains('resourcedetail')) {
                var _resourcedetail = db.createObjectStore('resourcedetail', { keyPath: "resourcE_DTL_IDX" });
                _resourcedetail.createIndex('resourcE_IDX', 'resourcE_IDX', { unique: false });
                _resourcedetail.createIndex('resourcE_TYPE_DTL_IDX', 'resourcE_TYPE_DTL_IDX', { unique: false });
                _resourcedetail.createIndex('valu', 'valu', { unique: false });
                _resourcedetail.createIndex('acT_IND', 'acT_IND', { unique: false });
                _resourcedetail.createIndex('creatE_USERIDX', 'creatE_USERIDX', { unique: false });
                _resourcedetail.createIndex('creatE_DT', 'creatE_DT', { unique: false });
                _resourcedetail.createIndex('modifY_USERIDX', 'modifY_USERIDX', { unique: false });
                _resourcedetail.createIndex('modifY_DT', 'modifY_DT', { unique: false });
                _resourcedetail.createIndex('caN_EDIT', 'caN_EDIT', { unique: false });
                _resourcedetail.createIndex('synced', 'synced', { unique: false });
            }

            //****************** CREATE RESOURCE VERIFY TABLE *****************************************************
            if (!db.objectStoreNames.contains('resourceverify')) {
                var _resourceverify = db.createObjectStore('resourceverify', { keyPath: "resourcE_VER_HIST_IDX" });
                _resourceverify.createIndex('resourcE_IDX', 'resourcE_IDX', { unique: false });
                _resourceverify.createIndex('verificatioN_DT', 'verificatioN_DT', { unique: false });
                _resourceverify.createIndex('verifieD_BY_IDX', 'verifieD_BY_IDX', { unique: false });
                _resourceverify.createIndex('verifieD_BY_NAME', 'verifieD_BY_NAME', { unique: false });
                _resourceverify.createIndex('acT_IND', 'acT_IND', { unique: false });
                _resourceverify.createIndex('creatE_USERIDX', 'creatE_USERIDX', { unique: false });
                _resourceverify.createIndex('creatE_DT', 'creatE_DT', { unique: false });
                _resourceverify.createIndex('caN_EDIT', 'caN_EDIT', { unique: false });
                _resourceverify.createIndex('synced', 'synced', { unique: false });
            }

            //****************** CREATE PEOPLE TABLE *****************************************************
            if (!db.objectStoreNames.contains('people')) {
                var _people = db.createObjectStore('people', { keyPath: "individuaL_IDX" });
                _people.createIndex('orG_IDX', 'orG_IDX', { unique: false });
                _people.createIndex('indV_FIRST_NAME', 'indV_FIRST_NAME', { unique: false });
                _people.createIndex('indV_MID_NAME', 'indV_MID_NAME', { unique: false });
                _people.createIndex('indV_LAST_NAME', 'indV_LAST_NAME', { unique: false });
                _people.createIndex('indV_DOB', 'indV_DOB', { unique: false });
                _people.createIndex('indV_PHONE', 'indV_PHONE', { unique: false });
                _people.createIndex('indV_EMAIL', 'indV_EMAIL', { unique: false });
                _people.createIndex('adD_LINE_ADR', 'adD_LINE_ADR', { unique: false });
                _people.createIndex('adD_CITY', 'adD_CITY', { unique: false });
                _people.createIndex('adD_STATE', 'adD_STATE', { unique: false });
                _people.createIndex('adD_ZIP', 'adD_ZIP', { unique: false });
                _people.createIndex('modifY_USERIDX', 'modifY_USERIDX', { unique: false });
                _people.createIndex('modifY_DT', 'modifY_DT', { unique: false });
                _people.createIndex('indV_AFFILIATION', 'indV_AFFILIATION', { unique: false });
                _people.createIndex('acT_IND', 'acT_IND', { unique: false });
                _people.createIndex('synced', 'synced', { unique: false });
            }

            //****************** CREATE QUALIFICATIONS TABLE *****************************************************
            if (!db.objectStoreNames.contains('qualifications')) {
                console.log('creating qualifications');

                var _tbl = db.createObjectStore('qualifications', { keyPath: "qualificatioN_IDX" });
                _tbl.createIndex('orG_IDX', 'orG_IDX', { unique: false });
                _tbl.createIndex('individuaL_IDX', 'individuaL_IDX', { unique: false });
                _tbl.createIndex('quaL_TYPE_IDX', 'quaL_TYPE_IDX', { unique: false });
                _tbl.createIndex('efF_DATE', 'efF_DATE', { unique: false });
                _tbl.createIndex('exP_DATE', 'exP_DATE', { unique: false });
                _tbl.createIndex('acT_IND', 'acT_IND', { unique: false });
                _tbl.createIndex('creatE_USERIDX', 'creatE_USERIDX', { unique: false });
                _tbl.createIndex('creatE_DT', 'creatE_DT', { unique: false });
                _tbl.createIndex('modifY_USERIDX', 'modifY_USERIDX', { unique: false });
                _tbl.createIndex('modifY_DT', 'modifY_DT', { unique: false });
                _tbl.createIndex('synced', 'synced', { unique: false });
            }

            //****************** CREATE INCIDENTS TABLE *****************************************************
            if (!db.objectStoreNames.contains('incidents')) {
                var _incidents = db.createObjectStore('incidents', { keyPath: "incidenT_IDX" });

                _incidents.createIndex('orG_IDX', 'orG_IDX', { unique: false });
                _incidents.createIndex('incidenT_ID', 'incidenT_ID', { unique: false });
                _incidents.createIndex('incidenT_NAME', 'incidenT_NAME', { unique: false });
                _incidents.createIndex('incidenT_DESC', 'incidenT_DESC', { unique: false });
                _incidents.createIndex('inC_MANAGEMENT_ORG_CD', 'inC_MANAGEMENT_ORG_CD', { unique: false });
                _incidents.createIndex('incidenT_START_DT', 'incidenT_START_DT', { unique: false });
                _incidents.createIndex('incidenT_END_DT', 'incidenT_END_DT', { unique: false });
                _incidents.createIndex('incidenT_COMPLEX_LVL', 'incidenT_COMPLEX_LVL', { unique: false });
                _incidents.createIndex('incidenT_LOC_DESC', 'incidenT_LOC_DESC', { unique: false });
                _incidents.createIndex('incidenT_LAT', 'incidenT_LAT', { unique: false });
                _incidents.createIndex('incidenT_LONG', 'incidenT_LONG', { unique: false });
                _incidents.createIndex('incidenT_STATE', 'incidenT_STATE', { unique: false });
                _incidents.createIndex('incidenT_CNTY', 'incidenT_CNTY', { unique: false });
                _incidents.createIndex('incidenT_CITY', 'incidenT_CITY', { unique: false });
                _incidents.createIndex('incidenT_LAND_SURVEY', 'incidenT_LAND_SURVEY', { unique: false });
                _incidents.createIndex('incidenT_SIZE', 'incidenT_SIZE', { unique: false });
                _incidents.createIndex('incidenT_SIZE_UNIT', 'incidenT_SIZE_UNIT', { unique: false });
                _incidents.createIndex('incidenT_PCT_CONTAINED', 'incidenT_PCT_CONTAINED', { unique: false });
                _incidents.createIndex('incidenT_HAZ_MAT', 'incidenT_HAZ_MAT', { unique: false });
                _incidents.createIndex('incidenT_WEATHER', 'incidenT_WEATHER', { unique: false });
                _incidents.createIndex('incidenT_COSTS', 'incidenT_COSTS', { unique: false });
                _incidents.createIndex('incidenT_TOTAL_COSTS', 'incidenT_TOTAL_COSTS', { unique: false });
                _incidents.createIndex('acT_IND', 'acT_IND', { unique: false });
                _incidents.createIndex('creatE_USERIDX', 'creatE_USERIDX', { unique: false });
                _incidents.createIndex('creatE_DT', 'creatE_DT', { unique: false });
                _incidents.createIndex('modifY_USERIDX', 'modifY_USERIDX', { unique: false });
                _incidents.createIndex('modifY_DT', 'modifY_DT', { unique: false });
                _incidents.createIndex('sharE_TYPE', 'sharE_TYPE', { unique: false });
                _incidents.createIndex('incidenT_PRIORITY', 'incidenT_PRIORITY', { unique: false });

                _incidents.createIndex('orG_NAME', 'orG_NAME', { unique: false });
                _incidents.createIndex('impactedArea', 'impactedArea', { unique: false });
                _incidents.createIndex('threatenedArea', 'threatenedArea', { unique: false });
                _incidents.createIndex('caN_EDIT', 'caN_EDIT', { unique: false });
                _incidents.createIndex('synced', 'synced', { unique: false });

            }

            //****************** CREATE INCIDENT STATUSES TABLE *****************************************************
            if (!db.objectStoreNames.contains('incidentstatuses')) {
                var _incidentstatuses = db.createObjectStore('incidentstatuses', { keyPath: "inC_STATUS_IDX" });
                _incidentstatuses.createIndex('incidenT_IDX', 'incidenT_IDX', { unique: false });
                _incidentstatuses.createIndex('statuS_DT', 'statuS_DT', { unique: false });
                _incidentstatuses.createIndex('statuS_TYPE_CD', 'statuS_TYPE_CD', { unique: false });
                _incidentstatuses.createIndex('statuS_DESC', 'statuS_DESC', { unique: false });
                _incidentstatuses.createIndex('acT_IND', 'acT_IND', { unique: false });
                _incidentstatuses.createIndex('creatE_USERIDX', 'creatE_USERIDX', { unique: false });
                _incidentstatuses.createIndex('creatE_DT', 'creatE_DT', { unique: false });
                _incidentstatuses.createIndex('modifY_USERIDX', 'modifY_USERIDX', { unique: false });
                _incidentstatuses.createIndex('modifY_DT', 'modifY_DT', { unique: false });
                _incidentstatuses.createIndex('caN_EDIT', 'caN_EDIT', { unique: false });
                _incidentstatuses.createIndex('synced', 'synced', { unique: false });
            }


            //****************** CREATE DOCUMENTS TABLE *****************************************************
            if (!db.objectStoreNames.contains('documents')) {
                var _documents = db.createObjectStore('documents', { keyPath: "doC_IDX" });

                _documents.createIndex('orG_IDX', 'orG_IDX', { unique: false });
                _documents.createIndex('orG_NAME', 'orG_NAME', { unique: false });
                _documents.createIndex('doC_NAME', 'doC_NAME', { unique: false });
                _documents.createIndex('doC_TYPE', 'doC_TYPE', { unique: false });
                _documents.createIndex('doC_FILE_TYPE', 'doC_FILE_TYPE', { unique: false });
                _documents.createIndex('doC_COMMENT', 'doC_COMMENT', { unique: false });
                _documents.createIndex('doC_AUTHOR', 'doC_AUTHOR', { unique: false });
                _documents.createIndex('sharE_TYPE', 'sharE_TYPE', { unique: false });
                _documents.createIndex('doC_STATUS_TYPE', 'doC_STATUS_TYPE', { unique: false });
                _documents.createIndex('creatE_USERIDX', 'creatE_USERIDX', { unique: false });
                _documents.createIndex('creatE_DT', 'creatE_DT', { unique: false });
                _documents.createIndex('canEdit', 'canEdit', { unique: false });
                _documents.createIndex('synced', 'synced', { unique: false });
            }

            //****************** CREATE REF SHARE TYPE TABLE ************************************************
            if (!db.objectStoreNames.contains('refShareType')) {
                var _refShareType = db.createObjectStore('refShareType', { keyPath: "sharE_TYPE" });
                _refShareType.createIndex('sharE_DESC', 'sharE_DESC', { unique: false });
            }

            //****************** CREATE REF RESOURCE STATUS TABLE ************************************************
            if (!db.objectStoreNames.contains('refResourceStatus')) {
                var _refResourceStatus = db.createObjectStore('refResourceStatus', { keyPath: "resourcE_STATUS_CD" });
                _refResourceStatus.createIndex('resourcE_STATUS_NAME', 'resourcE_STATUS_NAME', { unique: false });
            }

            //****************** CREATE REF QUAL TYPE TABLE ************************************************
            if (!db.objectStoreNames.contains('refQualType')) {
                var _refQualType = db.createObjectStore('refQualType', { keyPath: "quaL_TYPE_IDX" });
                _refQualType.createIndex('quaL_CAT_IDX', 'quaL_CAT_IDX', { unique: false });
                _refQualType.createIndex('quaL_TYPE_CD', 'quaL_TYPE_CD', { unique: false });
                _refQualType.createIndex('quaL_TYPE_NAME', 'quaL_TYPE_NAME', { unique: false });
                _refQualType.createIndex('quaL_TYPE_DESC', 'quaL_TYPE_DESC', { unique: false });
                _refQualType.createIndex('orG_IDX', 'orG_IDX', { unique: false });
            }

            //****************** CREATE REF INCIDENT PRIORITY TABLE ************************************************
            if (!db.objectStoreNames.contains('refIncidentPriority')) {
                var _refIncidentPriority = db.createObjectStore('refIncidentPriority', { keyPath: "incidenT_PRIORITY" });
                _refIncidentPriority.createIndex('sorT_ORD', 'sorT_ORD', { unique: false });
            }

            //****************** CREATE REF RESOURCE TYPE TABLE ************************************************
            if (!db.objectStoreNames.contains('refResourceType')) {
                var _refResourceType = db.createObjectStore('refResourceType', { keyPath: "resourcE_TYPE_IDX" });
                _refResourceType.createIndex('resourcE_FEMA_ID', 'resourcE_FEMA_ID', { unique: false });
                _refResourceType.createIndex('resourcE_TYPE_NAME', 'resourcE_TYPE_NAME', { unique: false });
                _refResourceType.createIndex('resourcE_TYPE_DESC', 'resourcE_TYPE_DESC', { unique: false });
                _refResourceType.createIndex('resourcE_FUNCTION', 'resourcE_FUNCTION', { unique: false });
                _refResourceType.createIndex('resourcE_CATEGORY', 'resourcE_CATEGORY', { unique: false });
                _refResourceType.createIndex('resourcE_KIND', 'resourcE_KIND', { unique: false });
                _refResourceType.createIndex('resourcE_DISCIPLINE', 'resourcE_DISCIPLINE', { unique: false });
                _refResourceType.createIndex('resourcE_CORE_CAP', 'resourcE_CORE_CAP', { unique: false });
                _refResourceType.createIndex('resourcE_ORDERING_INST', 'resourcE_ORDERING_INST', { unique: false });
                _refResourceType.createIndex('resourcE_FLAVOR_COUNT', 'resourcE_FLAVOR_COUNT', { unique: false });
                _refResourceType.createIndex('orG_IDX', 'orG_IDX', { unique: false });
            }

            if (!db.objectStoreNames.contains('refResourceTypeDtl')) {
                var _refResourceTypeDtl = db.createObjectStore('refResourceTypeDtl', { keyPath: "resourcE_TYPE_DTL_IDX" });
                _refResourceTypeDtl.createIndex('resourcE_TYPE_IDX', 'resourcE_TYPE_IDX', { unique: false });
                _refResourceTypeDtl.createIndex('component', 'component', { unique: false });
                _refResourceTypeDtl.createIndex('metric', 'metric', { unique: false });
                _refResourceTypeDtl.createIndex('capability', 'capability', { unique: false });
                _refResourceTypeDtl.createIndex('orderinG_SEQ', 'orderinG_SEQ', { unique: false });
            }

            //****************** CREATE REF ORGANIZATIONS TABLE *********************************************
            if (!db.objectStoreNames.contains('organizations')) {
                var _organizations = db.createObjectStore('organizations', { keyPath: "orG_IDX" });
                _organizations.createIndex('orG_NAME', 'orG_NAME', { unique: false });
                _organizations.createIndex('orG_DESC', 'orG_DESC', { unique: false });
            }



            //after pulling everything, let's sync it all 
            //_sync();


            //db.close();
        };

        //handle errors
        openDB.onerror = function (e) {
            console.log('Error opening db');
            deferred.reject(e.toString());
        };

        //when opened
        openDB.onsuccess = function (e) {
            console.log('IndexedDB successfully opened...');
            db = e.target.result;

            db.onerror = function (event) {
                deferred.reject('Database error: ' + event.target.errorCode);
            }

            setUp = true;
            
            deferred.resolve(true);
        };

        return deferred.promise;
    }


    //**********************************************
    //method for deleting the database
    //**********************************************
    function _delDB() {
        console.log('Attempting to delete database: ' + dbConstants.name);

        var delRequest = indexedDB.deleteDatabase(dbConstants.name);

        //delete attempt is blocked
        delRequest.onblocked = function () {
            console.log("Delete blocked.");
        }

        //delete attempt had error
        delRequest.onerror =
            function () {
                console.log("Error deleting the DB");
            };

        //delete database succeeded
        delRequest.onsuccess = function () {
            console.log("Database deleted");
        };

    }


    //**********************************************
    //methods for retrieving syncing data from server
    //**********************************************
    function _sync() {

        var dt = '1970-01-01';
        if (localStorageService.get('syncpull') != null)
        {
            dt = localStorageService.get('syncpull').date;
        }
        console.log('STARTING MASTER SYNC*******************************');

        var deferred = $q.defer();

        _syncResources().then( function(){

            //if sync Resources failed, then don't try pulling from other tables
            _syncOrganizations();
            _syncResourceDetails();
            _syncPeople();
            _syncQualifications();
            _syncIncidents();
            _syncIncidentStatuses();
            _syncDocuments();

            _syncRefShareType();
            _syncRefIncidentPriority(dt);
            _syncRefResourceStatus(dt);
            _syncRefResourceType(dt);
            _syncRefResourceTypeDtl(dt);
            _syncRefQualType(dt);

            //when done syncing, set the new last sync date
            localStorageService.set('syncpull', { date: moment() });

        });

    }

    function _syncResources() {

        console.log('sync resources start');

        var deferred = $q.defer();
        var data;
        init2().then(function () {

            $http.get($rootScope.serverBaseUrl + 'api/resource/GetAllResources?token=' + $rootScope.token)
                .success(function (data) {
                    var t = db.transaction(["resources"], "readwrite");

                    for (i = 0; i < data.length; i++) {
                        //first grab local data if there is any
                        var existingRec = t.objectStore('resources').get(data[i].resourcE_IDX);
                        if (existingRec != null) {

                            //don't pull if device has unsynced record
                            if (existingRec.synced != "false") {
                                t.objectStore("resources").put({
                                    resourcE_IDX: data[i].resourcE_IDX,
                                    orG_IDX: data[i].orG_IDX,
                                    resourcE_TYPE_IDX: data[i].resourcE_TYPE_IDX,
                                    resourcE_COUNT: data[i].resourcE_COUNT,
                                    resourcE_UNIT: data[i].resourcE_UNIT,
                                    resourcE_DESC: data[i].resourcE_DESC,
                                    resourcE_LAT: data[i].resourcE_LAT,
                                    resourcE_LONG: data[i].resourcE_LONG,
                                    sharE_TYPE: data[i].sharE_TYPE,
                                    resourcE_STATUS_CD: data[i].resourcE_STATUS_CD,
                                    resourcE_EXP_DT: data[i].resourcE_EXP_DT,
                                    verifY_DT: data[i].verifY_DT,
                                    acT_IND: data[i].acT_IND ? 1: 0,
                                    creatE_USERIDX: data[i].creatE_USERIDX,
                                    creatE_DT: data[i].creatE_DT,
                                    modifY_USERIDX: data[i].modifY_USERIDX,
                                    modifY_DT: data[i].modifY_DT,
                                    resourcE_TYPE_NAME: data[i].resourcE_TYPE_NAME,
                                    resourcE_TYPE_DESC: data[i].resourcE_TYPE_DESC,
                                    resourcE_KIND: data[i].resourcE_KIND,
                                    resourcE_CATEGORY: data[i].resourcE_CATEGORY,
                                    orG_NAME: data[i].orG_NAME,
                                    resourcE_STATUS_NAME: data[i].resourcE_STATUS_NAME,
                                    caN_EDIT: data[i].caN_EDIT == true ? 1 : 0,
                                    synced: 1
                                });
                                console.log('pulled resource: ' + data[i].resourcE_IDX);
                            }
                            else {
                                console.log('did not pull resource: ' + data[i].resourcE_IDX);
                            }
                        }
                    }

                    t.onerror = function (event) {
                        console.log(event.target.error.message);
                    };

                    t.oncomplete = function (event) {
                        deferred.resolve();
                    };
                })
                .error(function (data) {
                    console.log('GET ALL RESOURCES FAILED?');
                    $rootScope.online = false;
//                    $rootScope.$apply();
                });
        });

        console.log('sync resources end');

        return deferred.promise;
    }

    function _syncResourceDetails() {

        console.log('sync resource details start');

        var deferred = $q.defer();
        var data;
        init2().then(function () {

            $http.get($rootScope.serverBaseUrl + 'api/resource/GetAllResourceDetails?token=' + $rootScope.token)
                .success(function (data) {
                    var t = db.transaction(["resourcedetail"], "readwrite");

                    for (i = 0; i < data.length; i++) {
                        //first grab local data if there is any
                        var existingRec = t.objectStore("resourcedetail").get(data[i].resourcE_DTL_IDX);
                        if (existingRec != null) {

                            //only pull if server date 
                            if (existingRec.synced != "false") {
                                t.objectStore("resourcedetail").put({
                                    resourcE_DTL_IDX: data[i].resourcE_DTL_IDX,
                                    resourcE_IDX: data[i].resourcE_IDX,
                                    resourcE_TYPE_DTL_IDX: data[i].resourcE_TYPE_DTL_IDX,
                                    valu: data[i].value,
                                    acT_IND: (data[i].acT_IND ? 1 : 0),
                                    creatE_USERIDX: data[i].creatE_USERIDX,
                                    creatE_DT: data[i].creatE_DT,
                                    modifY_USERIDX: data[i].modifY_USERIDX,
                                    modifY_DT: data[i].modifY_DT,
                                    caN_EDIT: (data[i].caN_EDIT ? 1 : 0),
                                    synced: 1
                                });
                                console.log('pulled resource detail: ' + data[i].resourcE_DTL_IDX);
                            }
                            else {
                                console.log('did not pull resource detail: ' + data[i].resourcE_DTL_IDX);
                            }
                        }
                    }

                    t.onerror = function (event) {
                        console.log(event.target.error.name);
                    };

                    t.oncomplete = function (event) {
                        deferred.resolve();
                    };
                })
                .error(function (data) {
                    console.log('GET ALL RESOURCE DETAILS FAILED');
                });
        });

        console.log('sync resource detail end');

        return deferred.promise;
    }

    function _syncPeople() {

        console.log('sync people start');

        var deferred = $q.defer();
        var data;
        init2().then(function () {

            $http.get($rootScope.serverBaseUrl + 'api/resource/GetAllPeople?token=' + $rootScope.token)
                .success(function (data) {

                    var t = db.transaction(["people"], "readwrite");

                    for (i = 0; i < data.length; i++) {
                        //first grab local data if there is any
                        var existingRec = t.objectStore("people").get(data[i].individuaL_IDX);
                        if (existingRec != null) {

                            //only pull if server date 
                            if (existingRec.synced != "false") {
                                t.objectStore("people").put({
                                    individuaL_IDX: data[i].individuaL_IDX,
                                    orG_IDX: data[i].orG_IDX,
                                    indV_FIRST_NAME: data[i].indV_FIRST_NAME,
                                    indV_MID_NAME: data[i].indV_MID_NAME,
                                    indV_LAST_NAME: data[i].indV_LAST_NAME,
                                    indV_DOB: data[i].indV_DOB,
                                    indV_PHONE: data[i].indV_PHONE,
                                    indV_EMAIL: data[i].indV_EMAIL,
                                    adD_LINE_ADR: data[i].adD_LINE_ADR,
                                    adD_CITY: data[i].adD_CITY,
                                    adD_STATE: data[i].adD_STATE,
                                    adD_ZIP: data[i].adD_ZIP,
                                    modifY_USERIDX: data[i].modifY_USERIDX,
                                    modifY_DT: data[i].modifY_DT,
                                    indV_AFFILIATION: data[i].indV_AFFILIATION,
                                    acT_IND: data[i].acT_IND ? 1 : 0,
                                    synced: 1
                                });
                                console.log('pulled person: ' + data[i].individuaL_IDX);

                            }
                            else {
                                console.log('did not pull person: ' + data[i].individuaL_IDX);
                            }
                        }
                    }

                    t.onerror = function (event) {
                        console.log(event.target.error.name);
                    };

                    t.oncomplete = function (event) {
                        deferred.resolve();
                    };
                });

        });

        console.log('sync people end');

        return deferred.promise;
    }

    function _syncQualifications() {

        console.log('sync qualifications start');

        var deferred = $q.defer();
        var data;
        init2().then(function () {

            $http.get($rootScope.serverBaseUrl + 'api/resource/GetAllQualifications?token=' + $rootScope.token)
                .success(function (data) {

                    var t = db.transaction(["qualifications"], "readwrite");

                    for (i = 0; i < data.length; i++) {
                        //first grab local data if there is any
                        var existingRec = t.objectStore("qualifications").get(data[i].qualificatioN_IDX);
                        if (existingRec != null) {

                            //only pull if server date 
                            if (existingRec.synced != "false") {
                                t.objectStore("qualifications").put({
                                    qualificatioN_IDX: data[i].qualificatioN_IDX,
                                    orG_IDX: data[i].orG_IDX,
                                    individuaL_IDX: data[i].individuaL_IDX,
                                    quaL_TYPE_IDX: data[i].quaL_TYPE_IDX,
                                    efF_DATE: data[i].efF_DATE,
                                    exP_DATE: data[i].exP_DATE,
                                    acT_IND: data[i].acT_IND ? 1 : 0,
                                    modifY_USERIDX: data[i].modifY_USERIDX,
                                    modifY_DT: data[i].modifY_DT,
                                    synced: 1
                                });
                                console.log('pulled qualification: ' + data[i].qualificatioN_IDX);
                            }
                            else {
                                console.log('did not pull qualification: ' + data[i].qualificatioN_IDX);
                            }
                        }
                    }

                    t.onerror = function (event) {
                        console.log(event.target.error.name);
                    };

                    t.oncomplete = function (event) {
                        deferred.resolve();
                    };
                });

        });

        console.log('sync people end');

        return deferred.promise;
    }

    function _syncIncidents() {

        console.log('sync incidents start');

        var deferred = $q.defer();
        var data;
        init2().then(function () {

            $http.get($rootScope.serverBaseUrl + 'api/incident/GetAllIncidents?token=' + $rootScope.token)
                .success(function (data) {

                    var t = db.transaction(["incidents"], "readwrite");

                    for (i = 0; i < data.length; i++)
                    {
                        //first grab local data if there is any
                        var existingRec = t.objectStore("incidents").get(data[i].incidenT_IDX);
                        if (existingRec != null)
                        {

                            //only pull if server date 
                            if (existingRec.synced != "false") {
                                t.objectStore("incidents").put({
                                    incidenT_IDX: data[i].incidenT_IDX,
                                    orG_IDX: data[i].orG_IDX,
                                    incidenT_ID: data[i].incidenT_ID,
                                    incidenT_NAME: data[i].incidenT_NAME,
                                    incidenT_DESC: data[i].incidenT_DESC,
                                    inC_MANAGEMENT_ORG_CD: data[i].inC_MANAGEMENT_ORG_CD,
                                    incidenT_START_DT: data[i].incidenT_START_DT,
                                    incidenT_END_DT: data[i].incidenT_END_DT,
                                    incidenT_COMPLEX_LVL: data[i].incidenT_COMPLEX_LVL,
                                    incidenT_LOC_DESC: data[i].incidenT_LOC_DESC,
                                    incidenT_LAT: data[i].incidenT_LAT,
                                    incidenT_LONG: data[i].incidenT_LONG,
                                    incidenT_STATE: data[i].incidenT_STATE,
                                    incidenT_CNTY: data[i].incidenT_CNTY,
                                    incidenT_CITY: data[i].incidenT_CITY,

                                    incidenT_LAND_SURVEY: data[i].incidenT_LAND_SURVEY,
                                    incidenT_SIZE: data[i].incidenT_SIZE,
                                    incidenT_SIZE_UNIT: data[i].incidenT_SIZE_UNIT,
                                    incidenT_PCT_CONTAINED: data[i].incidenT_PCT_CONTAINED,
                                    incidenT_HAZ_MAT: data[i].incidenT_HAZ_MAT,
                                    incidenT_WEATHER: data[i].incidenT_WEATHER,
                                    incidenT_COSTS: data[i].incidenT_COSTS,
                                    incidenT_TOTAL_COSTS: data[i].incidenT_TOTAL_COSTS,
                                    acT_IND: data[i].acT_IND ? 1 : 0,
                                    creatE_USERIDX: data[i].creatE_USERIDX,
                                    creatE_DT: data[i].creatE_DT,
                                    sharE_TYPE: data[i].sharE_TYPE,
                                    incidenT_PRIORITY : data[i].incidenT_PRIORITY,
                                    orG_NAME: data[i].orG_NAME,
                                    impactedArea: null,
                                    threatenedArea: null,
                                    caN_EDIT: data[i].caN_EDIT,
                                    synced: 1
                                });
                                console.log('pulled inc: ' + data[i].incidenT_IDX);
                            }
                            else {
                                console.log('did not pull inc: ' + data[i].incidenT_IDX);
                            }
                        }
                    }

                    t.onerror = function (event) {
                        console.log(event.target.error.name);
                    };

                    t.oncomplete = function (event) {
                        deferred.resolve();
                    };
                });

        });

        console.log('sync incidents end');

        return deferred.promise;
    }

    function _syncIncidentStatuses() {

        console.log('sync inc status start');

        var deferred = $q.defer();
        var data;
        init2().then(function () {

            $http.get($rootScope.serverBaseUrl + 'api/incident/GetAllIncidentStatuses?token=' + $rootScope.token)
                .success(function (data) {
                    var t = db.transaction(["incidentstatuses"], "readwrite");

                    for (i = 0; i < data.length; i++) {
                        //first grab local data if there is any
                        var existingRec = t.objectStore("incidentstatuses").get(data[i].inC_STATUS_IDX);
                        if (existingRec != null) {

                            //only pull if server date 
                            if (existingRec.synced != "false") {
                                t.objectStore("incidentstatuses").put({
                                    inC_STATUS_IDX: data[i].inC_STATUS_IDX,
                                    incidenT_IDX: data[i].incidenT_IDX,
                                    statuS_DT: data[i].statuS_DT,
                                    statuS_TYPE_CD: data[i].statuS_TYPE_CD,
                                    statuS_DESC: data[i].statuS_DESC,
                                    acT_IND: (data[i].acT_IND ? 1 : 0),
                                    creatE_USERIDX: data[i].creatE_USERIDX,
                                    creatE_DT: data[i].creatE_DT,
                                    modifY_USERIDX: data[i].modifY_USERIDX,
                                    modifY_DT: data[i].modifY_DT,
                                    caN_EDIT: (data[i].caN_EDIT ? 1 : 0),
                                    synced: 1
                                });
                                console.log('pulled inc status: ' + data[i].inC_STATUS_IDX);
                            }
                            else {
                                console.log('did not pull inc status: ' + data[i].inC_STATUS_IDX);
                            }
                        }
                    }

                    t.onerror = function (event) {
                        console.log(event.target.error.name);
                    };

                    t.oncomplete = function (event) {
                        deferred.resolve();
                    };
                })
                .error(function (data) {
                    console.log('GET ALL INCIDENT STATUSES FAILED');
                });
        });

        console.log('sync incident status end');

        return deferred.promise;
    }

    function _syncIncidentAttach(incIDX) {
        var deferred = $q.defer();

        $http.get($rootScope.serverBaseUrl + 'api/incident/GetIncidentAttaches?token=' + $rootScope.token + '&IncidentIDX=' + incIDX)
        .success(function (res)
        {
            deferred.resolve(res);
        })

        return deferred.promise;
    }

    function _syncDocuments() {

        console.log('sync documents start');

        var deferred = $q.defer();
        var data;
        init2().then(function () {

            $http.get($rootScope.serverBaseUrl + 'api/document/GetDocuments?token=' + $rootScope.token)
                .success(function (data) {

                    var t = db.transaction(["documents"], "readwrite");

                    for (i = 0; i < data.length; i++) {
                        t.objectStore("documents").put({
                            doC_IDX: data[i].doC_IDX,
                            orG_IDX: data[i].orG_IDX,
                            orG_NAME: data[i].orG_NAME,
                            doC_NAME: data[i].doC_NAME,
                            doC_TYPE: data[i].doC_TYPE,
                            doC_FILE_TYPE: data[i].doC_FILE_TYPE,
                            doC_COMMENT: data[i].doC_COMMENT,
                            doC_AUTHOR: data[i].doC_AUTHOR,
                            sharE_TYPE: data[i].sharE_TYPE,
                            doC_STATUS_TYPE: data[i].doC_STATUS_TYPE,
                            creatE_USERIDX: data[i].creatE_USERIDX,
                            creatE_DT: data[i].creatE_DT,
                            canEdit: data[i].canEdit ? 1 : 0,
                            synced: 1
                        });
                        console.log('doc: ' + data[i].doC_IDX);
                    }

                    t.onerror = function (event) {
                        console.log(event.target.error.name);
                    };

                    t.oncomplete = function (event) {
                        deferred.resolve();
                    };


                });

        });

        console.log('sync documents end');

        return deferred.promise;

    }

    function _syncOrganizations() {

        console.log('sync organizations start');

        var deferred = $q.defer();
        var data;
        init2().then(function () {

            $http.get($rootScope.serverBaseUrl + 'api/ref/GetJurisdictionsMine?token=' + $rootScope.token)
                .success(function (data) {

                    var t = db.transaction(["organizations"], "readwrite");

                    for (i = 0; i < data.length; i++) {
                        t.objectStore("organizations").put({
                            orG_IDX: data[i].orG_IDX,
                            orG_NAME: data[i].orG_NAME,
                            orG_DESC: data[i].orG_DESC
                        });
                        console.log('org: ' + data[i].orG_IDX);
                    }

                    t.onerror = function (event) {
                        console.log(event.target.error.name);
                    };

                    t.oncomplete = function (event) {
                        deferred.resolve();
                    };


                });

        });

        console.log('sync organizations end');

        return deferred.promise;

    }

    function _syncRefShareType() {

        console.log('sync ref share type start');

        var deferred = $q.defer();
        var data;
        init2().then(function () {
            $http.get($rootScope.serverBaseUrl + 'api/ref/GetRefShareTypes')
                .success(function (data) {

                    var t = db.transaction(["refShareType"], "readwrite");

                    for (i = 0; i < data.length; i++) {
                        t.objectStore("refShareType").put({
                            sharE_TYPE: data[i].sharE_TYPE,
                            sharE_DESC: data[i].sharE_DESC
                        });
                        console.log('share type: ' + data[i].sharE_TYPE);
                    }

                    t.onerror = function (event) {
                        console.log(event.target.error.name);
                    };

                    t.oncomplete = function (event) {
                        deferred.resolve();
                    };
                });
        });

        console.log('sync ref share type end');

        return deferred.promise;

    }

    function _syncRefIncidentPriority(dt) {

        var deferred = $q.defer();
        var data;
        init2().then(function () {
            $http.get($rootScope.serverBaseUrl + 'api/ref/GetRefIncidentPriority?dt=' + dt)
                .success(function (data) {

                    var t = db.transaction(["refIncidentPriority"], "readwrite");

                    for (i = 0; i < data.length; i++) {
                        t.objectStore("refIncidentPriority").put({
                            incidenT_PRIORITY: data[i].incidenT_PRIORITY,
                            sorT_ORD: data[i].sorT_ORD
                        });
                        console.log('incident priority: ' + data[i].incidenT_PRIORITY);
                    }

                    if (data.length === 0)
                        console.log('No new Incident Priority to retrieve');

                    t.onerror = function (event) {
                        console.log(event.target.error.name);
                    };

                    t.oncomplete = function (event) {
                        deferred.resolve();
                    };
                });
        });

        console.log('sync ref incident priority  end');

        return deferred.promise;

    }

    function _syncRefResourceStatus(dt) {

        var deferred = $q.defer();
        var data;
        init2().then(function () {
            $http.get($rootScope.serverBaseUrl + 'api/ref/GetRefResourceStatus?dt=' + dt)
                .success(function (data) {

                    var t = db.transaction(["refResourceStatus"], "readwrite");

                    for (i = 0; i < data.length; i++) {
                        t.objectStore("refResourceStatus").put({
                            resourcE_STATUS_CD: data[i].resourcE_STATUS_CD,
                            resourcE_STATUS_NAME: data[i].resourcE_STATUS_NAME
                        });
                    }

                    if (data.length === 0)
                        console.log('No new Resource Statuses to retrieve');

                    t.onerror = function (event) {
                        console.log(event.target.error.name);
                    };

                    t.oncomplete = function (event) {
                        deferred.resolve();
                    };
                });
        });

        return deferred.promise;
    }

    function _syncRefResourceType(dt) {

        var deferred = $q.defer();
        var data;

        init2().then(function () {
            $http.get($rootScope.serverBaseUrl + 'api/ref/GetRefResourceTypeByUserIDX?token=' + $rootScope.token + '&dt=' + dt)
                .success(function (data) {

                    var t = db.transaction(["refResourceType"], "readwrite");

                    for (i = 0; i < data.length; i++) {
                        console.log('resource type: ' + data[i].resourcE_TYPE_IDX);
                        t.objectStore("refResourceType").put({
                            resourcE_TYPE_IDX: data[i].resourcE_TYPE_IDX,
                            resourcE_FEMA_ID: data[i].resourcE_FEMA_ID,
                            resourcE_TYPE_NAME: data[i].resourcE_TYPE_NAME,
                            resourcE_TYPE_DESC: data[i].resourcE_TYPE_DESC,
                            resourcE_FUNCTION: data[i].resourcE_FUNCTION,
                            resourcE_CATEGORY: data[i].resourcE_CATEGORY,
                            resourcE_KIND: data[i].resourcE_KIND,
                            resourcE_DISCIPLINE: data[i].resourcE_DISCIPLINE,
                            resourcE_CORE_CAP: data[i].resourcE_CORE_CAP,
                            resourcE_ORDERING_INST: data[i].resourcE_ORDERING_INST,
                            resourcE_FLAVOR_COUNT: data[i].resourcE_FLAVOR_COUNT,
                            orG_IDX: data[i].orG_IDX
                        });
                    }

                    if (data.length === 0)
                        console.log('No new Resource Types to retrieve');

                    t.onerror = function (event) {
                        console.log(event.target.error.name);
                    };

                    t.oncomplete = function (event) {
                        deferred.resolve();
                    };
                });
        });

        return deferred.promise;
    }

    function _syncRefResourceTypeDtl(dt) {

        var deferred = $q.defer();
        var data;

        init2().then(function () {
            $http.get($rootScope.serverBaseUrl + 'api/ref/GetRefResourceTypeDtlByUserIDX?token=' + $rootScope.token + '&dt=' + dt)
                .success(function (data) {

                    var t = db.transaction(["refResourceTypeDtl"], "readwrite");

                    for (i = 0; i < data.length; i++) {
                        //console.log('resource type dtl: ' + data[i].resourcE_TYPE_DTL_IDX);
                        t.objectStore("refResourceTypeDtl").put({
                            resourcE_TYPE_DTL_IDX: data[i].resourcE_TYPE_DTL_IDX,
                            resourcE_TYPE_IDX: data[i].resourcE_TYPE_IDX,
                            component: data[i].component,
                            metric: data[i].metric,
                            capability: data[i].capability
                        });
                    }

                    if (data.length === 0)
                        console.log('No new Resource Types Details to retrieve');

                    t.onerror = function (event) {
                        console.log(event.target.error.name);
                    };

                    t.oncomplete = function (event) {
                        deferred.resolve();
                    };
                });
        });

        return deferred.promise;
    }

    function _syncRefQualType(dt) {

        var deferred = $q.defer();
        var data;

        init2().then(function () {
            $http.get($rootScope.serverBaseUrl + 'api/ref/GetRefQualTypeByUserIDX?token=' + $rootScope.token + '&dt=' + dt)
                .success(function (data) {

                    var t = db.transaction(["refQualType"], "readwrite");

                    for (i = 0; i < data.length; i++) {
                        console.log('ref qual type: ' + data[i].quaL_TYPE_IDX);
                        t.objectStore("refQualType").put({
                            quaL_TYPE_IDX: data[i].quaL_TYPE_IDX,
                            quaL_CAT_IDX: data[i].quaL_CAT_IDX,
                            quaL_TYPE_CD: data[i].quaL_TYPE_CD,
                            quaL_TYPE_NAME: data[i].quaL_TYPE_NAME,
                            quaL_TYPE_DESC: data[i].quaL_TYPE_DESC,
                            orG_IDX: data[i].orG_IDX
                        });
                    }

                    if (data.length === 0)
                        console.log('No new Ref Qual Types to retrieve');

                    t.onerror = function (event) {
                        console.log(event.target.error.name);
                    };

                    t.oncomplete = function (event) {
                        deferred.resolve();
                    };
                });
        });

        return deferred.promise;
    }



    //**********************************************
    //methods for getting data from local IndexDB
    //**********************************************
    function _getResources() {
        var deferred = $q.defer();

        init2().then(function () {

            var resources = [];

            var handleResult = function (event) {
                var cursor = event.target.result;
                if (cursor) {
                    resources.push(cursor.value);
                    cursor.continue();
                }
            };

            var transaction = db.transaction(["resources"], "readonly");
            var objectStore = transaction.objectStore("resources");
            objectStore.openCursor().onsuccess = handleResult;

            transaction.oncomplete = function (event) {
                deferred.resolve(resources);
            };

        });

        return deferred.promise;
    }

    function _getPeople() {
        console.log('getting people');
        var deferred = $q.defer();

        init2().then(function () {

            var people = [];

            var handleResult = function (event) {
                var cursor = event.target.result;
                if (cursor) {
                    people.push(cursor.value);
                    cursor.continue();
                }
            };

            var transaction = db.transaction(["people"], "readonly");
            var objectStore = transaction.objectStore("people");
            objectStore.openCursor().onsuccess = handleResult;

            transaction.oncomplete = function (event) {
                deferred.resolve(people);
            };

        });

        return deferred.promise;
    }

    function _getIncidents()
    {
        var deferred = $q.defer();

        init2().then(function () {

            var incidents = [];

            var handleResult = function (event) {
                var cursor = event.target.result;
                if (cursor) {
                    incidents.push(cursor.value);
                    cursor.continue();
                }
            };

            var transaction = db.transaction(["incidents"], "readonly");
            var objectStore = transaction.objectStore("incidents");
            objectStore.openCursor().onsuccess = handleResult;

            transaction.oncomplete = function (event) {
                deferred.resolve(incidents);
            };

        });

        return deferred.promise;
    }

    function _getDocuments() {
        var deferred = $q.defer();

        init2().then(function () {

            var documents = [];

            var handleResult = function (event) {
                var cursor = event.target.result;
                if (cursor) {
                    documents.push(cursor.value);
                    cursor.continue();
                }
            };

            var transaction = db.transaction(["documents"], "readonly");
            var objectStore = transaction.objectStore("documents");
            objectStore.openCursor().onsuccess = handleResult;

            transaction.oncomplete = function (event) {
                deferred.resolve(documents);
            };

        });

        return deferred.promise;
    }

    function _getOrganizations() {
        var deferred = $q.defer();

        init2().then(function () {

            var organizations = [];

            var handleResult = function (event) {
                var cursor = event.target.result;
                if (cursor) {
                    organizations.push(cursor.value);
                    cursor.continue();
                }
            };

            var transaction = db.transaction(["organizations"], "readonly");
            var objectStore = transaction.objectStore("organizations");
            objectStore.openCursor().onsuccess = handleResult;

            transaction.oncomplete = function (event) {
                deferred.resolve(organizations);
            };

        });

        return deferred.promise;
    }

    function _getRefTable(tableName) {
        var deferred = $q.defer();

        init2().then(function () {

            var collection = [];

            var handleResult = function (event) {
                var cursor = event.target.result;
                if (cursor) {
                    collection.push(cursor.value);
                    cursor.continue();
                }
            };

            var transaction = db.transaction([tableName], "readonly");
            var objectStore = transaction.objectStore(tableName);
            objectStore.openCursor().onsuccess = handleResult;

            transaction.oncomplete = function (event) {
                deferred.resolve(collection);
            };

        });

        return deferred.promise;
    }

    function _getDataByIndex(tableName, idx, val) {
        var deferred = $q.defer();

        init2().then(function () {

            var collection = [];

            var handleResult = function (event) {
                var cursor = event.target.result;
                if (cursor) {
                    collection.push(cursor.value);
                    cursor.continue();
                }
            };

            var transaction = db.transaction([tableName], "readonly");
            var objectStore = transaction.objectStore(tableName);
            var index = objectStore.index(idx);
            index.openCursor(val).onsuccess = handleResult;
            
            transaction.oncomplete = function (event) {
                deferred.resolve(collection);
            };

        });

        return deferred.promise;
    }


    //**********************************************
    //methods for saving data to local IndexedDb
    //**********************************************
    function _saveIncident(incident)
    {
        var deferred = $q.defer();

        var store = db.transaction(["incidents"], 'readwrite').objectStore("incidents");
        var putRequest = store.put(incident);

        putRequest.onerror = function (event) {
            console.log('error saving incident locally');
        };
        putRequest.onsuccess = function (event) {
            console.log('success saving incident locally');            
        };

        deferred.resolve(incident);

        return deferred.promise;
    }

    function _saveResource(resource) {
        var deferred = $q.defer();

        var store = db.transaction(["resources"], 'readwrite').objectStore("resources");
        var putRequest = store.put(resource);

        putRequest.onerror = function (event) {
            console.log('error saving resource locally');
        };
        putRequest.onsuccess = function (event) {
            console.log('success saving resource locally');
        };

        deferred.resolve(resource);

        return deferred.promise;
    }

    function _saveTable(row, dbTable) {
        var deferred = $q.defer();

        var store = db.transaction([dbTable], 'readwrite').objectStore(dbTable);
        var putRequest = store.put(row);

        putRequest.onerror = function (event) {
            console.log('error saving ' + dbTable + ' locally');
        };
        putRequest.onsuccess = function (event) {
            console.log('success saving ' + dbTable + ' locally');
        };

        deferred.resolve(row);

        return deferred.promise;
    }


    //**********************************************
    //methods for syncing data to remote server
    //**********************************************
    function _syncRowToServer(recordObj, strTable, apiPath, primaryKeyValue)
    {
        var deferred = $q.defer();

        $http.post($rootScope.serverBaseUrl + apiPath + '?token=' + $rootScope.token, JSON.stringify(recordObj),
            { 
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .success(function (data) {
                console.log('SYNC RECORD TO SERVER SUCCESS');

                //sync cleanup: 
                //if active, update the synced status to true
                if (recordObj.acT_IND == true)
                {
                    recordObj.synced = 1;
                    _saveTable(recordObj, strTable);
                }
                else
                {
                    _deleteLocalRecord(primaryKeyValue, strTable);
                }

                deferred.resolve(recordObj);

            })
        .error(function (data) {
            console.log('SYNC RECORD TO SERVER FAILED');
        });

        return deferred.promise;
    }

    function _syncTableToServer(strTable) {
        console.log(strTable);
        var deferred = $q.defer();
        var newRecs = [];
        _getRefTable(strTable).then(function (res) {

            newRecs =
                    _.where(res, { synced: 0 });

        });

        console.log(newRecs);

        deferred.resolve(row);

        return deferred.promise;

    };

    function _syncAllPendingToServer() {
        _syncTableToServer('people');
    };

    //**********************************************
    //methods for creating new records
    //**********************************************
    function _newIncident() {
        return {
            incidenT_IDX: uuidService.newuuid(), 
            orG_IDX: null,
            incidenT_ID: null,
            incidenT_NAME: null, 
            incidenT_DESC: null,
            inC_MANAGEMENT_ORG_CD: null, 
            incidenT_START_DT: null, 
            incidenT_END_DT: null, 
            incidenT_COMPLEX_LVL: null,
            incidenT_LOC_DESC: null,
            incidenT_LAT: null, 
            incidenT_LONG: null, 
            incidenT_STATE: null, 
            incidenT_CNTY: null,
            incidenT_CITY: null, 
            incidenT_LAND_SURVEY: null,
            incidenT_SIZE: null, 
            incidenT_SIZE_UNIT: null,
            incidenT_PCT_CONTAINED: null,
            incidenT_HAZ_MAT: null,
            incidenT_WEATHER: null, 
            incidenT_COSTS: null,
            incidenT_TOTAL_COSTS: null, 
            acT_IND: 1, 
            creatE_USERIDX: null,
            creatE_DT: null,
            modifY_USERIDX: null, 
            modifY_DT: null, 
            sharE_TYPE: null,
            orG_NAME: null,
            caN_EDIT: 1,
            impactedArea: null,
            threatenedArea: null, 
            synced: 0
        };
    };

    function _newIncidentStatus(incIDX) {
        return {
            inC_STATUS_IDX: uuidService.newuuid(),
            incidenT_IDX: incIDX,
            statuS_DT: null,
            statuS_TYPE_CD: null,
            statuS_DESC: null,
            acT_IND: 1,
            creatE_USERIDX: null,
            creatE_DT: null,
            modifY_USERIDX: null,
            modifY_DT: null,
            caN_EDIT: 1,
            synced: 0
        };
    };



    function _newResource() {
        return {
            resourcE_IDX: uuidService.newuuid(),
            orG_IDX: null,
            resourcE_TYPE_IDX: null,
            resourcE_COUNT: null,
            resourcE_UNIT: 'count',
            resourcE_DESC: null,
            resourcE_LAT: null,
            resourcE_LONG: null,
            sharE_TYPE: 'All Jurisdictions',
            resourcE_STATUS_CD: 'A',
            verifY_DT: null,
            acT_IND: 1,
            creatE_USERIDX: null,
            creatE_DT: null,
            modifY_USERIDX: null,
            modifY_DT: null,
            resourcE_TYPE_NAME: null,
            resourcE_TYPE_DESC: null,
            resourcE_KIND: null,
            resourcE_CATEGORY: null,
            orG_NAME: null,
            resourcE_STATUS_NAME: null,
            caN_EDIT: 1,
            synced: 0
        };
    };

    function _newPerson() {
        return {
            individuaL_IDX: uuidService.newuuid(),
            orG_IDX: null, 
            indV_FIRST_NAME: null,
            indV_MID_NAME: null, 
            indV_LAST_NAME: null,
            indV_DOB: null, 
            indV_PHONE: null, 
            indV_EMAIL: null,
            adD_LINE_ADR: null,
            adD_CITY: null, 
            adD_STATE: null,
            adD_ZIP: null,
            modifY_USERIDX: null,
            modifY_DT: null, 
            indV_AFFILIATION: null,
            acT_IND: 1, //true
            synced: 0   //false
        };
    };

    function _newQualification(orgIDX, indIDX) {
        return {
            qualificatioN_IDX: uuidService.newuuid(),
            orG_IDX: orgIDX,
            individuaL_IDX: indIDX,
            quaL_TYPE_IDX: null,
            efF_DATE: null,
            exP_DATE: null,
            acT_IND: 1,
            modifY_USERIDX: null,
            modifY_DT: null,
            synced: 0
        };
    };



    //**********************************************
    //methods for deleting local records
    //**********************************************
    function _deleteLocalRecord(keyValue, strTable) {
        var deferred = $q.defer();

        var store = db.transaction([strTable], 'readwrite').objectStore(strTable);
        var putRequest = store.delete(keyValue);

        putRequest.onerror = function (event) {
            console.log('error deleting record locally');
        };
        putRequest.onsuccess = function (event) {
            console.log('success deleting record locally');
        };

        deferred.resolve();

        return deferred.promise;
    }


    return {
        delDB: _delDB,
        sync: _sync,
        syncResources: _syncResources,
        syncResourceDetails: _syncResourceDetails,
        syncPeople: _syncPeople,
        syncQualifications: _syncQualifications,
        syncIncidents: _syncIncidents,
        syncIncidentStatuses: _syncIncidentStatuses,
        syncIncidentAttach: _syncIncidentAttach,
        syncDocuments: _syncDocuments,
        syncOrganizations: _syncOrganizations,
        syncRefShareType: _syncRefShareType,
        syncRefResourceStatus: _syncRefResourceStatus,
        syncRefQualType: _syncRefQualType,

        getResources: _getResources,
        getPeople: _getPeople,
        getIncidents: _getIncidents,
        getOrganizations: _getOrganizations,
        getDocuments: _getDocuments,
        getRefTable: _getRefTable,
        getDataByIndex: _getDataByIndex,

        saveIncident: _saveIncident,
        saveResource: _saveResource,
        saveTable: _saveTable,

        deleteLocalRecord: _deleteLocalRecord,

        syncRowToServer: _syncRowToServer,
        syncAllPendingToServer: _syncAllPendingToServer, 

        newResource: _newResource,
        newIncident: _newIncident,
        newIncidentStatus: _newIncidentStatus,
        newPerson: _newPerson,
        newQualification: _newQualification,
        init: init2 
};

    console.log('dbManager exited');


}]);
