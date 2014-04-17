// Loadins the json

//if (window.File && window.FileReader && window.FileList && window.Blob) {
//} else {
//    alert('The File APIs are not fully supported in this browser.');
//}

function loadJSON(callback) {

    var xobj = new XMLHttpRequest();
    xobj.overrideMimeType("application/json");
    xobj.open('GET', 'data/reportExample.json', true);
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

        loadJSON(function(response) {
            // Parse JSON string into object
            jsonData = JSON.parse(response);
            $scope.report = {
                files: jsonData.files,
                tests: jsonData.tests,
                results: jsonData.results
            };
            $scope.$apply()
        });

        $scope.getFileName = function(result) {
            return $scope.report.files[result].name;
        };
    }
]);
