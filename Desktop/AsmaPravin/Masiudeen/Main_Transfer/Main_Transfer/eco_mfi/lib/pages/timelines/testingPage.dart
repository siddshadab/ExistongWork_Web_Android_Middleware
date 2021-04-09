import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestingPage extends StatefulWidget {
  @override
  _TestingPageState createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');
  @override
  Widget build(BuildContext context) {
    return Center(
        child: new GestureDetector(
            onTap: printMessage,
            child: new Text(
              "Ye Hai Text",
              style: TextStyle(fontSize: 40.0),
            )));
  }

  Future<Null> printMessage() async {
    print("Trying to print");

    try {
      String value = await platform.invokeMethod("loancollcenterprint", {
        "printingDevice": TablesColumnFile.UNIPOS,
        "actiontype": "fps",
      });
      print(value);
    } catch (e) {
      print(e);
    }
  }
}
