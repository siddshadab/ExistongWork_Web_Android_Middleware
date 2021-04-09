import 'package:http/http.dart' as http;
import 'dart:io' as Io;
import 'dart:convert';
import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';
import 'package:eco_mfi/Maps/GetPathTrackeronUserId.dart';
import 'package:eco_mfi/Maps/MapsUtils.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
//import 'package:eco_mfi/Utilities/CustomSwitch.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'GetCurrentLocationOnSuperUsers.dart';
import 'CurrentLoactionBean.dart';
//import 'custom_popup.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'dart:io';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterDetailsBean.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;

class PathTrackerMap extends StatefulWidget {
  var muserCode;
  PathTrackerMap(this.muserCode);

  @override
  State<StatefulWidget> createState() => _PathTrackerMap();
}

class _PathTrackerMap extends State<PathTrackerMap> {
  LatLng _center = null;
  CurrentLoactionBean userUsingLocation = new CurrentLoactionBean();

  var formatter = new DateFormat('dd/MMM/yyyy HH:mm');
  var formatterWithHours = new DateFormat('dd/MM/yyyy HH:mm');

  List<Marker> markers = List<Marker>();
  final Set<Polyline> _polyline = {};
  Completer<GoogleMapController> _controller = Completer();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();

  Timer _ticker;

  final Color inactiveColor = Colors.grey;
  final String activeText = 'Center';
  final String inactiveText = 'Users';
  final Color activeTextColor = Colors.white70;
  final Color inactiveTextColor = Colors.white70;
  BitmapDescriptor myArrowIcon;

