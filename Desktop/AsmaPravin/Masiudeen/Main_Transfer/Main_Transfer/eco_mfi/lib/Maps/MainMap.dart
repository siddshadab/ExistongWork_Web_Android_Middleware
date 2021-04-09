import 'dart:io' as Io;
import 'dart:convert';
import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';
import 'package:eco_mfi/Maps/CentersMap.dart';
import 'package:eco_mfi/Maps/GetPathTrackeronUserId.dart';
import 'package:eco_mfi/Maps/MapsUtils.dart';
import 'package:eco_mfi/Maps/PathTrackerMap.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
//import 'package:eco_mfi/Utilities/CustomSwitch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

class MainMap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainMap();
}

class _MainMap extends State<MainMap> {
  LatLng _center = null;
  CurrentLoactionBean userUsingLocation = new CurrentLoactionBean();
  var formatter = new DateFormat('dd/MMM/yyyy');
  var formatterWithHours = new DateFormat('dd/MM/yyyy HH:mm');
  Map<String, List<CurrentLoactionBean>> locations =
      new Map<String, List<CurrentLoactionBean>>();
  List<String> userAllocated = new List<String>();

  List<Marker> markers = List<Marker>();
  Timer _ticker;

  Completer<GoogleMapController> _controller = Completer();

  final Color inactiveColor = Colors.grey;
  final String activeText = 'Center';
  final String inactiveText = 'Users';
  final Color activeTextColor = Colors.white70;
  final Color inactiveTextColor = Colors.white70;
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();

