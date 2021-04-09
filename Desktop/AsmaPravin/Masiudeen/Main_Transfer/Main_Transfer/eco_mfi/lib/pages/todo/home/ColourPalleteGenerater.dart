

import 'package:eco_mfi/Utilities/SessionTimeOut.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppdatabaseExtended.dart';
import 'package:eco_mfi/translations.dart';
import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class ColourPalleteGenerater extends StatefulWidget {

  final ColorPalleteBean passedColorPalleteObject;

  ColourPalleteGenerater({Key key, this.passedColorPalleteObject}):super(key:key);

  @override
    _ColourPalleteGeneraterState createState() => _ColourPalleteGeneraterState();

}

class _ColourPalleteGeneraterState extends State<ColourPalleteGenerater> {

  TextEditingController chartTitleColorController;
  TextEditingController textColorController ;
  TextEditingController iconColorController ;
  TextEditingController titleBorderColorController ;
  TextEditingController _useCtrlController ;
 // String iconColor = "";
  int iconColorInt = 0xff07426A;
  ColorPalleteBean clrpltBean;

  Color _mainColor = Colors.blue;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clrpltBean = new ColorPalleteBean();
    if(widget.passedColorPalleteObject!=null){
      if(widget.passedColorPalleteObject.appbar!=null){
        clrpltBean.appbar=widget.passedColorPalleteObject.appbar;
      }
    }else{
      if(globals.appbar!=null){
        clrpltBean.appbar=globals.appbar;
      }else{
        clrpltBean.appbar = Color(0xff07426A);
      }


      clrpltBean.chrttitleicon = Colors.black;
      if(globals.appbaricon!=null){
        clrpltBean.appbaricon=globals.appbaricon;
      }else{
        clrpltBean.appbaricon = Colors.white;
      }
      if(globals.appbartext!=null){
        clrpltBean.appbartext=globals.appbartext;
      }else{
        clrpltBean.appbartext = Colors.white;
      }
      if(globals.subappbar!=null){
        clrpltBean.subappbar=globals.subappbar;
      }else{
        clrpltBean.subappbar = Color(0xff07426A);
      }
      if(globals.subappbaricon!=null){
        clrpltBean.subappbaricon=globals.subappbaricon;
      }else{
        clrpltBean.subappbaricon = Colors.white;
      }
      if(globals.subappbartext!=null){
        clrpltBean.subappbartext=globals.subappbartext;
      }else{
        clrpltBean.subappbartext = Colors.white;
      }
      if(globals.chrttitle!=null){
        clrpltBean.chrttitle=globals.chrttitle;
      }else{
        clrpltBean.chrttitle = Colors.white;
      }
      if(globals.chrttitleborder!=null){
        clrpltBean.chrttitleborder=globals.chrttitleborder;
      }else{
        clrpltBean.chrttitleborder = Colors.yellow;
      }
      if(globals.chrtnavbtn!=null){
        clrpltBean.chrtnavbtn=globals.chrtnavbtn;
      }else{
        clrpltBean.chrtnavbtn = Colors.black;
      }
    }


