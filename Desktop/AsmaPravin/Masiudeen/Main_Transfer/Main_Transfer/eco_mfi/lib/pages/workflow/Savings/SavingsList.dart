import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:eco_mfi/pages/workflow/Savings/SavingsAccountList.dart';
import 'package:eco_mfi/pages/workflow/Savings/SavingsCollectionSearch.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SavingsList extends StatefulWidget {
  var cameras;

  @override
  SavingsListState createState() {
    return new SavingsListState();
  }


}

class SavingsListState extends State<SavingsList> {


  SharedPreferences prefs;
  @override
  void initState() {
    super.initState();

    getsharedPreferences();
    setMenusAndImages();
    setState(() {
    });
  }

  getsharedPreferences()async {
    prefs = await SharedPreferences.getInstance();



  }

  GestureDetector gestureDetector(name, image,onTap) {
    return new GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: new RaisedButton(
          elevation: 2.0,
          highlightColor: Colors.black,
          splashColor: Colors.orange,
          colorBrightness: Brightness.dark,
          color: Colors.white,
           onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();

            if (onTap == 29) {
              print("New Account Opening");
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new SavingsAccountList("Savings Account List")), //When Authorized Navigate to the next screen
              );
            } else if (onTap == 30) {
              print(" Savings Collection");
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new SavingsCollectionSearchScreen()), //When Authorized Navigate to the next screen
              );
            }



          },
          child: new FittedBox(
            alignment: Alignment.center,
            fit: BoxFit.none,
            child: new Column(
              children: <Widget>[
                new Image(
                  image: new AssetImage(image),
                ),
                SizedBox.fromSize(),
                new Center(
                  child: new Text(
                    name,
                    style:
                    new TextStyle(color: Color(0xff07426A), fontSize: 11.0,),
                  ),
                  heightFactor: 4.0,
                )
              ],
            ),
          )),
    );

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Savings account",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 3.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
           onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,


      ),


      body:new GridView.count(
      primary: true,
      padding: const EdgeInsets.all(1.0),
      crossAxisCount: 2,
      //childAspectRatio: 0.80,
      mainAxisSpacing: 0.1,
      crossAxisSpacing: 0.1,
     /* children: <Widget>[

        gestureDetector("New Account Opening", "assets/create_centers.png"),
        gestureDetector("Savings Collection", "assets/group_foundation.png"),
        //gestureDetector("Bulk Deposite", "assets/prospect_creation.png"),


      ],
      */
          children: commentWidgets
    ),
    );
  }


  void setMenusAndImages() async {
    for (int display = 0; display < Constant.savingsDashBoardMenus.length; display++) {
      commentWidgets
          .add(gestureDetector(Constant.savingsDashBoardMenus[display].menuDesc,Constant.savingsDashBoardMenus[display].murl,
          Constant.savingsDashBoardMenus[display].menuId));
    }

    print("common widgets is ${commentWidgets}");
    setState(() {
    });
  }


  var commentWidgets = List<Widget>();
}
