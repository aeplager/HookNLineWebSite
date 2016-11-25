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
    //controlUL.appendChild(controlLI1);

    var controlLI2 = document.createElement('LI');
    controlLI2.innerHTML = "Pick A Spot";
    controlLI2.className = "LIClass";
    controlLI2.addEventListener('click', function () {
        CurrentZoom = map.getZoom();
        
        CurrentLat  = map.getCenter().lat();
        CurrentLng = map.getCenter().lng();        
        document.getElementById('map').style.display = "none";
        $("#SearchableMenu").show();
        //$("#map").hide();
        //document.getElementById("map").style.width = "0%"
        $('#autocomplete').val('');        
        //document.getElementsById("autocomplete").value = "";
        
    });
    controlUL.appendChild(controlLI2);

    var controlLI3 = document.createElement('LI');
    controlLI3.innerHTML = "Weather Real Time";
    controlLI3.className = "LIClass";
    controlLI3.addEventListener('click', function () {        
        DisplayRealTimeWeather();
    });
    controlUL.appendChild(controlLI3);

    

    var controlLI4 = document.createElement('LI');
    controlLI4.innerHTML = "Weather Forecast";    
    controlLI4.className = "LIClass";
    controlLI4.addEventListener('click', function () {
        DisplayWeatherForecast();
    });
    controlUL.appendChild(controlLI4);
       

    controlUI.appendChild(controlUL);    
    

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
        urlMain = '/WCFWebService.svc/LoginValidation/';
        var UserName = $("#UserNameEntry").val();
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
                    $("#map").show();
                    document.getElementById('map').style.display = "block";
                    initMap();
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
    }
    catch (e) {
        ErrorFunction(e.message);
    }
}
function CancelButton() {
    try {
        $("#map").show();
        document.getElementById('map').style.display = "block";
        initMap();
      
        //var myLatLng = { lat: CurrentLat, lng: CurrentLng };
        //var NewPos = new google.maps.LatLng(CurrentLat, CurrentLng);
       // map.setCenter(new google.maps.LatLng(37.4419, -122.1419));
        //MoveToPosition(CurrentLat, CurrentLng);
        //map.setPosition(NewPos);
    }
    catch (e) {
        ErrorFunction(e.message);
    }
}
function ResetPassword()
{
    try{
        urlMain = '/WCFWebService.svc/SendEmailForNewPassword/';
        var UserName = $("#UserNameEntry").val();        
        Data = '?UserName=' + UserName;
        alert("Sending your user name and password");
        urlMain = urlMain + Data;
        jQuery.ajax({
            type: 'GET',
            contentType: 'application/json;  charset=utf-8',
            url: urlMain,
            dataType: 'json',
            async: false,
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
            alert("Password updated");

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