function DisplayRealTimeWeather() {
    try {
        DisplayRealTimeStatus = 1;
        //alert("To be completed");
        // for OSM layer
        // Adding List of Weather Forecast Information 
        $.ajax({
            type: "GET",
            contentType: "application/json; charset=utf-8",
            // Change Here To Change The Web Service Needed
            //url: "/AzureHooknLineAjax.svc/HelloWorld",
            url: "/WCFWebService.svc/RealTimeWeatherGetInfo",
            // Change Here To Change The Parameters Needed
            data: "{}",
            dataType: "json",
            async: false,
            success: function (Result) {
                var WindDir;
                var WindDesc;
                var WindSpeed;
                var Pressure;
                var WaterTemp;
                var CurrentTemp;
                var CurrentTime;
                WindDesc = Result.WindDescription;
                WindDir = Result.WindDir;
                WindSpeed = Result.WindSpeed;
                Pressure = Result.PressValue;
                CurrentTemp = Result.TempValueFormatted;
                WaterTemp = Result.WaterTempValueFormatted;
                CurrentTime = Result.RecordedTimeFormatted;
                var CurrentDate = new Date();
                var StringforDisplay = "";
                //Establish Internal Look and Feel
                StringforDisplay = '<style> #WeatherTable {font-size: large;} p {font-size: large;}</style>'
                StringforDisplay = StringforDisplay + '<P><b>Real Time Conditions at Eagle Point as of <br /> (' + CurrentTime + ' ) <br />'
                //            StringforDisplay = StringforDisplay + '<P>Scroll Down to See All of the Weather</P>'
                StringforDisplay = StringforDisplay + '<br><input type="submit" onClick="CloseInfoWindowAndMoveMarker();" value="Close">'
                StringforDisplay = StringforDisplay + '<table id="WeatherTable" border="1" style="overflow: auto;" >'
                // Obtain Forecast Time
                StringforDisplay = StringforDisplay + '<table id="WeatherTable" border="1" style="overflow: auto;" >'
                StringforDisplay = StringforDisplay + '<tr>'
                StringforDisplay = StringforDisplay + '<td>'
                StringforDisplay = StringforDisplay + 'Wind Direction (WDIR)'
                StringforDisplay = StringforDisplay + '</td><td>'
                StringforDisplay = StringforDisplay + WindDesc + ' (' + WindDir + ' deg true)'
                StringforDisplay = StringforDisplay + '</td></tr><tr><td>'
                StringforDisplay = StringforDisplay + 'Wind Speed (WSPD)'
                StringforDisplay = StringforDisplay + '</td><td>' + WindSpeed + ' mph</td></tr><tr><td>'
                StringforDisplay = StringforDisplay + 'Atmospheric Pressure (PRES)'
                StringforDisplay = StringforDisplay + '</td><td>' + Pressure + ' mbs</td></tr><tr><td>'
                StringforDisplay = StringforDisplay + 'Air Temp (ATMP)</td><td>'
                StringforDisplay = StringforDisplay + CurrentTemp + ' F</td></tr><tr><td>'
                StringforDisplay = StringforDisplay + 'Water Temperature (WTMP)</td><td>'
                var CurrentWaterTemp = WaterTemp;
                CurrentWaterTemp = CurrentWaterTemp - 5.0;
                StringforDisplay = StringforDisplay + WaterTemp + ' F</td></tr><tr><td>'
                StringforDisplay = StringforDisplay + '</tr></table>'
                StringforDisplay = StringforDisplay + "</table>"                
                infowindow.close();
                
                
                infowindow = new google.maps.InfoWindow({
                    content: StringforDisplay
                });
                
                myLatLng = { lat: 29.481, lng: -94.917 };
                marker.setPosition(myLatLng);
                infowindow.open(map, marker);                
            },
            error: function (Result) {
                alert("Error");
            }
        });        
    }
    catch (e) { ErrorFunction(e.message); }
}
function DisplayWeatherForecast()
{
    try{
        $.ajax({
            type: "GET",
            contentType: "application/json; charset=utf-8",
            // Change Here To Change The Web Service Needed
            //url: "/AzureHooknLineAjax.svc/HelloWorld",
            url: "/WCFWebService.svc/WeatherForecastGetInfo",
            // Change Here To Change The Parameters Needed
            data: "{}",
            dataType: "json",
            async: false,
            success: function (Result) {
                var StringforDisplay = "";
                var WeatherDesc = '';
                for (var i in Result) {                    
                    StringforDisplay = '<style> #WeatherTable {font-size: large;} p {font-size: large;}</style>'
                    StringforDisplay = StringforDisplay + '<P><b>Forecast Conditions at Eagle Point as of <br /> (' + Result[i].DateOfForecast.toString() + ' ) <br />'
                    StringforDisplay = StringforDisplay + '<br><input type="submit" onClick="CloseInfoWindowAndMoveMarker();" value="Close">'
                    StringforDisplay = StringforDisplay + '<table id="WeatherTable" border="1" style="overflow: auto;" >'

                }
                for (var i in Result) {
                    var ForeCastedTime = Result[i].ForecastDate;
                    //Obtain Temperature
                    var ForecastedTemp = Result[i].ForecastTemp;
                    // Obtain Forecast Description
                    var ForecastedDesc = Result[i].ForecastStatus
                    // Table Header
                    StringforDisplay = StringforDisplay + "<tr><td>"
                    WeatherDesc = ForecastedDesc.toString();
                    if (WeatherDesc.length > 5)
                    {
                        WeatherDesc = ' with' + ForecastedDesc.toString();
                    }
                        //' forecast: ' + ForecastedDesc.toString() +
                    StringforDisplay = StringforDisplay + ForecastedTemp + 'F' + ' at ' + Result[i].ForecastDate.toString() + WeatherDesc;
                    StringforDisplay = StringforDisplay + "</td></tf>"
                }
                StringforDisplay = StringforDisplay + "</table>"

                infowindow.close();
                infowindow = new google.maps.InfoWindow({
                    content: StringforDisplay
                });
                myLatLng = { lat: 29.481, lng: -94.917 };
                marker.setPosition(myLatLng);
                infowindow.open(map, marker);
            },
            error: function (Result) {
                alert("Error");
            }
        });
    }
    catch(e)
    {
        ErrorFunction(e.message); 
    }
}