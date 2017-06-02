$(function () {
    var MapMapDefinition;
    MapMapDefinition = 1  
    urlMain = '/WCFWebService.svc/AllWayPointsGetInfo';
    Data = '?MapSelection=' + MapSelection;
    //    Data = '?MapDefinition=' = '"' + MapSelection + '"';
    urlMain = urlMain + Data;
    var currencies = [];
    $.ajax({
        type: "GET",
        contentType: "application/json; charset=utf-8",
        // Change Here To Change The Web Service Needed
        //url: "/AzureHooknLineAjax.svc/HelloWorld",
        url: urlMain,
        // Change Here To Change The Parameters Needed
       // data: "{}",
        dataType: "json",
        async: false,
        success: function (Result) {                       

            for (var i in Result) {
                var WayPointName = Result[i].WayPointName;
                var WayPointValue = {
                    value: Result[i].WayPointName,
                    Latitude: Result[i].Latitude,
                    Longitude: Result[i].Longitude,
                    WayPointID: Result[i].WayPointID
                };
                currencies.push(WayPointValue);
            }
            // setup autocomplete function pulling from currencies[] array
            $('#autocomplete').autocomplete({
                lookup: currencies,
                onSelect: function (suggestion) {
                    //var thehtml = '<strong>Point:</strong> ' + suggestion.value + ' <br> <strong>Symbol:</strong> ' + suggestion.Latitude;                    
                    document.getElementById('WayPointLabel').innerHTML = suggestion.value;
                    document.getElementById('LatitudeLabel').innerHTML = suggestion.Latitude;
                    document.getElementById('LongitudeLabel').innerHTML = suggestion.Longitude;
                    var thehtml = '<strong>Point:</strong> ' + suggestion.value + ' <br> <strong>Symbol:</strong> ' + suggestion.Latitude;
                    $('#outputcontent').html(thehtml);                    
                }
            });
        },
        error: function (Result) {
            alert("Error");
        }
    });
});