  @override
  void dispose() {
    _ticker.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(48, 48)), 'assets/arrowIcon.png')
        .then((onValue) {
      myArrowIcon = onValue;
    });
    if (this.mounted == true) {
      if (globals.geoLatitude != null &&
          globals.geoLongitude != null &&
          globals.geoLatitude != 0 &&
          globals.geoLongitude != 0) {
        _center = LatLng(globals.geoLatitude, globals.geoLongitude);
        print("Geolatitude " + globals.geoLatitude.toString());
        print("GeoLongitude " + globals.geoLongitude.toString());

        userUsingLocation.mgeolatd = globals.geoLatitude.toString();
        userUsingLocation.mgeologd = globals.geoLongitude.toString();
      }
      setCenterMapPointLocation();
    }
  }

  void setStateCustom() {
    setState(() {});
  }

  setCenterMapPointLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      setState(() {
        if (_center == null) {
          double geoLat = prefs.get(TablesColumnFile.geoLatitude);
          double geoLong = prefs.get(TablesColumnFile.geoLongitude);
          _center = LatLng(geoLat, geoLong);
          userUsingLocation.mgeolatd = geoLat.toString();
          userUsingLocation.mgeologd = geoLong.toString();
        }
        userUsingLocation.musrcode = prefs.get(TablesColumnFile.musrcode);

        userUsingLocation.musrname = prefs.get(TablesColumnFile.musrname);
        userUsingLocation.mreportinguser =
            prefs.get(TablesColumnFile.mreportinguser);
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () {
        return Future(() => true);
      },
      child: Scaffold(
        key: _scaffoldHomeState,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {});
          },
          child: Icon(Icons.refresh),
          backgroundColor: Colors.blueGrey.withOpacity(0.5),
        ),
        body: _buildMap(),
        // appBar: _buildAppBar(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        "Map".toUpperCase(),
        style: TextStyle(fontSize: 19.0, color: Colors.black87),
      ),
      automaticallyImplyLeading: false,
      centerTitle: true,
    );
  }

  Widget _buildMap() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double mapHeight = height; // - 200.0;
    double bottomheight = (height - mapHeight) - 130;
    double bottomWidth = width - 50;
    return Column(
      children: [
        new Container(
            height: mapHeight,
            child: GoogleMap(
                polylines: _polyline,
                markers: markers.toSet(),
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 14.0,
                ),
                trafficEnabled: true,
                onMapCreated: onMapCreated,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: true,
                scrollGesturesEnabled: true,
                compassEnabled: true,
                rotateGesturesEnabled: true,
                mapToolbarEnabled: true,
                tiltGesturesEnabled: true,
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                  new Factory<OneSequenceGestureRecognizer>(
                    () => new EagerGestureRecognizer(),
                  ),
                ].toSet())),
        //SizedBox(height:30.0),
        /* Container(
            height: bottomheight,
            width: bottomWidth,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 30.0, // soften the shadow
                  spreadRadius: 70.0, //extend the shadow
                  offset: Offset(
                    15.0, // Move to right 10  horizontally
                    5.0, // Move to bottom 5 Vertically
                  ),
                )
              ],
            ),
            child:
            Row(
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               new IconButton(
                  icon: new Icon(Icons.refresh, color: Colors.grey),
                  onPressed: () {
                    setState(() {

                    });
                  },
                ),

              ],
            )
        ),*/
      ],
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    controller.setMapStyle(MapsUtils.mapTheme);
    getPathTrackerLocationBasedonUserCode().then((onValue) {
      setState(() {});
    });
    ;
    _controller.complete(controller);
    setState(() {});
  }

  var infoWindowVisible = false;
  GlobalKey<State> key = new GlobalKey();

  Opacity marker(CurrentLoactionBean val) {
    return Opacity(
      child: val.profileimage != null
          ? Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                image: DecorationImage(
                  image: MemoryImage(File(val.profileimage).readAsBytesSync()),
                  fit: BoxFit.fill,
                ),
              ),
            )
          : Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/images/destination_map_marker.png',
                width: 49,
                height: 65,
              )),
      opacity: infoWindowVisible ? 0.0 : 1.0,
    );
  }

  Future<Null> getPathTrackerLocationBasedonUserCode() async {
    gePathTrackerAndDrawPath(widget.muserCode);
  }

  Future<Null> gePathTrackerAndDrawPath(String muser) async {
    markers.clear();
    _polyline.clear();
    showMessage("Getting Path Info ..");
    GetPathTrackeronUserId getPathTrackeronUserId =
        new GetPathTrackeronUserId();
    await getPathTrackeronUserId
        .trySave(muser != null ? muser : "1234")
        .then((List<CurrentLoactionBean> result) async {
      //print("Length ${result.length}");
      int i = 0;
      List<LatLng> latLongList = new List<LatLng>();
      if (result != null) {
        result.forEach((val) async {
          ++i;
          double lat = 0.0;
          double long = 0.0;
          try {
            lat = double.parse(val.mgeolatd);
            long = double.parse(val.mgeologd);
          } catch (_) {}

          latLongList.add(LatLng(lat, long));

          try {
            Marker marker = Marker(
                markerId: MarkerId(val.mgeologd),
                position: LatLng(lat, long),
                infoWindow: InfoWindow(
                  title: "Created Time  " +
                      "(" +
                      formatterWithHours.format(val.mcreateddt) +
                      ")",
                  snippet: "Visited Date Time  " +
                      "(" +
                      formatterWithHours.format(val.mcreateddt) +
                      ")",
                ),
                icon: await MapsUtils.getMarkerIconWithNumber(
                    val, Size(150.0, 150.0), i, context),
                onTap: () {
                  MapsUtils.settingModalBottomSheet(
                      val, context, false, false, true);
                  setState(() {}); //this is what you're looking for!
                });
            setState(() {
              markers.add(marker);
            });
          } catch (_) {}
        });
      } else {
        showMessageWithoutProgress("No Records Found for Path ");
      }

      try {
        Polyline polyline = Polyline(
            polylineId: PolylineId("Drawing Path Here By Shadab"),
            //pass any string here
            width: 3,
            geodesic: true,
            /* points: MapsUtils.convertToLatLng(
                  MapsUtils.decodePoly(encodedPoly)),*/
            points: latLongList,
            color: Colors.red);

        setState(() {
          _polyline.add(polyline);
        });
      } catch (_) {}
    });

    getCenterApi(muser);
  }

  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=${'AIzaSyCzncFU74qGGbrUgwdr9lZYfchLByBoAmE'}";
    print(url);
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);
    //ProjectLog.logIt(TAG, "Predictions", values.toString());
    return values["routes"][0]["overview_polyline"]["points"];
  }

  Future<Null> getCenterApi(String musrcode) async {
    geCenterLiveLocation(musrcode);
  }

  Future<Null> geCenterLiveLocation(String musrcode) async {
    showMessage("Getting Center Locations for ${musrcode} ..");
    GetCurrentLocationOnSuperUsers getCurrentLocationOnSuperUsers =
        new GetCurrentLocationOnSuperUsers();
    await getCurrentLocationOnSuperUsers
        .trySave(musrcode != null ? musrcode : "1234", true)
        .then((List<CurrentLoactionBean> result) async {
      print("Returned Centers Value ${result}");
      if (result != null) {
        showMessageWithoutProgress("${result.length} Centers Found!");
        result.forEach((val) async {
          double lat = 0.0;
          double long = 0.0;
          try {
            lat = double.parse(val.mgeolatd);
            long = double.parse(val.mgeologd);
          } catch (_) {}
          manupulateValImageOnCenterMeetingDate(val);
          String meetingDay = manupulateDayFromInt(val.mcreatedby);
          try {
            Marker marker = Marker(
                markerId: MarkerId(val.mgeologd),
                position: LatLng(lat, long),
                infoWindow: InfoWindow(
                  title: "Id " +
                      "(" +
                      val.musrcode.toString() +
                      ")" +
                      " Name" +
                      "(" +
                      val.musrname.toString() +
                      ")",
                  snippet: "Day " +
                      "(" +
                      meetingDay.toString() +
                      ")" +
                      "Next Meeting Date " +
                      "(" +
                      formatter.format(val.mlastupdatedt) +
                      ")",
                ),
                icon: await MapsUtils.getMarkerIcon(val, Size(150.0, 150.0)),
                onTap: () {
                  MapsUtils.settingModalBottomSheet(
                      val, context, false, false, true);
                  setState(() {}); //this is what you're looking for!
                });

            markers.add(marker);
            setState(() {});
          } catch (_) {}
        });
      } else {
        showMessageWithoutProgress("No Records Found for center");
      }
    });
  }

  void manupulateValImageOnCenterMeetingDate(CurrentLoactionBean val) {
    if (formatter.format(DateTime.now()) ==
        formatter.format(val.mlastupdatedt)) {
      val.profileimage =
          "iVBORw0KGgoAAAANSUhEUgAAAQAAAAEACAYAAABccqhmAAAACXBIWXMAAAsTAAALEwEAmpwYAABCQWlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMwMTQgNzkuMTU2Nzk3LCAyMDE0LzA4LzIwLTA5OjUzOjAyICAgICAgICAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIKICAgICAgICAgICAgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iCiAgICAgICAgICAgIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiCiAgICAgICAgICAgIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIgogICAgICAgICAgICB4bWxuczpwaG90b3Nob3A9Imh0dHA6Ly9ucy5hZG9iZS5jb20vcGhvdG9zaG9wLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOnRpZmY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vdGlmZi8xLjAvIgogICAgICAgICAgICB4bWxuczpleGlmPSJodHRwOi8vbnMuYWRvYmUuY29tL2V4aWYvMS4wLyI+CiAgICAgICAgIDx4bXA6Q3JlYXRlRGF0ZT4yMDE1LTEyLTA0VDIxOjAyOjU2WjwveG1wOkNyZWF0ZURhdGU+CiAgICAgICAgIDx4bXA6TW9kaWZ5RGF0ZT4yMDE1LTEyLTA1VDAzOjIyOjU2KzA1OjMwPC94bXA6TW9kaWZ5RGF0ZT4KICAgICAgICAgPHhtcDpNZXRhZGF0YURhdGU+MjAxNS0xMi0wNVQwMzoyMjo1NiswNTozMDwveG1wOk1ldGFkYXRhRGF0ZT4KICAgICAgICAgPHhtcDpDcmVhdG9yVG9vbD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNCAoTWFjaW50b3NoKTwveG1wOkNyZWF0b3JUb29sPgogICAgICAgICA8ZGM6Zm9ybWF0PmltYWdlL3BuZzwvZGM6Zm9ybWF0PgogICAgICAgICA8eG1wTU06SGlzdG9yeT4KICAgICAgICAgICAgPHJkZjpTZXE+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPmNvbnZlcnRlZDwvc3RFdnQ6YWN0aW9uPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6cGFyYW1ldGVycz5mcm9tIGltYWdlL3BuZyB0byBhcHBsaWNhdGlvbi92bmQuYWRvYmUucGhvdG9zaG9wPC9zdEV2dDpwYXJhbWV0ZXJzPgogICAgICAgICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+c2F2ZWQ8L3N0RXZ0OmFjdGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0Omluc3RhbmNlSUQ+eG1wLmlpZDpFM0Y5M0QxRTBDMjA2ODExODIyQTg0QUVFNTNGQkEwQzwvc3RFdnQ6aW5zdGFuY2VJRD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OndoZW4+MjAxNS0xMi0wNVQwMzowODo0NiswNTozMDwvc3RFdnQ6d2hlbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OmNoYW5nZWQ+Lzwvc3RFdnQ6Y2hhbmdlZD4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPmNvbnZlcnRlZDwvc3RFdnQ6YWN0aW9uPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6cGFyYW1ldGVycz5mcm9tIGltYWdlL3BuZyB0byBhcHBsaWNhdGlvbi92bmQuYWRvYmUucGhvdG9zaG9wPC9zdEV2dDpwYXJhbWV0ZXJzPgogICAgICAgICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+c2F2ZWQ8L3N0RXZ0OmFjdGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0Omluc3RhbmNlSUQ+eG1wLmlpZDpFNEY5M0QxRTBDMjA2ODExODIyQTg0QUVFNTNGQkEwQzwvc3RFdnQ6aW5zdGFuY2VJRD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OndoZW4+MjAxNS0xMi0wNVQwMzowODo0NiswNTozMDwvc3RFdnQ6d2hlbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OmNoYW5nZWQ+Lzwvc3RFdnQ6Y2hhbmdlZD4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPnNhdmVkPC9zdEV2dDphY3Rpb24+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDppbnN0YW5jZUlEPnhtcC5paWQ6MWJmOGMzNDAtMDExMi00YTZlLWExYTAtNjIwYTRkOTQxNTg5PC9zdEV2dDppbnN0YW5jZUlEPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6d2hlbj4yMDE1LTEyLTA1VDAzOjIyOjU2KzA1OjMwPC9zdEV2dDp3aGVuPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6c29mdHdhcmVBZ2VudD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNCAoTWFjaW50b3NoKTwvc3RFdnQ6c29mdHdhcmVBZ2VudD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OmNoYW5nZWQ+Lzwvc3RFdnQ6Y2hhbmdlZD4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPmNvbnZlcnRlZDwvc3RFdnQ6YWN0aW9uPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6cGFyYW1ldGVycz5mcm9tIGFwcGxpY2F0aW9uL3ZuZC5hZG9iZS5waG90b3Nob3AgdG8gaW1hZ2UvcG5nPC9zdEV2dDpwYXJhbWV0ZXJzPgogICAgICAgICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+ZGVyaXZlZDwvc3RFdnQ6YWN0aW9uPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6cGFyYW1ldGVycz5jb252ZXJ0ZWQgZnJvbSBhcHBsaWNhdGlvbi92bmQuYWRvYmUucGhvdG9zaG9wIHRvIGltYWdlL3BuZzwvc3RFdnQ6cGFyYW1ldGVycz4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPnNhdmVkPC9zdEV2dDphY3Rpb24+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDppbnN0YW5jZUlEPnhtcC5paWQ6Mzk2ZmIyZDItNzMyYi00YTBhLTljYTctOGE2ZmIyMDg5YmViPC9zdEV2dDppbnN0YW5jZUlEPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6d2hlbj4yMDE1LTEyLTA1VDAzOjIyOjU2KzA1OjMwPC9zdEV2dDp3aGVuPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6c29mdHdhcmVBZ2VudD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNCAoTWFjaW50b3NoKTwvc3RFdnQ6c29mdHdhcmVBZ2VudD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OmNoYW5nZWQ+Lzwvc3RFdnQ6Y2hhbmdlZD4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgIDwvcmRmOlNlcT4KICAgICAgICAgPC94bXBNTTpIaXN0b3J5PgogICAgICAgICA8eG1wTU06RGVyaXZlZEZyb20gcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICA8c3RSZWY6aW5zdGFuY2VJRD54bXAuaWlkOjFiZjhjMzQwLTAxMTItNGE2ZS1hMWEwLTYyMGE0ZDk0MTU4OTwvc3RSZWY6aW5zdGFuY2VJRD4KICAgICAgICAgICAgPHN0UmVmOmRvY3VtZW50SUQ+eG1wLmRpZDpFM0Y5M0QxRTBDMjA2ODExODIyQTg0QUVFNTNGQkEwQzwvc3RSZWY6ZG9jdW1lbnRJRD4KICAgICAgICAgICAgPHN0UmVmOm9yaWdpbmFsRG9jdW1lbnRJRD54bXAuZGlkOkUzRjkzRDFFMEMyMDY4MTE4MjJBODRBRUU1M0ZCQTBDPC9zdFJlZjpvcmlnaW5hbERvY3VtZW50SUQ+CiAgICAgICAgIDwveG1wTU06RGVyaXZlZEZyb20+CiAgICAgICAgIDx4bXBNTTpEb2N1bWVudElEPmFkb2JlOmRvY2lkOnBob3Rvc2hvcDpmNzZlMDBiNi1kYWMwLTExNzgtOGNhNy1hYmZlM2EyY2MzZDY8L3htcE1NOkRvY3VtZW50SUQ+CiAgICAgICAgIDx4bXBNTTpJbnN0YW5jZUlEPnhtcC5paWQ6Mzk2ZmIyZDItNzMyYi00YTBhLTljYTctOGE2ZmIyMDg5YmViPC94bXBNTTpJbnN0YW5jZUlEPgogICAgICAgICA8eG1wTU06T3JpZ2luYWxEb2N1bWVudElEPnhtcC5kaWQ6RTNGOTNEMUUwQzIwNjgxMTgyMkE4NEFFRTUzRkJBMEM8L3htcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD4KICAgICAgICAgPHBob3Rvc2hvcDpDb2xvck1vZGU+MzwvcGhvdG9zaG9wOkNvbG9yTW9kZT4KICAgICAgICAgPHRpZmY6T3JpZW50YXRpb24+MTwvdGlmZjpPcmllbnRhdGlvbj4KICAgICAgICAgPHRpZmY6WFJlc29sdXRpb24+NzIwMDAwLzEwMDAwPC90aWZmOlhSZXNvbHV0aW9uPgogICAgICAgICA8dGlmZjpZUmVzb2x1dGlvbj43MjAwMDAvMTAwMDA8L3RpZmY6WVJlc29sdXRpb24+CiAgICAgICAgIDx0aWZmOlJlc29sdXRpb25Vbml0PjI8L3RpZmY6UmVzb2x1dGlvblVuaXQ+CiAgICAgICAgIDxleGlmOkNvbG9yU3BhY2U+NjU1MzU8L2V4aWY6Q29sb3JTcGFjZT4KICAgICAgICAgPGV4aWY6UGl4ZWxYRGltZW5zaW9uPjI1NjwvZXhpZjpQaXhlbFhEaW1lbnNpb24+CiAgICAgICAgIDxleGlmOlBpeGVsWURpbWVuc2lvbj4yNTY8L2V4aWY6UGl4ZWxZRGltZW5zaW9uPgogICAgICA8L3JkZjpEZXNjcmlwdGlvbj4KICAgPC9yZGY6UkRGPgo8L3g6eG1wbWV0YT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/Pqyx0F0AAAAgY0hSTQAAeiUAAICDAAD5/wAAgOkAAHUwAADqYAAAOpgAABdvkl/FRgAAG5ZJREFUeNrsnXt4FOWhxn+bbG4EErnkxiVA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";
    } else {
      val.profileimage =
          "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";
    }
  }

  String manupulateDayFromInt(String mMeetingDate) {
    if (mMeetingDate != null) {
      switch (mMeetingDate) {
        case "1":
          return "Sunday";
        case "2":
          return "Monday";
        case "3":
          return "Tuesday";
        case "4":
          return "Wednesday";
        case "5":
          return "Thusrday";
        case "6":
          return "Friday";
        case "7":
          return "Saturday";
      }
    }
    return "";
  }

  void showMessageWithoutProgress(String message) {
    try {
      _scaffoldHomeState.currentState.hideCurrentSnackBar();
    } catch (e) {}
    print(" message is  ${message}");
    if (this.mounted == true) {
      _scaffoldHomeState.currentState.showSnackBar(new SnackBar(
          backgroundColor: Colors.black,
          duration: Duration(seconds: 5),
          content: Container(
              height: 30.0,
              child: new Column(children: <Widget>[new Text(message)]))));
    }
  }

  void showMessage(String message) {
    try {
      _scaffoldHomeState.currentState.hideCurrentSnackBar();
    } catch (e) {}
    try {
      _scaffoldHomeState.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldHomeState.currentState.showSnackBar(new SnackBar(
      backgroundColor: Colors.black,
      content: new Row(
        children: <Widget>[
          const CircularProgressIndicator(),
          new Text(message)
        ],
      ),
      duration: Duration(seconds: 20),
    ));
  }
}
