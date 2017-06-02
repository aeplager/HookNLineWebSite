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
                //StringforDisplay = '<style> #WeatherTable {font-size: large;} p {font-size: large;}</style>'
                StringforDisplay = '<div class="infoWindowDiv">';
                StringforDisplay = StringforDisplay + 'Real Time Conditions at Eagle Point <br /> as of (' + CurrentTime + ' ) <br />'
                //            StringforDisplay = StringforDisplay + '<P>Scroll Down to See All of the Weather</P>'
                StringforDisplay = StringforDisplay + '</br><input type="submit" onClick="CloseInfoWindowAndMoveMarker();" value="Close"></br>'
                //StringforDisplay = StringforDisplay + '<table id="WeatherTable" border="1" style="overflow: auto;" >'
                // Obtain Forecast Time
                //StringforDisplay = StringforDisplay + '<br>Wind Direction (WDIR):       ' + ' (' + WindDir + ' deg true)';
                //StringforDisplay = StringforDisplay + '<br>';
                //StringforDisplay = StringforDisplay + 'Wind Speed (WSPD):           ' + WindSpeed + ' mph';
                //StringforDisplay = StringforDisplay + '<br>'
                //StringforDisplay = StringforDisplay + 'Atmospheric Pressure (PRES): ' + Pressure + ' mbs';
                //StringforDisplay = StringforDisplay + '<br>';
                //StringforDisplay = StringforDisplay + 'Air Temp (ATMP):             ' + CurrentTemp + ' F';
                //StringforDisplay = StringforDisplay + '<br>';
                //var CurrentWaterTemp = WaterTemp;
                //StringforDisplay = StringforDisplay + 'Water Temperature (WTMP):    ' + WaterTemp + ' F';
                //StringforDisplay = StringforDisplay + '<br>';
                //StringforDisplay = StringforDisplay + '</div>';
                StringforDisplay = StringforDisplay + '<table class="InfoTableBorder" id="WeatherTable" >'; //border="1" style="overflow: auto;" >'
                StringforDisplay = StringforDisplay + '<tr>'
                StringforDisplay = StringforDisplay + '<td class="InfoTableCellBorder">'
                StringforDisplay = StringforDisplay + 'Wind Direction (WDIR)'
                StringforDisplay = StringforDisplay + '</td><td class="InfoTableCellBorder">'
                StringforDisplay = StringforDisplay + WindDesc + ' (' + WindDir + ' deg true)'
                StringforDisplay = StringforDisplay + '</td></tr><tr><td class="InfoTableCellBorder">'
                StringforDisplay = StringforDisplay + 'Wind Speed (WSPD)'
                StringforDisplay = StringforDisplay + '</td><td class="InfoTableCellBorder">' + WindSpeed + ' mph</td></tr><tr><td  class="InfoTableCellBorder">'
                StringforDisplay = StringforDisplay + 'Atmospheric Pressure (PRES)'
                StringforDisplay = StringforDisplay + '</td><td class="InfoTableCellBorder">' + Pressure + ' mbs</td></tr><tr><td  class="InfoTableCellBorder">'
                StringforDisplay = StringforDisplay + 'Air Temp (ATMP)</td><td class="InfoTableCellBorder">'
                StringforDisplay = StringforDisplay + CurrentTemp + ' F</td></tr><tr><td  class="InfoTableCellBorder">'
                StringforDisplay = StringforDisplay + 'Water Temperature (WTMP)</td><td class="InfoTableCellBorder">'
                var CurrentWaterTemp = WaterTemp;
                CurrentWaterTemp = CurrentWaterTemp - 5.0;
                StringforDisplay = StringforDisplay + WaterTemp + ' F</td></tr><tr><td  class="InfoTableCellBorder">'
                StringforDisplay = StringforDisplay + '</tr></table>'
                StringforDisplay = StringforDisplay + "</table>"
                StringforDisplay = StringforDisplay + "</div>"
                infowindow.close();
                
                
                infowindow = new google.maps.InfoWindow({
                    content: StringforDisplay,
                    maxWidth: 750
                });
                //var Test = map.getCenter().lat();
                //CurrentLat = map.getCenter().lat();
                //CurrentLng = map.getCenter().lng();
                myLatLng = { lat: CurrentLat, lng: CurrentLng };
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
    try {
        
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
                    StringforDisplay = '<div class="infoWindowDiv">'
                    StringforDisplay = StringforDisplay + 'Forecast Conditions at Eagle Point as of <br /> (' + Result[i].DateOfForecast.toString() + ' ) <br />'
                    StringforDisplay = StringforDisplay + '</br><input type="submit" onClick="CloseInfoWindowAndMoveMarker();" value="Close">'
                    StringforDisplay = StringforDisplay + '</br><table class="InfoTable" id="WeatherTable" border="1" style="overflow: auto;" >'

                }
                for (var i in Result) {
                    var ForeCastedTime = Result[i].ForecastDate;
                    //Obtain Temperature
                    var ForecastedTemp = Result[i].ForecastTemp;
                    // Obtain Forecast Description
                    var ForecastedDesc = Result[i].ForecastStatus;
                    // Table Header
                    StringforDisplay = StringforDisplay + '<tr><td class="InfoTableCell">';
                    WeatherDesc = ForecastedDesc.toString();
                    if (WeatherDesc.length > 5)
                    {
                        WeatherDesc = ' with' + ForecastedDesc.toString();
                    }
                        //' forecast: ' + ForecastedDesc.toString() +
                    StringforDisplay = StringforDisplay + ForecastedTemp + 'F' + ' at ' + Result[i].ForecastDate.toString() + WeatherDesc;
                    StringforDisplay = StringforDisplay + "</td></tf>"
                }
                StringforDisplay = StringforDisplay + "</table></div>"
                
                infowindow.close();
                infowindow = new google.maps.InfoWindow({
                    content: StringforDisplay,
                    maxWidth: 750
                });
                //CurrentLat = map.getCenter().lat();
                //CurrentLng = map.getCenter().lng();
                myLatLng = { lat: CurrentLat, lng: CurrentLng };
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