﻿function CenterControl(controlDiv, map) {
    var chicago = { lat: 41.85, lng: -87.65 };
    // Coloring
    //controlUI.style.backgroundColor = '#fff';
    //controlUI.style.border = '2px solid #fff';
    //controlUI.style.borderRadius = '3px';
    //controlUI.style.boxShadow = '0 2px 6px rgba(0,0,0,.3)';
    // controlUI.style.marginBottom = '22px';
    //controlUI.style.textAlign = 'center';
    

    // Set CSS for the control border.
    var controlUI = document.createElement('div');

    controlUI.style.cursor = 'pointer';
    controlUI.title = 'Click to recenter the map';
    controlDiv.appendChild(controlUI);

    
    var controlUL = document.createElement('UL');    
    controlUL.Name = "ULTest";

    var controlULWeather = document.createElement('UL');
    controlULWeather.Name = "ULWeather";



    var controlLI1 = document.createElement('LI');
    controlLI1.innerHTML = "Remove All Points";
    controlLI1.className = "";
    controlLI1.addEventListener('click', function () {        
        AddKML(map);
        if (KMLAdded == false)
        {
            controlLI1.innerHTML = "Replace All Points";            
        }
        else
        {
            controlLI1.innerHTML = "Remove All Points";
        }
        });
    
    var controlLI3 = document.createElement('LI');
    controlLI3.innerHTML = "Weather Real Time";
    controlLI3.innerHTML = '<img id="WRTID" src="' + 'Images/WeatherRealTime5PercentWhite.png"' + ' alt="' + 'Locate Me"' + 'id="' + 'itemImg"' + ' style="' + 'float:center"' + '>';
    controlLI3.id = "WRT";
    controlLI3.className = "LIClass";
    controlLI3.addEventListener('click', function () {
        CurrentLat = map.getCenter().lat();
        CurrentLng = map.getCenter().lng();
        DisplayRealTimeWeather();
    });
    controlULWeather.appendChild(controlLI3);

    

    var controlLI4 = document.createElement('LI');
    controlLI4.innerHTML = "Weather Forecast";
    controlLI4.innerHTML = '<img id="WFID" src="' + 'Images/WeatherForecastThickerLines25PercentWhite.png"' + ' alt="' + 'Locate Me"' + 'id="' + 'itemImg"' + ' style="' + 'float:center"' + '>';

    controlLI4.id = "WF";
    controlLI4.className = "LIClass";
    controlLI4.addEventListener('click', function () {
        CurrentLat = map.getCenter().lat();
        CurrentLng = map.getCenter().lng();        
        DisplayWeatherForecast();
    });
    controlULWeather.appendChild(controlLI4);
       
    
    var controlLI2 = document.createElement('LI');    
    controlLI2.innerHTML = "Pick A Spot";
    controlLI2.innerHTML = '<img id="PAPID" src="' + 'Images/PickaSpotThickerlines5PercentWhite.png"' + ' alt="' + 'Pick A Spot"' + 'id="' + 'itemImg"' + ' style="' + 'float:center"' + '>';
    controlLI2.className = "LIClass";
    controlLI2.id = "PickASpot1";
    controlLI2.addEventListener('click', function () {
        CurrentZoom = map.getZoom();        
        CurrentLat = map.getCenter().lat();
        CurrentLng = map.getCenter().lng();
        document.getElementById('map').style.display = "none";
        $("#SearchableMenu").show();
        //$("#map").hide();
        //document.getElementById("map").style.width = "0%"
        $('#autocomplete').val('');
        ResetPointSelector();


        //document.getElementsById("autocomplete").value = "";

    });
    controlUL.appendChild(controlLI2);


    //controlLITest.innerHTML = '<img src="' + 'Images/SwitchMaps5Percent.png"' + ' alt="' + 'Switch Map"' + 'id="' + 'itemImg"' + ' style="' + 'float:right"' + '>';

    var controlLI70 = document.createElement('LI');
    controlLI70.id = "LM";
    //controlLI70.innerHTML = "Locate Me";
    controlLI70.innerHTML = '<img id="LMID" src="' + 'Images/LocateMe5PercentWhite.png"' + ' alt="' + 'Locate Me"' + 'id="' + 'itemImg"' + ' style="' + 'float:center"' + '>';
    //controlLI70.innerHTML = '<img src="' + 'Images/LocateMe5PercentWhite.png"' + ' alt="' + 'Locate Me"' + 'id="' + 'itemImg"' + ' style="' + 'float:center"' + '>';
    controlLI70.className = "LIClass";
    controlLI70.addEventListener('click', function () {
        //GoToCurrentPosition();
        var StringforDisplay = "Starting";
        //alert(StringforDisplay);
        //var myLatLng = { lat: 29.481, lng: -94.917 };
        if (navigator.geolocation) {

            navigator.geolocation.getCurrentPosition(function (position) {
                var pos = {
                    lat: position.coords.latitude,
                    lng: position.coords.longitude
                };
                //CurrentMarker.setPosition(new google.maps.LatLng(position.coords.latitude, position.coords.longitude));
                //map.setCenter({ lat: 29.481, lng: -94.917 });
                map.setCenter({ lat: position.coords.latitude, lng: position.coords.longitude });
                //CurrentMarker.setMap(map);
                //alert("Finished Internal 6");
            }, function () {
                handleLocationError(true, infoWindow, map.getCenter());
            });
        } else {
            // Browser doesn't support Geolocation
            handleLocationError(false, infoWindow, map.getCenter());
        }
    });
    controlUL.appendChild(controlLI70);
    
    var controlLITest = document.createElement('LI');
    //controlLITest.innerHTML = "Switch Maps";
    //controlLITest.innerHTML = '"<img src="' + 'Images/SwitchMaps.png"' + ' alt="' + '2013 Toyota Tacoma"' + 'id="' + 'itemImg"' + ' style="' + 'float:left"' + '>"';
    controlLITest.innerHTML = '<img id="SMID" src="' + 'Images/SwitchMaps5PercentWhite.png"' + ' alt="' + 'Switch Map"' + 'id="' + 'itemImg"' + ' style="' + 'float:center"' + '>';
    controlLITest.id = "WF";
    controlLITest.className = "LIClass";
    controlLITest.addEventListener('click', function () {
        // Change the map Image
        //KMLAdded == false;
        //MapSelection = $('#MapSelectorComboBox').val();
        //AddKML(map);
        $("#LoginPage").hide();
        $("#SearchScreen").hide();
        $("#map").hide();
        ResetUserPurchases();
        $('#MapSelection').show(); 

        map.setMapTypeId(google.maps.MapTypeId.SATELLITE);

    });
    controlUL.appendChild(controlLITest);

    controlUI.appendChild(controlUL);

    map.controls[google.maps.ControlPosition.TOP_RIGHT].push(controlUI);
    map.controls[google.maps.ControlPosition.LEFT_TOP].push(controlULWeather);

}
function CloseInfoWindowAndMoveMarker()
{
    try{
        infowindow.close();
        myLatLng = { lat: 19.5982, lng: -155.5186 };
        marker.setPosition(myLatLng);
    }
    catch(e)
    {
        ErrorFunction(e.message);
    }
}
function DisplayMap()
{
    try{
        $("#SearchScreen").hide();
        $("#map").show();
    }
    catch(e)
    {
        ErrorFunction(e.message);
    }
}
function LoginMain()
{    
    try {
        //document.body.style.zoom = 1.0;
        
        urlMain = '/WCFWebService.svc/LoginValidation/';
        UserName = $("#UserNameEntry").val();
        var Password = $("#PassWrdEntry").val();
        Data = '?UserName=' + UserName + '&Password=' + Password;
        urlMain = urlMain + Data;
        jQuery.ajax({
            type: 'GET',
            contentType: 'application/json;  charset=utf-8',
            url: urlMain,
            dataType: 'json',
            async: false,
            success: function (Result) {
                try {
                    if (Result == "PASS")
                        {
                    $("#LoginPage").hide();
                    $("#SearchScreen").hide();
                    $("#map").hide();
                    $('#MapSelection').show();                    
                    //document.getElementById('map').style.display = "block";
                    //initMap();
                    }
                    else if (Result == "RELOAD") {                        
                        //window.location.reload();
                        location.reload(true);
                    }
                    else
                    {
                        alert("You entered an incorrect user name or password.");
                    }
                }
                catch (e) { alert(e); }
            },
            error: function (e) { alert("Error"); alert(e.responseText); }
        });
        ResetUserPurchases();
    }
    catch (e) {
        ErrorFunction(e.message);
    }
}

