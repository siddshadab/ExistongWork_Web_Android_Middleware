import 'package:eco_mfi/pages/workflow/customerFormation/bean/CIFLoanPaymentHistoryBean.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/translations.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewCIFLoanPaymentHistory extends StatefulWidget {
  final List<CIFLoanPaymentHistoryBean> cifLoanPaymentHistoryBean;
  String mprdaccid;
  ViewCIFLoanPaymentHistory(this.cifLoanPaymentHistoryBean , this.mprdaccid);

  @override
  _ViewCIFLoanPaymentHistory createState() =>
      _ViewCIFLoanPaymentHistory();
}

class _ViewCIFLoanPaymentHistory
    extends State<ViewCIFLoanPaymentHistory> {
   List<CIFLoanPaymentHistoryBean> cifLoanPaymentHistoryList=new List<CIFLoanPaymentHistoryBean>();
   List<int> selectedIndex = new List<int>();
   final dateFormat = DateFormat("yyyy/MM/dd hh:mm:ss");
   SharedPreferences prefs;
   var rows2;
   var cols2;
   List<String> repaySchList ;

  @override
  void initState() {
    super.initState();
    List columnName = [
      'Payment Date',
      'Ideal Repay Date',
      'Instl No',
      'Activity',
      'Inst Amt',
      'Principal Recovered',
      'Interset Recovered',
      'Total Outstanding',
      'Narration'
    ];

    print("cifLoanPaymentHistoryBean"+widget.cifLoanPaymentHistoryBean.toString());
    if(widget.cifLoanPaymentHistoryBean!=null){
      cifLoanPaymentHistoryList =widget.cifLoanPaymentHistoryBean;
    }
    getRow();
    cols2 = [
      new DataColumn(
        label:  Text('Payment Date'),
      ),
      new DataColumn(
        label:  Text('Ideal Repay Date'),
      ),
      new DataColumn(
        label:  Text('Instl No'),
      ),
      new DataColumn(
        label: Text('Activity'),
      ),
      new DataColumn(
        label: Text('Inst Amt'),
      ),
      new DataColumn(
      label: Text('Principal Recovered'),
      ),
      new DataColumn(
      label: Text('Interset Recovered'),
      ),
      new DataColumn(
        label: Text('Total Outstanding'),
      ),
      new DataColumn(
        label: Text('Narration'),
      )
    ];
  }
  void getRow(){
    rows2 = new List.generate(
        cifLoanPaymentHistoryList.length,
            (int a) => new DataRow(
            cells: [
              new DataCell(
                  new Text(cifLoanPaymentHistoryList[a].mdtOfPayment==null||cifLoanPaymentHistoryList[a].mdtOfPayment.toString()=="null"?""
                      :cifLoanPaymentHistoryList[a].mdtOfPayment.substring(0, 4).toString()+"-"+
                       cifLoanPaymentHistoryList[a].mdtOfPayment.substring(4, 6).toString()+"-"+
                       cifLoanPaymentHistoryList[a].mdtOfPayment.substring(6, 8).toString())),
              new DataCell(
                  new Text(cifLoanPaymentHistoryList[a].mdtIdealrePayment==null||cifLoanPaymentHistoryList[a].mdtIdealrePayment.toString()=="null"?""
                      :cifLoanPaymentHistoryList[a].mdtIdealrePayment.substring(0, 4).toString()+"-"+
                      cifLoanPaymentHistoryList[a].mdtIdealrePayment.substring(4, 6).toString()+"-"+
                      cifLoanPaymentHistoryList[a].mdtIdealrePayment.substring(6, 8).toString())),
              new DataCell(
                  new Text(cifLoanPaymentHistoryList[a].minstNumber==null||cifLoanPaymentHistoryList[a].minstNumber.toString()=="null"?""
                      :cifLoanPaymentHistoryList[a].minstNumber.toString())),
              new DataCell(
                  new Text(cifLoanPaymentHistoryList[a].mtype==null||cifLoanPaymentHistoryList[a].mtype.toString()=="null"?""
                      :cifLoanPaymentHistoryList[a].mtype.toString())),
              new DataCell(
                  new Text(cifLoanPaymentHistoryList[a].minstAmt==null||cifLoanPaymentHistoryList[a].minstAmt.toString()=="null"?"":
                  cifLoanPaymentHistoryList[a].minstAmt.toString()
                  )),
              new DataCell(
                  new Text(cifLoanPaymentHistoryList[a].mprincRecvd==null||cifLoanPaymentHistoryList[a].mprincRecvd=="null"?"":
                  cifLoanPaymentHistoryList[a].mprincRecvd.toString()
                  )),
              new DataCell(
                  new Text(cifLoanPaymentHistoryList[a].mintRecvd==null||cifLoanPaymentHistoryList[a].mintRecvd=="null"?"":
                  cifLoanPaymentHistoryList[a].mintRecvd.toString()
                  )),
              new DataCell(
                  new Text(cifLoanPaymentHistoryList[a].mprincOutstand==null||cifLoanPaymentHistoryList[a].mprincOutstand=="null"?"":
                  cifLoanPaymentHistoryList[a].mprincOutstand.toString()
                  )),
              new DataCell(
                  new Text(cifLoanPaymentHistoryList[a].mnarration==null||cifLoanPaymentHistoryList[a].mnarration=="null"?"":
                  cifLoanPaymentHistoryList[a].mnarration.toString()
                  )),
            ]));

  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: new AppBar(
          elevation: 3.0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {Navigator.of(context).pop(),Navigator.of(context).pop()}
          ),
          backgroundColor: Color(0xff07426A),
          brightness: Brightness.light,
          title:
            new Text(Translations.of(context).text('Loan Payment History'),
           // textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: ListView(padding: EdgeInsets.all(20.0), children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    new Text("PrdAccId : "+widget.mprdaccid.substring(0, 8).toString()+"/"+
                        int.parse(widget.mprdaccid.substring(8, 16)).toString()+"/"+
                        int.parse(widget.mprdaccid.substring(16, 24)).toString()
                      , style: new TextStyle(
                        color: Color(0xff07426A),
                        fontSize: 20.0,
                      ), )
                  ],
                ),
                new Row(
                  children: <Widget>[
                  Container(
                  //height: 1000.0,
                  child: DataTable(
                    rows: rows2,
                    columns: cols2,
                  ),
                ),
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}