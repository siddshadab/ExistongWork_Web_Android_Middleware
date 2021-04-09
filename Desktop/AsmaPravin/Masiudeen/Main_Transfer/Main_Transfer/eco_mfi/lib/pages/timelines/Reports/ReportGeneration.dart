import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/timelines/ChartsBean.dart';
import 'package:eco_mfi/pages/timelines/ReportUtils.dart';
import 'package:eco_mfi/pages/todo/home/WebViewTest.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportGeneration extends StatefulWidget {
  ReportGeneration({this.reportMasterList, this.chartBeanpassedObj, key})
      : super(key: key);
  final List<ReportMasterEntity> reportMasterList;
  ChartsBean chartBeanpassedObj;

  @override
  _ReportGenerationState createState() => _ReportGenerationState();
}

class _ReportGenerationState extends State<ReportGeneration> {
  List<Widget> widgetList;
  String _RadioButtons;
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Map<String, DateTime> dateMap;

  @override
  void initState() {
    // TODO: implement initState

    widgetList = new List<Widget>();
    _RadioButtons = TablesColumnFile.EXCEL;
    dateMap = new Map<String, DateTime>();

    super.initState();

    for (int i = 0; i < widget.reportMasterList.length; i++) {
      Widget temp =
          getWidget(widget.reportMasterList[i], widget.chartBeanpassedObj);
      if (temp != null) widgetList.add(temp);
    }
  }

  Widget getWidget(ReportMasterEntity repoEntity, ChartsBean chartBean) {
    DateTime date = DateTime.now();
    var func = (String val, String FieldName) {
      print("Replacing ${val}  from  $FieldName ");
      chartBean.mquery =
          chartBean.mquery.replaceFirst("#{" + FieldName + "}", val);
    };

    if (repoEntity.mfieldid == 1) return getTextField(repoEntity, func);
    if (repoEntity.mfieldid == 2) {
      try {
        date = DateTime.parse(repoEntity.mdefaultval);
      } catch (_) {
        date = DateTime.now();
      }
      dateMap[repoEntity.reportFilterComposite.mfieldname] = date;
      return getDateTimeField(repoEntity, func, date);
    }

    //else if (repoEntity.mfieldid == 3) return getRadioButtons(repoEntity);
  }

  Widget getDateTimeField(ReportMasterEntity repo, func, DateTime defaultdate) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(repo.mdisplay),
          DateTimeField(
            format: TablesColumnFile.format,
            initialValue: defaultdate,
            onShowPicker: (context, currentValue) {
              return showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: defaultdate,
                  lastDate: DateTime.now());
            },
            onChanged: (DateTime val) {
              if (val != null) {
                dateMap[repo.reportFilterComposite.mfieldname] = val;
              }
            },
          ),
        ],
      )),
    );
  }

  Widget getTextField(ReportMasterEntity repo, func) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new TextFormField(
        onSaved: (String val) {
          func(val, repo.reportFilterComposite.mfieldname);
        },
        initialValue: repo.mdefaultval,
        decoration:
            InputDecoration(labelText: repo.mdisplay, hintText: repo.mdisplay),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: new Text("Reports Tab"),
      ),
      body: new SingleChildScrollView(
        child: new Form(
          key: _formKey,
          child: new Column(
            children: <Widget>[
              RadioListTile<String>(
                title: const Text("PDF"),
                value: TablesColumnFile.PDF,
                groupValue: _RadioButtons,
                onChanged: (String value) {
                  setState(() {
                    print("Setting Radio Button to PDF");
                    _RadioButtons = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text("EXCEL (Download)"),
                value: TablesColumnFile.EXCEL,
                groupValue: _RadioButtons,
                onChanged: (String value) {
                  print("Setting Radio Button to PDF");
                  setState(() {
                    _RadioButtons = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('HTML'),
                value: TablesColumnFile.HTML,
                groupValue: _RadioButtons,
                onChanged: (String value) {
                  setState(() {
                    print("Setting Radio Button to PDF");
                    _RadioButtons = value;
                  });
                },
              ),
              new Column(children: widgetList),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: new Container(
                  child: new RaisedButton(
                    onPressed: () async {
                      final FormState form = _formKey.currentState;
                      form.save();
                      //print("Replacing #{FORMAT}  from  $_RadioButtons ");
                      widget.chartBeanpassedObj.mquery = widget
                          .chartBeanpassedObj.mquery
                          .replaceFirst("#{FORMAT}", _RadioButtons);
                      // print(chartBeanObj.mquery);

                      print(dateMap);
                      dateMap.forEach((String val, DateTime date) {
                        widget.chartBeanpassedObj.mquery =
                            widget.chartBeanpassedObj.mquery.replaceFirst(
                                "#{" + val + "}",
                                TablesColumnFile.secondFormat.format(date));
                      });

                      print(widget.chartBeanpassedObj.mquery);

                      if (_RadioButtons == TablesColumnFile.HTML) {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => webViewTester(
                                    url: widget.chartBeanpassedObj.mquery,
                                    title: widget.chartBeanpassedObj.mtitle)));
                      } else {
                        await launch(widget.chartBeanpassedObj.mquery);
                      }
                    },
                    child: const Text(
                      "Generate",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