    getSessionVariable();

//    chartTitleColorController = new TextEditingController();
//    textColorController = new TextEditingController();
//    iconColorController = new TextEditingController(text: iconColor );
//    titleBorderColorController = new TextEditingController();
//    _useCtrlController = new TextEditingController();

  }






  void getSessionVariable() async {
    if(widget.passedColorPalleteObject!=null){

      clrpltBean = widget.passedColorPalleteObject;
    }else{

//      AppDatabaseExtended.get().getMaxColorNumber().then((val) {
//        setState(() {
//          clrpltBean.trefno = val;
//        });
//
//      });


    }
    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: globals.appbaricon??Colors.white),
          onPressed: () {

            Navigator.of(context).pop();
          } ,
        ),
        title: new Text(
          "Color Pallete ",
          //'Saija Finance',
          style: new TextStyle(color: globals.appbartext??Colors.white,fontSize: 22.0),
        ),
        backgroundColor:  globals.appbar?? Color(0xff07426A),
        brightness: Brightness.light,
        elevation: 1.0,


      ),
      floatingActionButton: new FloatingActionButton(onPressed: ()async{

        print(clrpltBean.trefno);
        if(clrpltBean.trefno==null||clrpltBean.trefno==0){

          saveWithTextField("Name",context);
        }else{
          await AppDatabaseExtended.get().updateColorPalleteMaster(clrpltBean);
          success("Theme Saved Successfully",context);
        }


      },
      child: new Icon(Icons.save),
      ),




      body:  new SingleChildScrollView(
          child: new Column(
            children: <Widget>[


          new GestureDetector(
            onTap: (){
              _openFullMaterialColorPicker(1);

            },
            child: new Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween     ,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text("App Bar"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 31.5,
                  backgroundColor:Colors.black,
                  child: CircleAvatar(
                    foregroundColor: clrpltBean.appbar!=null?clrpltBean.appbar:Colors.white,
                    backgroundColor: clrpltBean.appbar!=null?clrpltBean.appbar:Colors.white,
                    radius: 30.0,

                    //child: const Text("MAIN"),
                  ),
                ),
              ),

            ],
            ),
          ),


              new GestureDetector(
                onTap: (){
                  _openFullMaterialColorPicker(2);

                },
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween     ,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text("App Bar Icon"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 31.5,
                        backgroundColor:Colors.black,
                        child: CircleAvatar(
                          foregroundColor: Colors.black87,
                          backgroundColor: clrpltBean.appbaricon!=null?clrpltBean.appbaricon:Colors.white,
                          radius: 30.0,


                          //child: const Text("MAIN"),
                        ),
                      ),
                    ),

                  ],
                ),
              ),


              new GestureDetector(
                onTap: (){
                  _openFullMaterialColorPicker(3);

                },
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween     ,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text("App Bar Text"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 31.5,
                        backgroundColor:Colors.black,
                        child: CircleAvatar(
                          foregroundColor: clrpltBean.appbartext!=null?clrpltBean.appbartext:Colors.white,
                          backgroundColor: clrpltBean.appbartext!=null?clrpltBean.appbartext:Colors.white,
                          radius: 30.0,

                          //child: const Text("MAIN"),
                        ),
                      ),
                    ),

                  ],
                ),
              ),


              new GestureDetector(
                onTap: (){
                  _openFullMaterialColorPicker(4);

                },
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween     ,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text("Sub App Bar"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 31.5,
                        backgroundColor:Colors.black,
                        child: CircleAvatar(

                          foregroundColor: clrpltBean.subappbar!=null?clrpltBean.subappbar:Colors.white,
                          backgroundColor: clrpltBean.subappbar!=null?clrpltBean.subappbar:Colors.white,
                          radius: 30.0,

                          //child: const Text("MAIN"),
                        ),
                      ),
                    ),

                  ],
                ),
              ),


              new GestureDetector(
                onTap: (){
                  _openFullMaterialColorPicker(5);

                },
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween     ,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  new Text("Sub App Bar Icon"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 31.5,
                        backgroundColor:Colors.black,
                        child: CircleAvatar(
                          foregroundColor: clrpltBean.subappbaricon!=null?clrpltBean.subappbaricon:Colors.white,
                          backgroundColor: clrpltBean.subappbaricon!=null?clrpltBean.subappbaricon:Colors.white,
                          radius: 30.0,

                          //child: const Text("MAIN"),
                        ),
                      ),
                    ),

                  ],
                ),
              ),


              new GestureDetector(
                onTap: (){
                  _openFullMaterialColorPicker(6);

                },
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween     ,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text("Sub App Bar Text"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 31.5,
                        backgroundColor:Colors.black,
                        child: CircleAvatar(
                          foregroundColor: clrpltBean.subappbartext!=null?clrpltBean.subappbartext:Colors.white,
                          backgroundColor: clrpltBean.subappbartext!=null?clrpltBean.subappbartext:Colors.white,
                          radius: 30.0,

                          //child: const Text("MAIN"),
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              new GestureDetector(
                onTap: (){
                  _openFullMaterialColorPicker(7);

                },
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween     ,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text("Chart Title"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 31.5,
                        backgroundColor:Colors.black,
                        child: CircleAvatar(
                          foregroundColor: clrpltBean.chrttitle!=null?clrpltBean.chrttitle:Colors.white,
                          backgroundColor: clrpltBean.chrttitle!=null?clrpltBean.chrttitle:Colors.white,
                          radius: 30.0,

                          //child: const Text("MAIN"),
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              new GestureDetector(
                onTap: (){
                  _openFullMaterialColorPicker(8);

                },
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween     ,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text("Chart Title Border"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 31.5,
                        backgroundColor:Colors.black,
                        child: CircleAvatar(
                          foregroundColor: clrpltBean.chrttitleborder!=null?clrpltBean.chrttitleborder:Colors.white,
                          backgroundColor: clrpltBean.chrttitleborder!=null?clrpltBean.chrttitleborder:Colors.white,
                          radius: 30.0,

                          //child: const Text("MAIN"),
                        ),
                      ),
                    ),

                  ],
                ),
              ),



              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Container(
                      padding: const EdgeInsets.only(left: 5.0, top: 20.0),
                      child: new RaisedButton(
                          child:  Text(
                            Translations.of(context).text('Apply'),
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async{

                            globals.sessionTimeOut=new SessionTimeOut(context: context);
                            globals.sessionTimeOut.SessionTimedOut();
                            //clrpltBean.appbar   = int.parse('0xD32F2F');
                            print(clrpltBean.appbar);

                            clrpltBean.misselected=1;
                            if(clrpltBean.trefno!=0&&clrpltBean.trefno!=null){
                              await AppDatabaseExtended.get().updateSelectedColor(clrpltBean.trefno);
                            }
                            Constant.loadColorPallete(clrpltBean);
                            setState(() {

                            });

                            success("Theme Applied Successfully",context);


                          })),



                  new Container(
                      padding:  EdgeInsets.only(left: 5.0, top: 20.0),
                      child: new RaisedButton(
                          child:  Text(
                            Translations.of(context).text('Reset'),
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {

                            globals.sessionTimeOut=new SessionTimeOut(context: context);
                            globals.sessionTimeOut.SessionTimedOut();
                             //clrpltBean.appbar   = int.parse('0xD32F2F');
                            clrpltBean.appbar = Color(0xff07426A);
                            clrpltBean.appbaricon = Colors.white;
                            clrpltBean.appbartext = Colors.white;
                            clrpltBean.subappbar = Color(0xff07426A);
                            clrpltBean.subappbaricon = Colors.white;
                            clrpltBean.subappbartext = Colors.white;
                            clrpltBean.chrttitle = Colors.black;
                            clrpltBean.chrttitleborder = Colors.yellow;
                            clrpltBean.chrtnavbtn  = Colors.black;
                            clrpltBean.chrttitleicon = Colors.black;

                            Constant.loadColorPallete(clrpltBean);

                            setState(() {

                            });

                            success("Reset to Default Successfull",context);



                          })),

                ],

              ),

            ],),



        ),


    );
  }

  void _openDialog(String title, Widget content,int hell) async {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            FlatButton(
              child: Text('CANCEL'),
              onPressed: (){

                Navigator.of(context).pop;
                return null;
              },

            ),
            FlatButton(
              child: Text('SUBMIT'),
              onPressed: () {


                switch (hell){
                  case(1):
                    //print(_mainColor);
                    clrpltBean.appbar = _mainColor;

                    //print(clrpltBean.appbar.toString());
                    setState(() {

                    });
                    break;
                  case(2):
                   // print(_mainColor);
                    clrpltBean.appbaricon = _mainColor;
                    //print(clrpltBean.appbar.toString());
                    setState(() {

                    });
                    break;
                  case(3):
                    //print(_mainColor);
                    clrpltBean.appbartext = _mainColor;
                   // print(clrpltBean.appbartext.toString());
                    setState(() {

                    });
                    break;
                  case(4):
                    //print(_mainColor);
                    clrpltBean.subappbar = _mainColor;
                   // print(clrpltBean.subappbar.toString());
                    setState(() {

                    });
                    break;
                  case(5):
                    //print(_mainColor);
                    clrpltBean.subappbaricon = _mainColor;
                    //print(clrpltBean.subappbaricon.toString());
                    setState(() {

                    });
                    break;
                  case(6):
                    //print(_mainColor);
                    clrpltBean.subappbartext = _mainColor;
                    //print(clrpltBean.subappbartext.toString());
                    setState(() {

                    });
                    break;
                  case(7):
                  //print(_mainColor);
                    clrpltBean.chrttitle = _mainColor;
                    //print(clrpltBean.subappbartext.toString());
                    setState(() {

                    });
                    break;
                  case(8):
                  //print(_mainColor);
                    clrpltBean.chrttitleborder = _mainColor;
                    //print(clrpltBean.subappbartext.toString());
                    setState(() {

                    });
                    break;

                  default:
                    break;


              }

              Navigator.of(context).pop();
              },
            ),
          ],
        );
      },

    );
  }

  void _openFullMaterialColorPicker(int hell) async {
     _openDialog(
      "Full Material Color picker",
      MaterialColorPicker(
        colors: fullMaterialColors,
        //selectedColor: _mainColor,
        onColorChange: (Color col){
          _mainColor = col ;
        },
        //onMainColorChange: (color) => setState(() => _tempMainColor = color),
      ),
      hell
    );
  }

  success(String message, BuildContext context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.offline_pin,
              color: Colors.green,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[Text(message)],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')),
                onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
                globals.sessionTimeOut.SessionTimedOut();
                Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }



  saveWithTextField(String message, BuildContext context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title:new Text(message),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Container(
                    width: 400.0,
                    child:new TextField(
                      decoration: InputDecoration(


                      ),

                      onChanged: (String val){
                        clrpltBean.mname= val;

                      },
                    )
                  )


                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')),
                onPressed: () async { globals.sessionTimeOut=new SessionTimeOut(context: context);
                globals.sessionTimeOut.SessionTimedOut();

                clrpltBean.trefno = await AppDatabaseExtended.get().updateColorPalleteMaster(clrpltBean);
                Navigator.of(context).pop();
                success("Theme Saved Successfully",context);


                },
              ),
            ],
          );
        });
  }


}