function ResetPassword()
{
    try {        
        urlMain = '/WCFWebService.svc/SendEmailForNewPassword/';
        var UserName = $("#UserNameEntry").val();
        if (UserName.trim() == '') {
            alert('Please enter a user name');
        }
        else{
        Data = '?UserName=' + UserName;
        //alert("Sending your user name and passwordafddafa");
        urlMain = urlMain + Data;
        jQuery.ajax({
            type: 'GET',
            contentType: 'application/json;  charset=utf-8',
            url: urlMain,
            dataType: 'json',
            async: true,
            success: function (Result) {
                try {
                    var Sheet = Result;
                }
                catch (e) { alert(e); }
            },
            error: function (e) { alert("Error"); alert(e.responseText); }
        });
        alert("Please wait 5 - 10 minutes for an email with instructions on how to reset your password");
        }
    }
    catch (e) {
        ErrorFunction(e.message);
    }
    
}
function SubmitPassword() {
    try {
        var Password;
        //var NewPassword = $("#ConfirmPassword").val();
        //var ConfirmPassword = $("#InitialPassword").val();
        //Password = document.getElementById("InitialPassword");
        //var NewPassword;
        //NewPassword = Password.value.toString();
        //var ConfirmPassword;
        //ConfirmPassword = document.getElementById("ConfirmPassword");
        //ConfirmPassword = ConfirmPassword.toString();
        var UserName = 'aeplager@qkss.com';
        var Status;
        urlMain = '/WCFWebService.svc/SetNewestPassword/';
        //var ResetKey = "22310";
        var NewPassword = $("#InitialPassword").val();
        var ConfirmPassword = $("#ConfirmPassword").val();
        Data = '?ResetKey=' + ResetKey + '&NewPassword=' + NewPassword;
        urlMain = urlMain + Data;
        if (NewPassword == ConfirmPassword) {
            jQuery.ajax({
                type: 'GET',
                contentType: 'application/json;  charset=utf-8',
                url: urlMain,
                dataType: 'json',
                async: false,
                success: function (Result) {
                    try {
                        Status = Result;
                        if (Status == 'PASS')
                        { alert('Password has been updated'); }
                        else
                        { alert('You had some system error.  Please request a new password.');}
                    }
                    catch (e) { alert(e); }
                },
                error: function (e) {
                    //alert("Error");
                    alert(e.responseText);
                }
            });

        }
        else {
            alert("Please make sure that the passwords are the same");
        }
        if (Status == "PASS") {
            //alert("Password updated");

            window.location = getBaseURL() + "MappingPage.html"
        }
        else {
            alert("Password did not update.   Please try again");
        }
    }
    catch (e) {
        errorReport(e);
    }
}

