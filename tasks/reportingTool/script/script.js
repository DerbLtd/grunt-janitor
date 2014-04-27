// Loadins the json

//if (window.File && window.FileReader && window.FileList && window.Blob) {
//} else {
//    alert('The File APIs are not fully supported in this browser.');
//}

function loadJSON(callback) {

    var xobj = new XMLHttpRequest();
    xobj.overrideMimeType("application/json");
    xobj.open('GET', 'data/report.json', true);
    xobj.onreadystatechange = function () {
        if (xobj.readyState == 4 && xobj.status == "200") {
            // Required use of an anonymous callback as .open will NOT return a value but simply returns undefined in asynchronous mode
            callback(xobj.responseText);
        }
    };
    xobj.send(null);
}

var jsonData;

var app = angular.module("main", []);

app.controller("mainController", [
    '$scope', '$log', function($scope) {

        $scope.filterInfoActive = true;
        $scope.filterWarningActive = true;
        $scope.filterErrorActive = true;

        $scope.isFilterInfoActive = function() { return $scope.filterInfoActive }
        $scope.isFilterWarningActive = function() { return $scope.filterWarningActive }
        $scope.isFilterErrorActive = function() { return $scope.filterErrorActive }

        $scope.toggleFilterInfo = function() { $scope.filterInfoActive = !$scope.filterInfoActive }
        $scope.toggleFilterWarning = function() { $scope.filterWarningActive = !$scope.filterWarningActive}
        $scope.toggleFilterError = function() { $scope.filterErrorActive = !$scope.filterErrorActive }

        $scope.errors = undefined
        $scope.warnings = undefined
        $scope.infos = undefined

        loadJSON(function(response) {
            // Parse JSON string into object
            jsonData = JSON.parse(response);
            $scope.report = jsonData;
            $scope.$apply()
        })

        $scope.getFileName = function(result) {
            return $scope.report.files[result].name;
        }

        $scope.getResultSeverity = function(result) {
            return $scope.report.tests[result.test].severity
        }

        $scope.isSeverityFilterActive = function(result) {
            var severity = $scope.getResultSeverity(result);
            switch (severity) {
                case "error":
                    return $scope.filterErrorActive
                    break;
                case "warning":
                    return $scope.filterWarningActive
                    break;
                case "info":
                    return $scope.filterInfoActive
                    break;
            }
        }

        $scope.getResultFilePath = function(result) {
            return $scope.report.files[result.file].path
        }

        $scope.getTestDescription = function(result) {
            return $scope.report.tests[result.test].description
        }
    }
]);