class ColorPalleteBean{
  Color   appbar  ;
  Color subappbar  ;
  Color appbaricon  ;
  Color subappbaricon  ;
  Color  appbartext  ;
  Color subappbartext  ;
  Color icon;
  Color chrtnavbtn;
  Color chrttitle;
  Color chrttitleborder;
  Color chrttitleicon;
  int trefno;
  int misselected  ;
  String mname  ;

  ColorPalleteBean({
      this.appbar,
      this.subappbar,
      this.appbaricon,
      this.subappbaricon,
      this.appbartext,
      this.subappbartext,
      this.icon,
      this.chrtnavbtn,
      this.chrttitle,
      this.chrttitleborder,
      this.trefno,
      this.misselected,
      this.mname,
    this.chrttitleicon
  });
  
  factory ColorPalleteBean.fromMap(Map<String ,dynamic>  map ){
    print("mapping ${map}" );
    return ColorPalleteBean(

    appbar: Color(map["appbar"]),
    subappbar:Color(map[ "subappbar"] ),
  appbaricon:Color(map["appbaricon" ] ) ,
  subappbaricon:Color(map["subappbaricon" ] ),
  appbartext:Color(map[ "appbartext"]   ),
  subappbartext:Color(map["subappbartext" ]  ),
  icon:Color(map[ "icon"]  ),
  chrtnavbtn:Color(map["chrtnavbtn" ]   ),
  chrttitle:Color(map["chrttitle" ]   ),
  chrttitleborder:Color(map["chrttitleborder" ]),
        trefno:map["trefno" ] as int,
      misselected:map["misselected" ] as int,
      mname: map["mname" ] as String,
        //chrttitleicon:Color(map["chrttitleicon" ]),
    
    
    
    );
    
  }

  @override
  String toString() {
    return 'ColorPalleteBean{appbar: $appbar, subappbar: $subappbar, appbaricon: $appbaricon, subappbaricon: $subappbaricon, appbartext: $appbartext, subappbartext: $subappbartext, icon: $icon, chrtnavbtn: $chrtnavbtn, chrttitle: $chrttitle, chrttitleborder: $chrttitleborder, chrttitleicon: $chrttitleicon, trefno: $trefno, misselected: $misselected, mname: $mname}';
  }
}