function ObtainSelectedMap() {
    try {
        // Sends you to the correct map        
        MapSelection = $('#MapSelectorComboBox').val();
        if (MapSelection != null)
            {
        //MapSelection = 1;
        $("#LoginPage").hide();
        $("#SearchScreen").hide();
        $("#MapSelection").hide();
        
        document.getElementById('map').style.display = "block";
        initMap();
        $("#map").show();
        //initMap();
        // Change the Pick A Point List
        ResetPointSelector();        
        }
        else
        {
            alert('Please select a map');
        }
        // Reset the Zoom Level

    }
    catch (e) {
        errorReport(e);
    }

}
function ResetPointSelector()
{
    try{
        var urlMain = '/WCFWebService.svc/AllWayPointsGetInfo';
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
    }
    catch (e) {
        errorReport(e);
    }
}

function ResetUserPurchases()
{
    try{
        $('#MapSelectorComboBox').empty();
        //
        var urlMain = '/WCFWebService.svc/UserPurchasesGetInfo';
        Data = '?UserName=' + UserName;
        //    Data = '?MapDefinition=' = '"' + MapSelection + '"';
        urlMain = urlMain + Data;
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
                var iRow = -1;
                var SelectedItem = 'N/A';
                ///$('select[name="dept"]').val('3');
                for (var i in Result) {
                    var MapSelectionsID = Result[i].MapSelectionsID;
                    var MapSelectionsName = Result[i].MapSelectionsName;
                    if (iRow == -1) {
                        iRow = MapSelectionsID;
                        SelectedItem = MapSelectionsName
                    }                    
                    $('#MapSelectorComboBox').append(new Option(MapSelectionsName, MapSelectionsID));


                }                
                $("#MapSelectorComboBox").val(iRow);
            },
            error: function (Result) {
                alert("Error");
            }
        });
    }
    catch (e) {
        errorReport(e);
    }
}
function CancelButtonObtainMap()
{
    try {
        //alert('Cancel Button Map');
        if (MapSelection == -1)
        {
            // Go Login Screen            
            window.location.reload(true); 
        }
        {
            // Go to original map
            $("#LoginPage").hide();
            $("#SearchScreen").hide();
            $('#MapSelection').hide();
            $("#map").show();
            
        }
    }
    catch (e) {
        errorReport(e);
    }
}