import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/translations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class LoanSumulator extends StatefulWidget {
  final List<loanSimulatorEntity> passedLoanSimulatorList;
  final leadsId;

  LoanSumulator({Key key, this.passedLoanSimulatorList, this.leadsId})
      : super(key: key);

  @override
  _LoanSumulatorState createState() => _LoanSumulatorState();
}

class _LoanSumulatorState extends State<LoanSumulator> {
  //List<CIFRepayScheduleBean> cifRepayScheduleList=new List<CIFRepayScheduleBean>();
  List<int> selectedIndex = new List<int>();
  final dateFormat = DateFormat("yyyy/MM/dd hh:mm:ss");
  SharedPreferences prefs;
  var rows2;
  var cols2;
  List<String> repaySchList;

  @override
  void initState() {
    super.initState();
    List columnName = [
      'SrNo',
      'Date',
      'Principal',
      'Interest',
      'Installment',
      'Balance',
    ];

//    print("cifRepayScheduleBean"+widget.cifRepayScheduleBean.toString());
//    if(widget.cifRepayScheduleBean!=null){
//      cifRepayScheduleList =widget.cifRepayScheduleBean;
//    }
//
//    if (widget.cifRepayScheduleBean != null && widget.cifRepayScheduleBean.isNotEmpty) {
//      repaySchList = new List<String>();
//      for (int l = 0; l < cifRepayScheduleList.length; l++) {
//        double minstallment = cifRepayScheduleList[l].mwseffcontractamt + cifRepayScheduleList[l].mwsintamount;
//        repaySchList.add(minstallment.toString());
//      }
//    }
    getRow();
    cols2 = [
      new DataColumn(
        label: Text('SrNo'),
      ),
      new DataColumn(
        label: Text('Ideal Bal Date'),
      ),
      new DataColumn(
        label: Text('Principal'),
      ),
      new DataColumn(
        label: Text('Interest'),
      ),
      new DataColumn(
        label: Text('Installment'),
      ),
      new DataColumn(
        label: Text('Balance'),
      )
    ];
  }

  void getRow() {
    rows2 = new List.generate(
        widget.passedLoanSimulatorList.length,
        (int a) => new DataRow(cells: [
              new DataCell(new Text(
                  widget.passedLoanSimulatorList[a].srno == null ||
                          widget.passedLoanSimulatorList[a].srno.toString() ==
                              "null"
                      ? ""
                      : widget.passedLoanSimulatorList[a].srno.toString())),
              new DataCell(new Text(
                  widget.passedLoanSimulatorList[a].idealbaldate == null
                      ? ""
                      : widget.passedLoanSimulatorList[a].idealbaldate
                          .toString())),
              new DataCell(new Text(
                  widget.passedLoanSimulatorList[a].principle == null
                      ? ""
                      : widget.passedLoanSimulatorList[a].principle
                          .toString())),
              new DataCell(new Text(
                  widget.passedLoanSimulatorList[a].interest == null
                      ? ""
                      : widget.passedLoanSimulatorList[a].interest.toString())),
              new DataCell(new Text(
                  widget.passedLoanSimulatorList[a].installment == null
                      ? ""
                      : widget.passedLoanSimulatorList[a].installment
                          .toString())),
              new DataCell(new Text(
                  widget.passedLoanSimulatorList[a].balance == null ||
                          widget.passedLoanSimulatorList[a].balance == "null"
                      ? ""
                      : widget.passedLoanSimulatorList[a].balance.toString())),
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: new AppBar(
          elevation: 3.0,
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () =>
                  {Navigator.of(context).pop(), Navigator.of(context).pop()}),
          backgroundColor: Color(0xff07426A),
          brightness: Brightness.light,
          title: new Text(
            Translations.of(context).text('Repayment_Schedule'),
            // textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    new Text(
                      "Leads Id  : " + widget.leadsId,
                      style: new TextStyle(
                        color: Color(0xff07426A),
                        fontSize: 20.0,
                      ),
                    )
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
        ),
      ),
    );
  }
}

class loanSimulatorEntity {
  int srno;
  DateTime idealbaldate;
  double principle;
  double interest;
  double installment;
  double balance;
  int missynctocoresys;
  String merrormessage;

  loanSimulatorEntity(
      {this.srno,
      this.idealbaldate,
      this.principle,
      this.interest,
      this.installment,
      this.balance,
      this.missynctocoresys,
      this.merrormessage});

  @override
  String toString() {
    return 'loanSimulatorEntity{srno: $srno, idealbaldate: $idealbaldate, principle: $principle, interest: $interest, installment: $installment, balance: $balance, missynctocoresys: $missynctocoresys, merrormessage: $merrormessage}';
  }

  factory loanSimulatorEntity.fromMap(Map<String, dynamic> map) {
    return loanSimulatorEntity(
        srno: map[TablesColumnFile.srno] as int,
        idealbaldate: (map[TablesColumnFile.idealbaldate] == "null" ||
                map[TablesColumnFile.idealbaldate] == null)
            ? null
            : DateTime.parse(map[TablesColumnFile.idealbaldate]) as DateTime,
        principle: map[TablesColumnFile.principle] as double,
        interest: map[TablesColumnFile.interest] as double,
        installment: map[TablesColumnFile.installment] as double,
        balance: map[TablesColumnFile.balance] as double,
        missynctocoresys: map[TablesColumnFile.missynctocoresys] as int,
        merrormessage: map[TablesColumnFile.merrormessage] as String);
  }
}
