import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/address/beans/GetSubDistrictSelectionList.dart';
import 'package:eco_mfi/pages/workflow/address/beans/SubDistrictDropDownBean.dart';
import 'package:eco_mfi/translations.dart';

class FullScreenDialogForSubDistrictSelection extends StatefulWidget {
  String placeCd = "";
  String placeCdDesc = "";
  final bool decendingAddrss;
  FullScreenDialogForSubDistrictSelection(this.decendingAddrss);
  @override
  FullScreenDialogForSubDistrictSelectionState createState() =>
      new FullScreenDialogForSubDistrictSelectionState();
}

class FullScreenDialogForSubDistrictSelectionState
    extends State<FullScreenDialogForSubDistrictSelection> {
  List<SubDistrictDropDownList> items = new List();
  List<SubDistrictDropDownList> storedItems = new List<SubDistrictDropDownList>();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  static const JsonCodec JSON = const JsonCodec();
  String url =
      'http://14.141.164.239:8090/subdistricts/getlistOfData/';
  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("Sub District List");
/*

  Future<List<SubDistrictDropDownList>> _getSuggestion(String url) async {
    return http.get(url).then((http.Response response) {
      final String res = response.body;
      print(res + " --res ");
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }

      final parsed = json.decode(res).cast<Map<String, dynamic>>();

      return parsed
          .map<GetSubDistrictSelectionList>(
              (json) => GetSubDistrictSelectionList.fromJson(json))
          .toList();
    });
  }
*/

  int count=1;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  getHomePageBody(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null) {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: _getItemUI,
        padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 20.0),
      );
    }
  }

  Widget _getItemUI(BuildContext context, int index) {
    return new GestureDetector(
      onTap: () {

        _onTapItem(context, items[index]);
      },
      child: new Card(
        shape: BeveledRectangleBorder(),
        child: new Row(
        children: <Widget>[
            SizedBox(height: 8.0,),
            Expanded(
              child:  new Card(
                  child:new ListTile(
                    leading:Text(
                      '${items[index].placeCd.toString()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 40.0,color: Color(0xff07426A),),
                    ),

                    title:new Text(items[index].placeCdDesc
                      ,
              style: TextStyle(

              ),
            ),

          )
              ),
            ),
        ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    var futureBuilder;
    if (count == 1 || count == 2) {
      count++;
     futureBuilder = new FutureBuilder(
        future: AppDatabase.get()
            .getSubDistrictList(widget.decendingAddrss)
            .then(
                (List<SubDistrictDropDownList> response) {
                  items.clear();
                  storedItems.clear();
              response.forEach((f) {
               // print(f);
                items.add(f);
                storedItems.add(f);
              });
              return items;
            }),


        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Text('Press button to start');
            case ConnectionState.waiting:
              return new Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16.0),
                  child:
                  new CircularProgressIndicator()); // new Text('Awaiting result...');
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
                return getHomePageBody(context, snapshot);
          }
        });
  } else if (items != null) {

      futureBuilder= ListView.builder(
        itemCount: items.length,
        itemBuilder: _getItemUI,
        padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 20.0),
      );


    }
    return Scaffold(
      key: _scaffoldHomeState,
      appBar: new AppBar(
        elevation: 3.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,
        title: appBarTitle,
        actions: <Widget>[
          new IconButton(
            icon: actionIcon,
             onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(Icons.close);
                  this.appBarTitle = new TextField(
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search, color: Colors.white),
                        hintText: Translations.of(context).text('Search'),
                        hintStyle: new TextStyle(color: Colors.white)),
                    onChanged: (val) {
                      filterList(val.toLowerCase());
                    },
                  );
                }
                else {
                  String svngListLeng = storedItems != null &&
                      storedItems.length != null &&
                      storedItems.length > 0
                      ? "/" + storedItems.length.toString()
                      : "";
                  this.actionIcon = new Icon(Icons.search);
                  this.appBarTitle =
                  new Text('Sub District List' + svngListLeng);
                  items = new List<SubDistrictDropDownList>();
                  items.clear();
                  storedItems.forEach((val) {
                    items.add(val);
                  });
                }
              });
            },
          ),
        ],
      ),
      body: Center(
        child: futureBuilder,
      ),
    );
  }

  void _onTapItem(
      BuildContext context, SubDistrictDropDownList getSubDistrictList) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(getSubDistrictList.placeCd.toString() +
            ' - ' +
            getSubDistrictList.placeCdDesc)));

    widget.placeCd = getSubDistrictList.placeCd;
    widget.placeCdDesc = getSubDistrictList.placeCdDesc.toString();
    globals.placeCd = getSubDistrictList.placeCd;
    globals.placeCdDesc = getSubDistrictList.placeCdDesc.toString();
    Navigator.of(context).pop(getSubDistrictList);
    /*Navigator.pop(context);*/
  }
  void filterList(String val) async {

    items.clear();
    storedItems.forEach((obj) {
      if (obj.placeCdDesc.toString().toLowerCase().contains(val) ||
          obj.placeCd.toString().toLowerCase().contains(val)) {
        items.add(obj);
      }
    });
    setState(() {});
  }
}
