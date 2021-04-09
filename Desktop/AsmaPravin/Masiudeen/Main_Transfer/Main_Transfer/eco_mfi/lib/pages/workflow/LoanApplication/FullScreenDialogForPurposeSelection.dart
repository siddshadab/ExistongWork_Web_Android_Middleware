import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/Product.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/PurposeOfLoan.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterDetailsBean.dart';

import 'package:eco_mfi/pages/workflow/centerfoundation/bean/GetCentersSelectionList.dart';
import 'package:eco_mfi/translations.dart';

class FullScreenDialogForPurposeSelection extends StatefulWidget {
  final position;
  FullScreenDialogForPurposeSelection( {this.position});
  @override
  _FullScreenDialogForPurposeSelectionState createState() =>
      new _FullScreenDialogForPurposeSelectionState();
}

class _FullScreenDialogForPurposeSelectionState
    extends State<FullScreenDialogForPurposeSelection> {
  List<SubLookupForSubPurposeOfLoan> items = new List();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  static const JsonCodec JSON = const JsonCodec();

  //String url = 'http://14.141.164.239:8090/purposeData/getlistOfPurposes/';

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
    return new SizedBox(
      child: new Card(
          child: new Column(
        children: <Widget>[
          new ListTile(
            leading: new Text(
              '${items[index].codeDesc}',
              //textScaleFactor: 1.2,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.black,
              ),
            ),

            title: new Text(
              '${items[index].code}',
              //textScaleFactor: 0.9,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.blueAccent,
              ),
            ),

            //trailing: ,
            onTap: () {
              _onTapItem(context, items[index]);
            },
          )
        ],
      )),
    );
  }

  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
        future: AppDatabase.get()
            .getSunPurposeOfLoanListFromSubLookpTable(4000,widget.position)
            .then((List<SubLookupForSubPurposeOfLoan> response) => items = response),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Text(Translations.of(context).text('Press_Button_To_Start'));
            case ConnectionState.waiting:
              return new Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16.0),
                  child:
                      new CircularProgressIndicator()); // new Text('Awaiting result...');
            default:
              if (snapshot.hasError)
                return new Text(Translations.of(context).text('error')+"${snapshot.error}");
              else
                return getHomePageBody(context, snapshot);
          }
        });
    return Scaffold(
      key: _scaffoldHomeState,
      appBar: new AppBar(
        elevation: 3.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: new Text(
          Translations.of(context).text('Purpose_Selection_List'),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      /*  floatingActionButton: new FloatingActionButton(
        child: new Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        onPressed: () async {
          bool isDataChanged = await Navigator.push(
            context,
            new MaterialPageRoute<bool>(
                builder: (context) => new CustomerFormationBasicDetails()),
          );

        },
      ),*/
      body: Center(
        child: futureBuilder,
      ),
    );
  }

  void _onTapItem(BuildContext context, SubLookupForSubPurposeOfLoan getPurposeOfLoanList) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(getPurposeOfLoanList.code.toString() +
            ' - ' +
            getPurposeOfLoanList.codeDesc)));

    Navigator.of(context).pop(getPurposeOfLoanList);

  }
}
