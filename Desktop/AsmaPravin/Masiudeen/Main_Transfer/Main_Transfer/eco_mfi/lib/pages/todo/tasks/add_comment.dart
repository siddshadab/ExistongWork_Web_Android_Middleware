import 'dart:async';

import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';

class AddCommentDialog extends StatefulWidget {
  @override
  _AddCommentDialogState createState() => new _AddCommentDialogState();
}

class _AddCommentDialogState extends State<AddCommentDialog> {
  @override
  Widget build(BuildContext context) {
    return new Container();
  }
}

Future<String> showCommentDialog(BuildContext context) async {
  return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          content: new TextField(),
          actions: <Widget>[
            new FlatButton(
                 onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                  Navigator.pop(context, "");
                },
                child: new Text("CANCEL",
                    style:
                        new TextStyle(color: Theme.of(context).accentColor))),
            new FlatButton(
                 onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();},
                child: new Text("SAVE",
                    style: new TextStyle(color: Theme.of(context).accentColor)))
          ],
        );
      });
}