  int _pageIndex = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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
    MapsUtils.mapTheme = await rootBundle
        .loadString('assets/mapThemes/google_maps_theme_default.json');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
    if (this.mounted == true) {
      setState(() {
        if (_center == null) {
          double geoLat = prefs.get(TablesColumnFile.geoLatitude);
          double geoLong = prefs.get(TablesColumnFile.geoLongitude);
          print("Geo latd ${geoLat} and geologth ${geoLong}");
          _center = LatLng(geoLat, geoLong);
          userUsingLocation.mgeolatd = geoLat.toString();
          userUsingLocation.mgeologd = geoLong.toString();
        }

        userUsingLocation.musrcode = prefs.get(TablesColumnFile.musrcode);
        userUsingLocation.musrname = prefs.get(TablesColumnFile.musrname);
        userUsingLocation.mreportinguser =
            prefs.get(TablesColumnFile.mreportinguser);
      });
    }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldHomeState,
      //backgroundColor: Color.fromRGBO(28, 35, 38, 100),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        child: Icon(Icons.refresh),
        backgroundColor: Colors.blueGrey.withOpacity(0.5),
      ),
      body: _buildMap(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (int index) async {
          await selectMapTheme(index).then((value) async {
            final GoogleMapController controller = await _controller.future;
            controller.setMapStyle(MapsUtils.mapTheme);
            setState(() {
              _pageIndex = index;
            });
          });
        },
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.solidCircle,
                color: Colors.white,
              ),
              title: Text(
                "Dark",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.solidMoon,
                color: Colors.white,
              ),
              title: Text(
                "Light",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.map,
                color: Colors.white,
              ),
              title: Text(
                "Default",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.ghost,
                color: Colors.white,
              ),
              title: Text(
                "Aubergine",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black),
        ],
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
    double mapHeight = height - 180.0;
    double bottomheight = (height - mapHeight) - 130;
    double bottomWidth = width - 50;
    return Column(
      children: [
        new Container(
            height: mapHeight,
            child: GoogleMap(
                markers: markers.toSet(),
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 14.0,
                ),
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
      ],
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    controller.setMapStyle(MapsUtils.mapTheme);
    await getAsyncApiCall().then((onValue) {
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

  Future<Null> getAsyncApiCall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String musrcode = prefs.getString(TablesColumnFile.musrcode);
    geChildUserLiveLocation(musrcode);
  }

  Future<Null> selectMapTheme(int index) async {
    print("XXXXXXXXXXXXXXXXXXXXX ${index}");
    switch (_pageIndex) {
      case 0:
        MapsUtils.mapTheme = await rootBundle
            .loadString('assets/mapThemes/google_maps_theme_dark.json');
        break;
      case 1:
        MapsUtils.mapTheme = await rootBundle
            .loadString('assets/mapThemes/google_maps_theme_night.json');
        break;
      case 2:
        MapsUtils.mapTheme = await rootBundle
            .loadString('assets/mapThemes/google_maps_theme_default.json');
        break;
      case 3:
        MapsUtils.mapTheme = await rootBundle
            .loadString('assets/mapThemes/google_maps_theme_aubergine.json');
        break;
    }
  }

  Future<Null> geChildUserLiveLocation(String muser) async {
    markers.clear();
    GetCurrentLocationOnSuperUsers getCurrentLocationOnSuperUsers =
        new GetCurrentLocationOnSuperUsers();
    Marker marker = Marker(
        markerId: MarkerId(userUsingLocation.musrcode),
        position: _center,
        infoWindow: InfoWindow(
          title: userUsingLocation.musrname,
          snippet: userUsingLocation.musrcode,
        ),
        //  icon: await getMarkerIcon(userUsingLocation.profileimage, Size(150.0, 150.0)),
        onTap: () {
          settingModalBottomSheet(userUsingLocation, context, true, true,
              false); //this is what you're looking for!
        });

    markers.add(marker);
    setState(() {});
    showMessage("Fetching User Locations...");

    await getCurrentLocationOnSuperUsers
        .trySave(muser != null ? muser : "1234", false)
        .then((List<CurrentLoactionBean> result) async {
      if (result != null) {
        showMessageWithoutProgress("${result.length} Users Found");
        result.forEach((val) async {
          double lat = 0.0;
          double long = 0.0;
          try {
            lat = double.parse(val.mgeolatd);
            long = double.parse(val.mgeologd);
          } catch (_) {}

          try {
            Marker marker = Marker(
                markerId: MarkerId(val.musrcode),
                position: LatLng(lat, long),
                infoWindow: InfoWindow(
                  title: "User Name (" +
                      val.musrname +
                      ") User Code (" +
                      val.musrcode +
                      ")",
                  snippet: "Last Location Update (" +
                      val.mlastupdatedt.toString() +
                      ")",
                ),
                icon: await MapsUtils.getMarkerIcon(val, Size(150.0, 150.0)),
                onTap: () {
                  settingModalBottomSheet(val, context, true, true, false);
                });

            setState(() {
              markers.add(marker);
            });
          } catch (_) {}
        });
      } else {
        showMessageWithoutProgress("No Users Found");
      }
    });

    //setState(() {});
  }

  void showMessageWithoutProgress(String message) {
    try {
      _scaffoldHomeState.currentState.hideCurrentSnackBar();
    } catch (e) {}
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
    _scaffoldHomeState.currentState.showSnackBar(new SnackBar(
      backgroundColor: Colors.black,
      content: new Row(
        children: <Widget>[
          const CircularProgressIndicator(),
          new Text(message)
        ],
      ),
      duration: Duration(seconds: 300),
    ));
  }

  void settingModalBottomSheet(CurrentLoactionBean result, BuildContext context,
      bool isCenters, bool isPathTracker, bool isCustomer) {
    Uint8List image = base64Decode(result.profileimage != null
        ? result.profileimage
        : "iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAkFBMVEX///8UHzgAACkADC0AACGnqa6Ii5MAEzEAABxlaHTc3d8AACUMGjX09PXBwsYAAB4AABY2PU4AACYAACoIFzNobHcAABn5+foABivo6evh4uVJT1+doKeUl5/Iys7R09YuNkq0trxzd4J/g42wsrgiK0JPVWSho6oaJT0xOUxZXmxNUmJBSFl7f4lvc39dYm+/Q6pVAAAKOUlEQVR4nO1da2OyIBROwbSkLLMyK7vNbmvt//+7d60VmAcRutrL820OiEfgcC54qFQeg369uVrU2snaWCft2mLVrPcf9MsPQTQa2p4f2gExDiCBHfqe/TmKnt2x26A+TpwwMLIIQicZl59kc+iFBKB3BAm9z+azu3gVZgmGRi81kng6e3Y3ldGcuvzhYwbSnZZzHCdDrwi/X47ecPLs7kpjUHNE8zM1V53a4NldlkJ/gW0JfgfYeFGiHXKEkSS/A5A3enbHC2JmmCADYnd8F2Ps+h0bXqGmUQaxGoMClCAXt/erWTypT+LZat/GLoKKudP42QQEqC8x0HEbG9U4vcr68YJAa5XgZf1JfS+Cwb4HdNr2avBeENccoHjQ27+qWO1XIQET4C6/w4MuNI42rr6kWF2hEODnCSZdfQntm2G4elCvi2Nm+NCiaosFR9yGlq7/YmJ1AvbSJMV6OSPw23kdTS6CZxoqvoGPwBnuvIhYbcxBaeFJKWH9hQc2Mm/crd+Fuzb2IAHq5AhQGIMuNBGQM36yWLVQB1pCnyrTq/4JLmZk3bzXxdFMAA2NuBuuAI1mlmXNuL6ZeANpfG7yLAN5sgPfufHBKd+sIeybpuljVOP1+QPS2gnePUOswiYu8sec8pbhUlli4zVv7o19cF1/P9op1/iCVErb5QnQ+qXF8TOXOX3uL1yoaefroWJ1bEIvusf1RMwAl1vg8qbqoNaTmh63x0cILRbvk7tYRq1s+R+0uFJy8gl5sTod3hK/LUATN9cjOHNAgobh8OvAnshH+B1hH6FJct5uBI/gL8UcveCDgDPlzn7HQdeTXyE7vlvR/syrCItV745+x0YVFKACKTfDXIKG4eXOOo7E7i3uJFZHJmjifgteaZKa1STtZiOb/MqDb2jShP49/I6zNWTEeUJtI2aHEPXa3XaPnXueqP5kBy58ruakCo7GWEC0zZl55v7O58bcZTgvhC38iFXg3eZovwqob8H32Cmi9TOT1DmZ/JZHe9ou0IbVAcXqzQzkwb4FrPeCKsagR2vMz0+7tEGvkP0HilW7JW2FQuhXXahxp6D1HdMZ5lJFtE4XJy42EI05rAhf73dcdUAPSmFVv3lmSKbMY+M8d92iyyn6Br1B5nV+x1kCesEkzDWGIbviNpRhcT0MNkj9RN3vCLZI5FpkZimhT/u03cJjeMDPGwd6VMQrCyGCN1tbzm3Crjg68rH0OjzBskG1YytvIMMKE3JkV3afcgl256eMqoplG6xCzr3Cku/czBgKsii5Lxky5tffszl10DG0i6Ixh3yrSCqcY0GGi6ILeszMKrPdbFQazSnzKFQx3OFwjhkUXUCwjxDvFJcza/4S32k5KWHhqHmYYlgIrosIZtjEvSIUtMw7lWEvVZvlBLuEG1kEOoGuCudNvGyDZ3hXqJZwwLKXq4w0wGMwyLtONdrzj56Ec3F1PjhiFfMtctBHaF8fVg94p78C48qW4YMDyIXFF+xQv4WJUgcUkd/GO9c7sutL2DOWFaugiUvwbczMiQueoPVvYt/FG0isXhrnDdDE9de3iqVHSVYomNNb+cw4DpYtsxwjA1iAtz1mNr+wou2W2H1RHCNI5CByXgQRMEFvflSwXsPmiaRt4v1tY0ngYUhysrkbJEPwLsc9B9a2gw8Iv63bOzyhaB8hx1HaXrInnlKUulA/onp0L5c1IFbR9vCP5kXcpATnA3nIBo2cA5WLsEJukOXlcRnOCYY/YialNiLzcWHI++BCMfOiyorZqe4X83ggGgtWk+tYrHPW3L7qwU45DLZ01Ox9ZUr/2D67azfD8ixbyK5CB1TKr/faaDJqHMNQ0q/3ymB8mEYlocvwmQfIbguL7hlJZUun7PQlT1croE9DemRZqdLtI0hW1jtgtKZKDKoyoZPDB4/mO4D9pNNtVvqAw+qN0PlZeV8qX2GVBegQSGDi0O+H3q+WNgKOOrwJ3D9P9ue7zlN0OlTW37wnRdQ+b/D94TtOVDcV9Rnl5QUoI0joXUSTBlUbd5B9AkvXFoEpTOAH96ttQIWRiYMqYMvHq69u7Yjujv7M9PSQB6Yw+S3cbdMHbWHty8LdKX2wE9am5i0t3P2yxMdhPs7KuV2TKdz9fUB13R+1UIRMYep1MMVOsZpMYRaWDEPrtgyZTovtOanCnE5rhv8DwxuvQ6mldQOGpF0VgboJMgzJUFh7eBadGYbBVlibSmJlhgZBIlCLOsOwQG26L2UYGoFEbXWGMsgylEGWoQw0Q82wGP4E7zsz/BtDNe/WQxnmHkbjo3M8vvGhZm66x8MtY7X3I/z65gKJkrmIj+G5fkelNkFHk3yg9HaDqRzByqSl0MneyeicKdQmrdMppjHvi8y82j3p7xJjA7OzxYY3XKYEcn26EmZh6jsUuDa73kLXpse0Rjj1iQz806naOFH58LI5pnEpuwvqTAvaEbSYsVZ1fzam/7PnYG3moy80nrFhocZHqmWwNhO8TsaqH89SpY8TPe3T+ZT9fol+HIvhA1BMlK+V07IDh8Ri+FsVOTAM4ZfUYBhm/CIMQzj2mseQadmBT09wvsaRg2aoGWqGmqFmqBmKoRlqhpqhZqgZaoZiaIaaoWaoGWqGmqEYmqFmqBlqhpqhZiiGZqgZaoaaoWaoGYqhGWqGmqFmqBlqhmJohpqhZqgZaoaaoRiaoWaoGWqGmqFmKIZmqBlqhpqhZqgZiqEZaoaaoWaoGWqGYmiGmqFmqBk+lOFbZv6Qzd7ywb7rEmRviQ0szqGTypPju0wGHiSZgeenPO3lSjYDD8Jr6Qw8almUTveYlSGL0nWZsJRyoRF0/GnFTFgbOYLMlcQyMP+ymQF32RXAXzYzxWxvktnMVDPS7Y99VMu593dzrmpGOtU8wlL4D7IKaoa50Azz8aAsuxmGJciyK5cp+ZJhGTIl/6UkzS18vgw+w7AM2a4L5PNe3Y3hq2Qs1wzzUQaGzDosT9b5EdV+H3+Dx/mnpW7wCCWuoG7Ok5T5+uBbWAyZ2kxhlMwLmfr1L9+1lYzDp4PYrv8lug072kJ3eJcIyPvO5bjw1HTCV4Lt8aXbZK2mb78aTF5i6JVTzuWXBfHAnWOvlmj+NeF8ZQl21bxHrwp3/+YEfyjO0wSrmdsMiI3Kc+9qiLJbOE7dEt+8uKmTdJx1tzp69rW3hTGqdteeeUGyx0STGuldguDNSqQavB6i1QanOBJEQ0W1lB7jb1TuGXgFxNOUNEFnaROzkRDiSejoL4dxass7z9NdwBA0yzqAR8QuM1OD4fFhk4nCEDR4bg+vRsTeAOMdB3HIDCEn4l4msJcA2d+HJxGzU2A5T8Brgr3BuXWYkszlQ/ZSWL0MYORK53C3D73YlHdmomxg5mmwS8WU7Yy2WlJ800F0G5Um3SRDK6q/AyKLLjw3rjDHXowQvweYgwDhqjIvv2cmD/aisnsX1wWM4LuSiEuVGaRdWT+7D3dGUnl2D+4OzbD80AzLj/dn+A/7Xkthc6C0xwAAAABJRU5ErkJggg==");

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 200.0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(20),
                height: 120,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          blurRadius: 20,
                          offset: Offset.zero,
                          color: Colors.grey.withOpacity(0.5))
                    ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 30,
                      height: 40,
                      margin: EdgeInsets.only(left: 10),
                      child: ClipOval(
                          child: new Image.memory(image, fit: BoxFit.cover)),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(result.musrcode.toString(),
                                style: TextStyle(color: Colors.grey)),
                            Text('Latitude: ${result.mgeolatd.toString()}',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                            Text('Longitude: ${result.mgeologd.toString()}',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                            isPathTracker == true
                                ? new RaisedButton(
                                    child: new Text('Track History'),
                                    textColor: Colors.white,
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                    ),
                                    color: Colors.lightBlueAccent,
                                    onPressed: () async {
                                      //Navigate To Path Tracker
                                      Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                //new CustomerFormationMasterTabs(widget.cameras)), //When Authorized Navigate to the next screen
                                                new PathTrackerMap(result
                                                    .musrcode
                                                    .toString())),
                                      );
                                      //gePathTrackerAndDrawPath(result.musrcode);
                                      //      Navigator.pop(context);
                                    },
                                  )
                                : new Container()
                          ],
                        ),
                      ),
                    ),
                    isCenters == true
                        ? new RaisedButton(
                            child: new Text('View Centers'),
                            textColor: Colors.white,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: Colors.lightBlueAccent,
                            onPressed: () {
                              //Navigate To Centers
                              // RouteToCentersView
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        //new CustomerFormationMasterTabs(widget.cameras)), //When Authorized Navigate to the next screen
                                        new CenterMap(
                                            result.musrcode.toString())),
                              );
                              //  getCenterApi(result.musrcode.toString());
                              // Navigator.pop(context);
                            },
                          )
                        : new Container(),
                    new RaisedButton(
                      child: new Text('Sub Users'),
                      textColor: Colors.white,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      color: Colors.lightBlueAccent,
                      onPressed: () {
                        Navigator.of(context).pop();
                        geChildUserLiveLocation(result.mcreatedby);
                      },
                    ),
                  ],
                ),
              ),
            ),
            /*),*/
          );
        });
  }
}
