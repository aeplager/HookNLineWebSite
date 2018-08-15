function CenterControl(controlDiv, map) {
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
    if ((MainMapTypeId == 'satellite') || (MainMapTypeId == 'hybrid'))
    { controlLI3.innerHTML = '<img id="WRTID" src="' + 'Images/WeatherRealTime5PercentWhite.png"' + ' alt="' + 'Locate Me"' + 'id="' + 'itemImg"' + ' style="' + 'float:center"' + '>'; }
    else
    { controlLI3.innerHTML = '<img id="WRTID" src="' + 'Images/WeatherRealTime5Percent.png"' + ' alt="' + 'Locate Me"' + 'id="' + 'itemImg"' + ' style="' + 'float:center"' + '>'; }
    
    controlLI3.id = "WRT";
    controlLI3.className = "LIClass";
    controlLI3.addEventListener('click', function () {
        CurrentLat = map.getCenter().lat();
        CurrentLng = map.getCenter().lng();
        DisplayRealTimeWeather();
    });
    //controlULWeather.appendChild(controlLI3);
    controlUI.appendChild(controlLI3);
    

    var controlLI4 = document.createElement('LI');
    controlLI4.innerHTML = "Weather Forecast";
    if ((MainMapTypeId == 'satellite') || (MainMapTypeId == 'hybrid'))
    { controlLI4.innerHTML = '<img id="WFID" src="' + 'Images/WeatherForecastThickerLines25PercentWhite.png"' + ' alt="' + 'Locate Me"' + 'id="' + 'itemImg"' + ' style="' + 'float:center"' + '>'; }
    else
    { controlLI4.innerHTML = '<img id="WFID" src="' + 'Images/WeatherForecastThickerLines25Percent.png"' + ' alt="' + 'Locate Me"' + 'id="' + 'itemImg"' + ' style="' + 'float:center"' + '>'; }
    controlLI4.id = "WF";
    controlLI4.className = "LIClass";
    controlLI4.addEventListener('click', function () {
        CurrentLat = map.getCenter().lat();
        CurrentLng = map.getCenter().lng();        
        DisplayWeatherForecast();
    });
    //controlULWeather.appendChild(controlLI4);
    controlUI.appendChild(controlLI4);
    
    var controlLI2 = document.createElement('LI');    
    controlLI2.innerHTML = "Pick A Spot";
    if ((MainMapTypeId == 'satellite') || (MainMapTypeId == 'hybrid'))
    { controlLI2.innerHTML = '<img id="PAPID" src="' + 'Images/PickaSpotThickerlines5PercentWhite.png"' + ' alt="' + 'Pick A Spot"' + 'id="' + 'itemImg"' + ' style="' + 'float:center"' + '>'; }
    else
    { controlLI2.innerHTML = '<img id="PAPID" src="' + 'Images/PickaSpotThickerlines5Percent.png"' + ' alt="' + 'Pick A Spot"' + 'id="' + 'itemImg"' + ' style="' + 'float:center"' + '>'; }
    controlLI2.className = "LIClass";
    controlLI2.id = "PickASpot1";
    controlLI2.addEventListener('click', function () {
        CurrentZoom = map.getZoom();        
        CurrentLat = map.getCenter().lat();
        CurrentLng = map.getCenter().lng();
        document.getElementById('map').style.display = "none";
        MainMapTypeId = map.getMapTypeId();
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
    if ((MainMapTypeId == 'satellite') || (MainMapTypeId == 'hybrid'))
    { controlLI70.innerHTML = '<img id="LMID" src="' + 'Images/LocateMe5PercentWhite.png"' + ' alt="' + 'Locate Me"' + 'id="' + 'itemImg"' + ' style="' + 'float:center"' + '>'; }
    else
    { controlLI70.innerHTML = '<img id="LMID" src="' + 'Images/LocateMe5Percent.png"' + ' alt="' + 'Locate Me"' + 'id="' + 'itemImg"' + ' style="' + 'float:center"' + '>'; }
    //controlLI70.innerHTML = '<img src="' + 'Images/LocateMe5PercentWhite.png"' + ' alt="' + 'Locate Me"' + 'id="' + 'itemImg"' + ' style="' + 'float:center"' + '>';
    controlLI70.className = "LIClass";
    controlLI70.addEventListener('click', function () {
        try{
            //GoToCurrentPosition();
            var StringforDisplay = "Starting";
            //alert(StringforDisplay);
            //var myLatLng = { lat: 29.481, lng: -94.917 };
            //GeoMkrLat = position.coords.latitude;
            //GeoMkrLng = position.coords.longitude;
            //alert('Latitude: ' + GeoMkrLat + ' and Longitude: ' + GeoMkrLng);
            //map.setCenter(GeoMkrLat, GeoMkrLng);
            map.setCenter(new google.maps.LatLng(GeoMkrLat, GeoMkrLng));
            //alert('Finished');
            //if (navigator.geolocation) {

            //    navigator.geolocation.getCurrentPosition(function (position) {
            //        var pos = {
            //            lat: position.coords.latitude,
            //            lng: position.coords.longitude
            //        };
            //        //CurrentMarker.setPosition(new google.maps.LatLng(position.coords.latitude, position.coords.longitude));
            //        //map.setCenter({ lat: 29.481, lng: -94.917 });
            //        map.setCenter({ lat: position.coords.latitude, lng: position.coords.longitude });
            //        //CurrentMarker.setMap(map);
            //        //alert("Finished Internal 6");
            //    }, function () {
            //        handleLocationError(true, infoWindow, map.getCenter());
            //    });
            //} else {
            //    // Browser doesn't support Geolocation
            //    handleLocationError(false, infoWindow, map.getCenter());
            //}
        }
        catch(e)
        {
            alert(e.message.toString());
        }
    });
    controlUL.appendChild(controlLI70);
    var controlLITest = document.createElement('LI');    
            
    if ((MainMapTypeId == 'satellite') || (MainMapTypeId ==  'hybrid'))
    {controlLITest.innerHTML = '<img id="SMID" src="' + 'Images/SwitchMaps5PercentWhite.png"' + ' alt="' + 'Switch Map"' + 'id="' + 'itemImg"' + ' style="' + 'float:center"' + '>';}
    else
    { controlLITest.innerHTML = '<img id="SMID" src="' + 'Images/SwitchMaps5Percent.png"' + ' alt="' + 'Switch Map"' + 'id="' + 'itemImg"' + ' style="' + 'float:center"' + '>'; }
    if (blDisplaySwitchMap == false)
    { controlLITest.innerHTML = ''; }
    controlLITest.id = "WF";
    controlLITest.className = "LIClass";
    
    //if (blDisplaySwitchMap != false)
    //    {
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

        //map.setMapTypeId(google.maps.MapTypeId.SATELLITE);

    });
    if (blDisplayMapSelector == false)
    {
        controlLITest.hidden = true;
    }
            
            controlUL.appendChild(controlLITest);
    //}
    // Adding the UL
    //controlUI.appendChild(controlUL);

    map.controls[google.maps.ControlPosition.TOP_RIGHT].push(controlUL);
    //map.controls[google.maps.ControlPosition.LEFT_TOP].push(controlULWeather);

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
        // Check if email exists
        urlMain = '/WCFWebService.svc/UserNameValidation/';
        var ValidUser = 0;
        var UserName = $("#UserNameEntry").val();
        if (UserName.trim() == '') {
            alert('Please enter a user name');
            return
        }        
        Data = '?UserName=' + UserName;
        //alert("Sending your user name and passwordafddafa");
        urlMain = urlMain + Data;
        jQuery.ajax({
            type: 'GET',
            contentType: 'application/json;  charset=utf-8',
            url: urlMain,
            dataType: 'json',
            async: false,
            success: function (Result) {
                try {                    
                    ValidUser = Result;
                }
                catch (e) { alert(e); }
            },
            error: function (e) { alert("Error"); alert(e.responseText); }
        });
        if (ValidUser == 0) 
        {
            alert("Please enter a valid user name");
            return;
        }
        //Send email

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
       
        //MapSelection = $("input:radio[name=RadioSelectorName]:checked").val(); //$('input[name=RadioSelectorName]:checked').val();
        //getRadioValue('RadioSelectorName');
        //$('input[name="RadioSelectorName"]:checked').val()
        MapSelection = $('input[name="RadioSelectorName"]:checked').val();
        if (MapSelection != null)
            {
        //MapSelection = 1;
        $("#LoginPage").hide();
        $("#SearchScreen").hide();
        $("#MapSelection").hide();
        
        document.getElementById('map').style.display = "block";
        MainMapTypeId = map.getMapTypeId();        
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

        $('input[type=radio].RadioSelector').remove();
        $('label[class=RadioLabelClass]').remove();
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
                
                for (var i in Result) {
                    var MapSelectionsID = Result[i].MapSelectionsID;
                    var MapSelectionsName = Result[i].MapSelectionsName;
                    if (iRow == -1) {
                        iRow = MapSelectionsID;
                        SelectedItem = MapSelectionsName
                    }
                    AddRadioButton(MapSelectionsID, MapSelectionsName);
                    //$('#MapSelectorComboBox').append(new Option(MapSelectionsName, MapSelectionsID));


                }                
                //$("#MapSelectorComboBox").val(iRow);
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

function errorReport(e)
{
    alert(e);
}
function ReplaceRadioSelection()
{
    try {

        alert($('input[name="RadioSelectorName"]:checked').val());
        //$('input[type=radio].RadioSelector').remove();
        //$('label[class=RadioLabelClass]').remove();

        //$('input[type=label].RadioLabel').remove();
        //AddRadioButton('F-102A', 'Mapping Program');
        //AddRadioButton('F-103A', 'Mapping Program 2');


        alert('Remove Completed V8');
    }
    catch (e) {
        errorReport(e);
    }
}
function AddRadioButton (RadioValue, InnerHtml)
{
    try {
        
        var RadioButton = document.createElement('input');
        RadioButton.setAttribute("type", "radio");
        RadioButton.setAttribute("value", RadioValue);
        RadioButton.setAttribute("name", "RadioSelectorName");
        RadioButton.setAttribute("class", "RadioSelector");
        
        var RadioMainDiv = document.getElementById("SelectionRadioDiv");
        RadioMainDiv.appendChild(RadioButton);

        var RadioLabel = document.createElement('label');        
        RadioLabel.innerHTML = InnerHtml + " </br>"
        RadioLabel.setAttribute("class", "RadioLabelClass");
        RadioMainDiv.appendChild(RadioLabel)
  
    }
    catch (e) {
        errorReport(e);
    }
}
function getRadioValue(groupName) {
    var radios = theFormName.elements[groupName];
    window.rdValue; // declares the global variable 'rdValue'
    for (var i = 0; i < radios.length; i++) {
        var someRadio = radios[i];
        if (someRadio.checked) {
            rdValue = someRadio.value;
            break;
        }
        else rdValue = 'noRadioChecked';
    }
    if (rdValue == '10') {
        alert('10'); // or: console.log('10')
    }
    else if (rdValue == 'noRadioChecked') {
        alert('no radio checked');
    }
}