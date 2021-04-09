import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/pages/workflow/AdminModule/AccessRightModuleBean.dart';
import 'package:eco_mfi/pages/workflow/AdminModule/AccessRightModuleSyncing.dart';
import 'package:eco_mfi/translations.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';


class AccessRightsModule extends StatefulWidget {
  @override
  _AccessRightsModuleState createState() => _AccessRightsModuleState();
}

class _AccessRightsModuleState extends State<AccessRightsModule> {

  
  String fetchingUserCode = "";
  bool showCircInd = false;
  List<Widget> dynamicAccessRights = new List<Widget>();

   @override
  void initState() {
    super.initState();
    setState(() {
    });
  } 
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Access Right Management",
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


      body:new SingleChildScrollView(


        child: new Column(children: <Widget>[
          new SizedBox(height:20.0),

          new Row(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                 new Container(
                   color: Colors.white,
                     width: 200.0,
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: new TextField(
                         controller: new TextEditingController(text:fetchingUserCode==null?"":
                         fetchingUserCode.toString()),
                         decoration: new InputDecoration(
                             border: new OutlineInputBorder(
                                 borderSide: new BorderSide(color: Colors.teal)),
                             hintText: Translations.of(context)
                                 .text('username'),
                             labelText: Translations.of(context)
                                 .text('username'),
                             prefixText: '',
                             suffixText: '',
                             suffixStyle: const TextStyle(color: Colors.green)),
                             onChanged: (String val){
                                if(val!=null){
                                      fetchingUserCode = val;
                                }
                             },
                     ),
                   ),
                 ),
                 new Container(
                   child: showCircInd == true
                              ? CircularProgressIndicator():
                                new RaisedButton(
                                  child: new Text(
                                          Translations.of(context).text('GetAccessRight'),
                                          style: TextStyle(
                                              color:
                                              Colors.white),
                                        ),

                                    onPressed: (){
                                        
                  
                                    },
                                )
                 )

                
                ],
                 
              )
            ],

            
          )


        ],



        ) ,




      )
    );
  }


Future<Null> getUserDetails() async {

    setState(() {
      showCircInd= true;
    });

   bool netAvail = false;
    Utility obj = new Utility();
    netAvail = await obj.checkIfIsconnectedToNetwork();
    if (netAvail == false) {
      // showMessageWithoutProgress("Network Not available");
      print("Network Not available");
      return;


    setState(() {
      showCircInd= false;
    });

    }
    else{
         UserAccessRightSyncing userAccessSyncing = new UserAccessRightSyncing();
          await userAccessSyncing.getAccessDetails(fetchingUserCode).then((List<AccessRightModuleBean> accessList){

                if(accessList!=null){
          

                  for(AccessRightModuleBean items in accessList ){

                      dynamicAccessRights.add(new Card(
                        child: new ListTile(
                          title: new Text(items.menuDesc),
                          subtitle: new Column(
                            


                          ) ,



                        ) ,



                      ));


                  }
                }



          });

    }


   

}



}



