import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/pages/workflow/AdminModule/AccessRightsModule.dart';
import 'package:eco_mfi/pages/workflow/AdminModule/CustomerModificationAccess.dart';
import 'package:eco_mfi/pages/workflow/PassChangeModule/ResetPasswordByAdmin.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;

class AdminDashBoard extends StatefulWidget {
  @override
  _AdminDashBoardState createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {

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
      child: new RaisedButton(
          elevation: 2.0,
          highlightColor: Colors.black,
          splashColor: Colors.white70,
          colorBrightness: Brightness.dark,
          color: Colors.white,
           onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
            print("onTapValue hai ${onTap}");
            if (onTap == 34) {
              print("Access Rights");
              // AppDatabase.get().deletSomeLoanUtil();
              // AppDatabase.get().getCustomerLoanDetails();

              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    // new LoanLimitDetails()), //When Authorized Navigate to the next screen
                    new CustomerModificationAccess()),
              );
            } else if (onTap == 32) {
              print("Reset Password");
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new ResetPasswordByAdmin("Admin")), //When Authorized Navigate to the next screen
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
                    style: new TextStyle(color: Color(0xff07426A), fontSize: 11.0,),
                  ),
                    heightFactor: 2.0,
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
          "Admin Management",
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
        crossAxisCount: 3,
        //childAspectRatio: 0.80,
        mainAxisSpacing: 0.3,
        crossAxisSpacing: 0.3,
        children: commentWidgets
      ),
    );
  }





  
  void setMenusAndImages() async {
    for (int display = 0; display < Constant.adminDashBoardModules.length; display++) {
      commentWidgets
          .add(gestureDetector(Constant.adminDashBoardModules[display].menuDesc,Constant.adminDashBoardModules[display].murl,
          Constant.adminDashBoardModules[display].menuId));
    }

    print("common widgets is ${commentWidgets}");
    setState(() {
    });
  }


  var commentWidgets = List<Widget>();


}