﻿function AddTiling(map)
{
    try {
        AddOverLayMap(map, 'http://qkss.com/HooknLine/TILES/TrinityBay/', 29.376639, -95.097300, 29.801420, -94.353477);
        AddOverLayMap(map, 'http://qkss.com/HooknLine/TILES/WestBay/', 28.993955, -95.309236, 29.385521, -94.814655);
    }
    catch(e)
    {        
        ErrorFunction(e);
    }
}
function AddKML(map)
{
    try {        
        if (KMLAdded == false)
        {            
        var kmlUrl = 'http://qkss.com/HooknLine/KML/JoeTrombleyChangesCircles20160215.kml';
        LayerKML = new google.maps.KmlLayer({
            preserveViewport: true,
            url: kmlUrl,
            suppressInfoWindows: true,
            preserveViewport: true
        });
        LayerKML.setMap(map);
        google.maps.event.addListener(LayerKML, 'click', function (evt) {
            //google.maps.event.addListener(ctaLayer, 'dblclick', function (evt) {                
            DisplayKMLPoint(evt, 1);
        });
        KMLAdded = true;
        }
        else {            
            LayerKML.setMap(null);
            KMLAdded = false;
        }
        
    }
    catch(e)
    {
        ErrorFunction(e);
    }
}
function AddOverLayMap(map, URL,lat1, lng1, lat2, Lng2)
{
    try{
        var mapTilerTrinityBayURL = URL;//'http://qkss.com/HooknLine/TILES/TrinityBay/';
        var maptilerTrinityBay = new google.maps.ImageMapType({
            getTileUrl: function (coord, zoom) {
                var proj = map.getProjection();
                var z2 = Math.pow(2, zoom);
                var tileXSize = 256 / z2;
                var tileYSize = 256 / z2;
                var tileBounds = new google.maps.LatLngBounds(
                    proj.fromPointToLatLng(new google.maps.Point(coord.x * tileXSize, (coord.y + 1) * tileYSize)),
                    proj.fromPointToLatLng(new google.maps.Point((coord.x + 1) * tileXSize, coord.y * tileYSize))
                );
                var y = coord.y;
                var x = coord.x >= 0 ? coord.x : z2 + coord.x
                var mapMinZoom = 7;
                var mapMaxZoom = 18;
                var mapBoundsTrinityBay = new google.maps.LatLngBounds(
                   new google.maps.LatLng(lat1, lng1),
                   new google.maps.LatLng(lat2, Lng2));
                if (mapBoundsTrinityBay.intersects(tileBounds) && (mapMinZoom <= zoom) && (zoom <= mapMaxZoom))
                    return mapTilerTrinityBayURL + zoom + "/" + x + "/" + y + ".png";
                else
                    return "http://www.maptiler.org/img/none.png";
            },
            tileSize: new google.maps.Size(256, 256),
            isPng: true,
            opacity: 1.0
        });
        map.overlayMapTypes.insertAt(0, maptilerTrinityBay);

}
    catch(e)
{        
    ErrorFunction(e);
}

}
function DisplayKMLPoint(evt)
{
    try {
        
        var myLatlng = new google.maps.LatLng(map, evt.latLng.Latitude);
        var Data; 
        var urlMain;
        var sLatitude = evt.latLng.toString();
        var sLongitude = sLatitude;
        sLatitude = sLatitude.substring(0, sLatitude.indexOf(" ", 0));
        sLatitude = sLatitude.substring(1, sLatitude.length - 1);
        sLongitude = sLongitude.substring(sLongitude.indexOf(" ", 0), sLongitude.length - sLatitude.indexOf(" ", 0));
        sLongitude = sLongitude.substring(1, sLongitude.length - 1);
        //alert(myLatlng.latitude);
        
        urlMain = '/WCFWebService.svc/SpecificWayPointGetInfo/';
        Data = '?Latitude=' + sLatitude + '&Longitude=' + sLongitude;
        //Data = '?Latitude="28"/Longitude="95"';        
        urlMain = urlMain + Data;
        jQuery.ajax({
            type: 'GET',
            contentType: 'application/json;  charset=utf-8',
            url: urlMain,
            dataType: 'json',
            async: false,
            success: function (Result) {
                try{
                    var test;
                    var WayPointName;
                    var TypeOfFishingP = "";
                    var LatP;
                    var LngP;
                    var NameP;
                    var FishP;
                    var BestWindP;
                    var TypeOfFishingP;
                    var WayPointTypeID;
                    var WayPointTypeName;
                    WayPointName = Result[0].WayPointName;
                    for (var i in Result) {
                        //var serie = { WayPointID: Result[i].WayPointID, WayPointName: Result[i].WayPointName, Lat: Result[i].Latitude, Lng: Result[i].Longitude };
                        TypeOfFishingP = Result[i].TypeOfFishingText;
                        LatP = Result[i].Latitude;
                        LngP = Result[i].Longitude;
                        NameP = Result[i].WayPointName;
                        FishP = Result[i].FishingText;                        
                        BestWindP = Result[i].BestWindText;                        TypeOfFishingP = Result[i].TypeOfFishingText;
                        WayPointTypeID = Result[i].WayPointTypeID;
                        WayPointTypeName = Result[i].WayPointTypeName;                        
                        break;
                    }
                    
                    if ((LatP != 0) && (LngP != 0)) {
                        var StringforDisplay = '';
                        var CurrentDate = new Date();
                        var StringforDisplay = "";                        
                        StringforDisplay = '<style> #WeatherTable {font-size: "2";} p {font-size: "2"; word-wrap: break-word}</style>';
                        StringforDisplay = '';
                        if (WayPointTypeID == 1)  // Normal Way Point
                        {
                            StringforDisplay = StringforDisplay + '<font size="2">WayPoint:  ' + NameP + '</font>';
                            StringforDisplay = StringforDisplay + '<hr style="height:2px; visibility:hidden;" />';
                            if (FishP != '') { StringforDisplay = StringforDisplay + 'Fish:  ' + FishP + '<hr style="height:2px; visibility:hidden;" />'; }

                            if (BestWindP != '') { StringforDisplay = StringforDisplay + 'Best Wind Direction:  ' + BestWindP + '<hr style="height:2px; visibility:hidden;" />'; }
                            if (TypeOfFishingP != '') { StringforDisplay = StringforDisplay + 'Type of Fishing:  ' + TypeOfFishingP + '<hr style="height:2px; visibility:hidden;" />'; }
                        }
                        else if (WayPointTypeID == 2) {  // WayPoint without underlying data                
                            StringforDisplay = StringforDisplay + '<font size="2">WayPoint:  ' + NameP + '</font>';
                            StringforDisplay = StringforDisplay + '<hr style="height:2px; visibility:hidden;" />';
                        }
                        else if (WayPointTypeID == 3) {  // Marina
                            StringforDisplay = StringforDisplay + '<font size="2">WayPoint:  ' + NameP + '</font>';
                            StringforDisplay = StringforDisplay + '<hr style="height:2px; visibility:hidden;" />';
                            if (FishP != '') { StringforDisplay = StringforDisplay + 'Detail:  ' + FishP + '<hr style="height:2px; visibility:hidden;" />'; }
                            if (BestWindP != '') { StringforDisplay = StringforDisplay + 'Best Wind Direction:  ' + BestWindP + '<hr style="height:2px; visibility:hidden;" />'; }
                            
                        }
                        StringforDisplay = StringforDisplay + '<input type="submit" onClick="CloseInfoWindowAndMoveMarker();" value="Close">'

                        infowindow.close();
                        infowindow = new google.maps.InfoWindow({
                            content: StringforDisplay
                        });
                        myLatLng = { lat: LatP, lng: LngP };
                        marker.setPosition(myLatLng);
                        infowindow.open(map, marker);
                    }
                }
                catch (e) { alert(e);}
            },
            error: function (e) { alert("Error"); alert(e.responseText); }
        });

    }
    catch (e) {
        ErrorFunction(e);
    }
}
function PickAPoint() {
    try {
        var Latitude = document.getElementById('LatitudeLabel').innerHTML;
        var Longitude = document.getElementById('LongitudeLabel').innerHTML;
        if ((Longitude == '') || (Latitude == '')) {
            alert('Please select a point');
            return
        }

        document.getElementById('map').style.display = "block";
        initMap();
        //document.getElementById("map").style.width = "100%"
        //var evt = new google.maps.LatLng(Latitude, Longitude);
        //var myLatlng = new google.maps.LatLng(map, evt.latLng.Latitude);
        var Data;
        var urlMain;
        var sLatitude = Latitude;//evt.latLng.toString();
        var sLongitude = Longitude;        
        //alert(myLatlng.latitude);        
        urlMain = '/WCFWebService.svc/SpecificWayPointGetInfo/';
        Data = '?Latitude=' + sLatitude + '&Longitude=' + sLongitude;
        //Data = '?Latitude="28"/Longitude="95"';        
        urlMain = urlMain + Data;
        jQuery.ajax({
            type: 'GET',
            contentType: 'application/json;  charset=utf-8',
            url: urlMain,
            dataType: 'json',
            async: false,
            success: function (Result) {
                try {
                    var test;
                    var WayPointName;
                    var TypeOfFishingP = "";
                    var LatP;
                    var LngP;
                    var NameP;
                    var FishP;
                    var BestWindP;
                    var TypeOfFishingP;
                    var WayPointTypeID;
                    var WayPointTypeName;
                    WayPointName = Result[0].WayPointName;
                    for (var i in Result) {
                        //var serie = { WayPointID: Result[i].WayPointID, WayPointName: Result[i].WayPointName, Lat: Result[i].Latitude, Lng: Result[i].Longitude };
                        TypeOfFishingP = Result[i].TypeOfFishingText;
                        LatP = Result[i].Latitude;
                        LngP = Result[i].Longitude;
                        NameP = Result[i].WayPointName;
                        FishP = Result[i].FishingText;
                        BestWindP = Result[i].BestWindText;
                        TypeOfFishingP = Result[i].TypeOfFishingText;
                        WayPointTypeID = Result[i].WayPointTypeID;
                        WayPointTypeName = Result[i].WayPointTypeName;
                        break;
                    }

                    if ((LatP != 0) && (LngP != 0)) {
                        var StringforDisplay = '';
                        var CurrentDate = new Date();
                        var StringforDisplay = "";
                        StringforDisplay = '<style> #WeatherTable {font-size: large;} p {font-size: large; word-wrap: break-word}</style>';
                        StringforDisplay = '';
                        if (WayPointTypeID == 1)  // Normal Way Point
                        {
                            StringforDisplay = StringforDisplay + 'WayPoint:  ' + NameP;
                            StringforDisplay = StringforDisplay + '<hr style="height:2px; visibility:hidden;" />';
                            if (FishP != '') { StringforDisplay = StringforDisplay + 'Fish:  ' + FishP + '<hr style="height:2px; visibility:hidden;" />'; }

                            if (BestWindP != '') { StringforDisplay = StringforDisplay + 'Best Wind Direction:  ' + BestWindP + '<hr style="height:2px; visibility:hidden;" />'; }
                            if (TypeOfFishingP != '') { StringforDisplay = StringforDisplay + 'Type of Fishing:  ' + TypeOfFishingP + '<hr style="height:2px; visibility:hidden;" />'; }
                        }
                        else if (WayPointTypeID == 2) {  // WayPoint without underlying data                
                            StringforDisplay = StringforDisplay + 'WayPoint:  ' + NameP;
                            StringforDisplay = StringforDisplay + '<hr style="height:2px; visibility:hidden;" />';
                        }
                        else if (WayPointTypeID == 3) {  // Marina
                            StringforDisplay = StringforDisplay + 'WayPoint:  ' + NameP;
                            StringforDisplay = StringforDisplay + '<hr style="height:2px; visibility:hidden;" />';
                            if (FishP != '') { StringforDisplay = StringforDisplay + 'Detail:  ' + FishP + '<hr style="height:2px; visibility:hidden;" />'; }
                            if (BestWindP != '') { StringforDisplay = StringforDisplay + 'Best Wind Direction:  ' + BestWindP + '<hr style="height:2px; visibility:hidden;" />'; }

                        }
                        StringforDisplay = StringforDisplay + '<input type="submit" onClick="CloseInfoWindowAndMoveMarker();" value="Close">'

                        infowindow.close();
                        infowindow = new google.maps.InfoWindow({
                            content: StringforDisplay
                        });
                        myLatLng = { lat: LatP, lng: LngP };
                        marker.setPosition(myLatLng);
                        infowindow.open(map, marker);
                    }
                }
                catch (e) { alert(e); }
            },
            error: function (e) { alert("Error"); alert(e.responseText); }
        });
        
    }
    catch (e) {
        ErrorFunction(e);
    }

}