import 'package:eco_mfi/Maps/CentersMap.dart';
import 'package:eco_mfi/Maps/CustomerMaps.dart';
import 'package:eco_mfi/Maps/PathTrackerMap.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';


import 'CurrentLoactionBean.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class MapsUtils {

  static String mapTheme="";

  static void settingModalBottomSheet(
      CurrentLoactionBean result,
      BuildContext context,
      bool isCenters,
      bool isPathTracker,
      bool isCustomer) {
    Uint8List image = base64Decode(result.profileimage != null
        ? result.profileimage
        : "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");

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
                    isCustomer == true
                        ? new RaisedButton(
                            child: new Text('View Customers'),
                            textColor: Colors.white,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: Colors.lightBlueAccent,
                            onPressed: () {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        //new CustomerFormationMasterTabs(widget.cameras)), //When Authorized Navigate to the next screen
                                        new CustomerMap(
                                            result.musrcode.toString())),
                              );
                              // getCustomers(result.musrcode.toString());
                              //Navigator.pop(context);
                            },
                          )
                        : new Container(),
                  ],
                ),
              ),
            ),
            /*),*/
          );
        });
  }

  static Future<ui.Image> getImageFromPath(String imagePath) async {
    Uint8List imageBytes = base64Decode(imagePath);
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(imageBytes, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  static Future<BitmapDescriptor> getMarkerIcon(
      CurrentLoactionBean val, Size size) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Radius radius = Radius.circular(size.width / 2);

    final Paint tagPaint = Paint()..color = Colors.blue;
    final double tagWidth = 40.0;

    final Paint shadowPaint = Paint()..color = Colors.blue.withAlpha(100);
    final double shadowWidth = 15.0;

    final Paint borderPaint = Paint()..color = Colors.white;
    final double borderWidth = 3.0;

    final double imageOffset = shadowWidth + borderWidth;

    // Add shadow circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        shadowPaint);

    // Add border circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(shadowWidth, shadowWidth,
              size.width - (shadowWidth * 2), size.height - (shadowWidth * 2)),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        borderPaint);

    // Add tag circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(size.width - tagWidth, 0.0, tagWidth, tagWidth),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        tagPaint);

    // Add tag text

    // Oval for the image
    Rect oval = Rect.fromLTWH(imageOffset, imageOffset,
        size.width - (imageOffset * 2), size.height - (imageOffset * 2));

    // Add path for oval image
    canvas.clipPath(Path()..addOval(oval));

    // Add image

    ui.Image image;

    if (val.profileimage != null) {
      image = await getImageFromPath(val
          .profileimage); // Alternatively use your own method to get the image
    } else {
      image = await getImageFromPath(
          "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");
    }
    paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);

    // Convert canvas to image
    final ui.Image markerAsImage = await pictureRecorder
        .endRecording()
        .toImage(size.width.toInt(), size.height.toInt());

    // Convert image to bytes
    final ByteData byteData =
        await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }

  static Future<BitmapDescriptor> getMarkerIconWithNumber(
      CurrentLoactionBean val,
      Size size,
      int numberSequence,
      BuildContext context) async {
    Widget widget = Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(width: 2),
        shape: BoxShape.circle,
        // You can use like this way or like the below line
        //borderRadius: new BorderRadius.circular(10.0),
        color: Colors.red,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18.0),
        child: new MaterialApp(
          debugShowCheckedModeBanner: false,
          home: new Scaffold(
            backgroundColor: Colors.red,
            body: Center(
                child: new Text(
              numberSequence.toString(),
            )),
          ),
          title: numberSequence.toString(),
        ),
      ),
    );
//    Widget widget =
//    new Container(
//        width: 50,
//        height: 50,
//    child: CircleAvatar(
//
//      backgroundColor: Colors.red,
//      foregroundColor: Colors.white,
//      child: new Text(numberSequence.toString()),
//    ));

    Uint8List data = await createImageFromWidget(widget);

    return BitmapDescriptor.fromBytes(data);
  }

  static List decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    // repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negative then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    /*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  static List<LatLng> convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  static Future<Uint8List> createImageFromWidget(Widget widget,
      {Duration wait, Size logicalSize, Size imageSize}) async {
    final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();

    logicalSize ??= ui.window.physicalSize / ui.window.devicePixelRatio;
    imageSize ??= ui.window.physicalSize;

    assert(logicalSize.aspectRatio == imageSize.aspectRatio);

    final RenderView renderView = RenderView(
      window: null,
      child: RenderPositionedBox(
          alignment: Alignment.center, child: repaintBoundary),
      configuration: ViewConfiguration(
        size: logicalSize,
        devicePixelRatio: 1.0,
      ),
    );

    final PipelineOwner pipelineOwner = PipelineOwner();
    final BuildOwner buildOwner = BuildOwner();

    pipelineOwner.rootNode = renderView;
    renderView.prepareInitialFrame();

    final RenderObjectToWidgetElement<RenderBox> rootElement =
        RenderObjectToWidgetAdapter<RenderBox>(
      container: repaintBoundary,
      child: widget,
    ).attachToRenderTree(buildOwner);

    buildOwner.buildScope(rootElement);

    if (wait != null) {
      await Future.delayed(wait);
    }

    buildOwner.buildScope(rootElement);
    buildOwner.finalizeTree();

    pipelineOwner.flushLayout();
    pipelineOwner.flushCompositingBits();
    pipelineOwner.flushPaint();

    final ui.Image image = await repaintBoundary.toImage(
        pixelRatio: imageSize.width / logicalSize.width);

    final ByteData byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);

    return byteData.buffer.asUint8List();
  }
}
