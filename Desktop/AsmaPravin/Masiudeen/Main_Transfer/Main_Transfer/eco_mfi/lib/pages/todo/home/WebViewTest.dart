import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:url_launcher/url_launcher.dart';

class webViewTester extends StatefulWidget {
  final String url;
  final String title;
  webViewTester({Key key, this.url, this.title}) : super(key: key);

  @override
  _webViewTesterState createState() => _webViewTesterState();
}

class _webViewTesterState extends State<webViewTester> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: WebView(
        initialUrl: widget.url,
        debuggingEnabled: true,
        onWebViewCreated: (WebViewController webViewController) async {
          print("Compleed");
          _controller.complete(webViewController);

          const JsonCodec JSON = const JsonCodec();
          String _serviceUrl = "routeRequestController/routeMirrorRequest";
          final _headers = {'Content-Type': 'application/json'};
//          await launch(
//            'http://10.200.33.33/OMNIReports/Others/ViewReport2008.aspx?'
//            '/Fullerton/FT_CenterList&format=EXCEL&rc:parameters=false&rs:Command=Render&'
//            'FromBranch=101&ToBranch=101&CRS=ALL&FromDate=14/12/2020&ToDate=22/12/2020',
//          );
        },
      ),
    );
  }
}
