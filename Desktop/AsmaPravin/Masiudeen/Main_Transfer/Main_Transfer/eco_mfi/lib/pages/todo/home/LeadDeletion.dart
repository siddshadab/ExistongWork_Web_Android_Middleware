import 'dart:io';

import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/AppdatabaseExtended.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CGT1Bean.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CGT2Bean.dart';
import 'package:eco_mfi/pages/workflow/GRT/bean/GRTBean.dart';
import 'package:eco_mfi/pages/workflow/Guarantor/GuarantorDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanCPVBusinessRecordBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanImageBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';

class LeadDeletion extends StatefulWidget {
  static int count = 1;
  @override
  _LeadDeletionState createState() => _LeadDeletionState();
}

class _LeadDeletionState extends State<LeadDeletion> {
  List<CustomerLoanDetailsBean> items = new List<CustomerLoanDetailsBean>();
  List<CustomerLoanDetailsBean> storedItems =
      new List<CustomerLoanDetailsBean>();
  int count2 = 1;

  @override
  Widget build(BuildContext context) {
    var loanDetailsBuilder;
    if (count2 == 1) {
      count2++;
      try {
        loanDetailsBuilder = new FutureBuilder(
            future: AppDatabaseExtended.get()
                .getCustomerLoanDetailsToDelete()
                .then((List<CustomerLoanDetailsBean> loanDetailsList) {
              items = new List<CustomerLoanDetailsBean>();
              storedItems = new List<CustomerLoanDetailsBean>();
              loanDetailsList.forEach((val) async {
                await AppDatabase.get()
                    .getCustomerByTrefAndMref(val.mcusttrefno, val.mcustmrefno)
                    .then((CustomerListBean custObj) {
                  if (custObj != null) {
                    val.isChecked = true;
                    val.mgroupcd = custObj.mgroupcd;
                    val.mcenterid = custObj.mcenterid;
                    val.mcustname = custObj.mlongname;
                  }
                  setState(() {});
                });
              });

              setState(() {});
              return items;
            }),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return new Text('loading...');

                default:
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  else
                    return getHomePageBody(context, snapshot);
              }
            });
      } catch (e) {
        loanDetailsBuilder = new Text("Nothing To display");
      }
    } else if (items != null) {
      loanDetailsBuilder = ListView.builder(
        itemCount: items.length,
        itemBuilder: _getItemUI,
        padding: EdgeInsets.all(0.0),
      );
    } else
      loanDetailsBuilder = new Text("nothing to display");

    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: new Text("Clear Leads"),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                _ShowProgressInd(context);
                await deleteLeads();
                Navigator.of(context).pop();
                setState(() {
                  count2 = 1;
                });
              })
        ],
      ),
      body: new Container(
        //color: const Color(0xff07426A),
        child: loanDetailsBuilder,
      ),
    );
  }

  Future<void> _ShowProgressInd(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translations.of(context).text('Please_Wait')),
          content:
              SingleChildScrollView(child: SpinKitCircle(color: Colors.teal)),
        );
      },
    );
  }

  getHomePageBody(BuildContext context, AsyncSnapshot snapshot) async {
    if (snapshot.data != null) {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: _getItemUI,
        padding: EdgeInsets.all(0.0),
      );
    }
  }

  Widget _getItemUI(BuildContext context, int index) {
    return new CheckboxListTile(
      value: items[index].isChecked,
      onChanged: (bool val) {
        setState(() {
          items[index].isChecked = val;
        });
      },
      title: new Text(items[index].mcustname),
      subtitle: new Text(items[index].trefno.toString()),
    );
  }

  Future<Null> deleteLeads() async {
    var file;
    String query = "";
    for (int i = 0; i < items.length; i++) {
      if (items[i].isChecked == true) {
        try {
          //DELETING TRADE NEIGHBOUR
          query =
          "DELETE FROM ${AppDatabase
              .tradeNeighbourRefCheckMaster} WHERE ${TablesColumnFile
              .mloantrefno} = ${items[i].trefno} "
              " AND ${TablesColumnFile.mloanmrefno}  = ${items[i].mrefno} ";
          await AppDatabase.get().UpdateByQuery(query);
        }catch(_){

        }

        //DELETING DAVIATION
        try{
        query =
            "DELETE FROM ${AppDatabase.deviationFormMaster} WHERE ${TablesColumnFile.mloantrefno} = ${items[i].trefno} "
            " AND ${TablesColumnFile.mloanmrefno}  = ${items[i].mrefno} ";
        await AppDatabase.get().UpdateByQuery(query);
        }catch(_){

        }

        //DELETING SOCIAL ENVIRONMENTAL
        try{
        query =
            "DELETE FROM ${AppDatabase.socialEnvironmentMaster} WHERE ${TablesColumnFile.mloantrefno} = ${items[i].trefno} "
            " AND ${TablesColumnFile.mloanmrefno}  = ${items[i].mrefno} ";
        await AppDatabase.get().UpdateByQuery(query);
        }catch(_){

        }

        //DELETING LOAN CPV
        try{
        await AppDatabase.get()
            .selectCPVTrefLoanmerefno(items[i].trefno, items[i].mrefno, false)
            .then((CustomerLoanCPVBusinessRecordBean cpvObj) async {
          if (cpvObj != null) {
            if (cpvObj.mbusinesslicense != null &&
                cpvObj.mbusinesslicense.trim != '') {
              try {
                file = File(cpvObj.mbusinesslicense.trim());
                await file.delete();
              } catch (_) {}
            }
            if (cpvObj.mpremisesphoto != null &&
                cpvObj.mpremisesphoto.trim() != 'null' &&
                cpvObj.mpremisesphoto.trim() != '') {
              try {
                file = File(cpvObj.mpremisesphoto.trim());
                await file.delete();
              } catch (_) {}
            }
            if (cpvObj.mpremisesphotosec != null &&
                cpvObj.mpremisesphotosec.trim() != 'null' &&
                cpvObj.mpremisesphotosec.trim() != '') {
              try {
                file = File(cpvObj.mpremisesphotosec.trim());
                await file.delete();
              } catch (_) {}
            }
            if (cpvObj.mpremisesphotothird != null &&
                cpvObj.mpremisesphotothird.trim() != 'null' &&
                cpvObj.mpremisesphotothird.trim() != '') {
              try {
                file = File(cpvObj.mpremisesphotothird.trim());
                await file.delete();
              } catch (_) {}
            }
          }
        });
        query =
            "DELETE FROM ${AppDatabase.LoanCPVBusinessRecord} WHERE ${TablesColumnFile.mloantrefno} = ${items[i].trefno} "
            " AND ${TablesColumnFile.mloanmrefno}  = ${items[i].mrefno} ";
        await AppDatabase.get().UpdateByQuery(query);
        }catch(_){

        }

        //DELETING LOAN CASHFLOW
        try{
        query =
            "DELETE FROM ${AppDatabase.CosutomerLoanCashFlowMaster} WHERE ${TablesColumnFile.mloantrefno} = ${items[i].trefno} "
            " AND ${TablesColumnFile.mloanmrefno}  = ${items[i].mrefno} ";
        await AppDatabase.get().UpdateByQuery(query);
        }catch(_){

        }

        //DELETING KYC MASTER
        try{
        query =
            "DELETE FROM ${AppDatabase.kycMaster} WHERE ${TablesColumnFile.mloantrefno} = ${items[i].trefno} "
            " AND ${TablesColumnFile.mloanmrefno}  = ${items[i].mrefno} ";
        await AppDatabase.get().UpdateByQuery(query);
        }catch(_){

        }

        try{
        await AppDatabase.get()
            .selectGuarantorListObjOnTrefLoanmerefno(
                items[i].trefno, items[i].mrefno, false)
            .then((List<GuarantorDetailsBean> val) async {
          val.forEach((GuarantorDetailsBean guarantorobj) async {
            if (guarantorobj.mfacecapture != null &&
                guarantorobj.mfacecapture != '') {
              try {
                var file = File(guarantorobj.mfacecapture.trim());
                await file.delete();
              } catch (_) {}
            } else if (guarantorobj.mnrcphoto != null &&
                guarantorobj.mnrcphoto != '') {
              try {
                file = File(guarantorobj.mnrcphoto.trim());
                await file.delete();
              } catch (_) {}
            } else if (guarantorobj.mnrcsecphoto != null &&
                guarantorobj.mnrcsecphoto != '') {
              try {
                file = File(guarantorobj.mnrcsecphoto.trim());
                await file.delete();
              } catch (_) {}
            } else if (guarantorobj.mnrcsecphoto != null &&
                guarantorobj.mnrcsecphoto != '') {
              try {
                file = File(guarantorobj.mnrcsecphoto.trim());
                await file.delete();
              } catch (_) {}
            }
            if (guarantorobj.mhouseholdsecphoto != null &&
                guarantorobj.mhouseholdsecphoto != '') {
              try {
                file = File(guarantorobj.mhouseholdsecphoto.trim());
                await file.delete();
              } catch (_) {}
            }
            if (guarantorobj.maddressphoto != null &&
                guarantorobj.maddressphoto != '') {
              try {
                file = File(guarantorobj.maddressphoto.trim());
                await file.delete();
              } catch (_) {}
            }
          });
        });

        query =
            "DELETE FROM ${AppDatabase.gaurantorMaster} WHERE ${TablesColumnFile.mloantrefno} = ${items[i].trefno} "
            " AND ${TablesColumnFile.mloanmrefno}  = ${items[i].mrefno} ";
        await AppDatabase.get().UpdateByQuery(query);
        }catch(_){

        }

        //DELETING LOAN  IMAGES FROM TABLET
        try{
        await AppDatabase.get()
            .getCustomerLoanImage(items[i].mrefno, items[i].trefno)
            .then((List<CustomerLoanImageBean> onValue) async {
          for (CustomerLoanImageBean items in onValue) {
            if (items.mimagestring != null && items.mimagestring != '') {
              print(items.mimagestring);
              try {
                file = File(items.mimagestring.trim());
                await file.delete();
              } catch (_) {}
            }
          }

          //DELETING ALL LOAN IMAGE DATA
          query =
              "DELETE FROM ${AppDatabase.customerLoanImageMaster} WHERE ${TablesColumnFile.mloantrefno} = ${items[i].trefno} "
              " AND ${TablesColumnFile.mloanmrefno}  = ${items[i].mrefno} ";
          await AppDatabase.get().UpdateByQuery(query);
        });
        }catch(_){

        }

        //CGT1 DELETE
        try{
        if (items[i].mleadstatus > 1) {

          await AppDatabase.get()
              .getCustomerCGT1Details(items[i].mrefno, items[i].trefno)
              .then((List<CGT1Bean> onValue) async {
            for (CGT1Bean cgt1Bean in onValue) {
              query =
                  "DELETE FROM ${AppDatabase.cgt1QaMaster} WHERE ${TablesColumnFile.trefno} = ${cgt1Bean.trefno} "
                  " AND ${TablesColumnFile.mrefno}  = ${cgt1Bean.mrefno} ";
              await AppDatabase.get().UpdateByQuery(query);
            }

            query =
                "DELETE FROM ${AppDatabase.CGT1Master} WHERE ${TablesColumnFile.mloantrefno} = ${items[i].trefno} "
                " AND ${TablesColumnFile.mloanmrefno}  = ${items[i].mrefno} ";
            await AppDatabase.get().UpdateByQuery(query);
          });


          //CGT2 DELETE
          if (items[i].mleadstatus > 5) {
            await AppDatabase.get()
                .getCustomerCGT2Details(items[i].mrefno, items[i].trefno)
                .then((List<CGT2Bean> onValue) async {
              for (CGT2Bean cgt2Bean in onValue) {
                query =
                    "DELETE FROM ${AppDatabase.cgt2QaMaster} WHERE ${TablesColumnFile.trefno} = ${cgt2Bean.trefno} "
                    " AND ${TablesColumnFile.mrefno}  = ${cgt2Bean.mrefno} ";
                await AppDatabase.get().UpdateByQuery(query);
              }
              query =
                  "DELETE FROM ${AppDatabase.CGT2Master} WHERE ${TablesColumnFile.mloantrefno} = ${items[i].trefno} "
                  " AND ${TablesColumnFile.mloanmrefno}  = ${items[i].mrefno} ";
              await AppDatabase.get().UpdateByQuery(query);
            });

            ////GRT DELETE
            if (items[i].mleadstatus > 6) {
              await AppDatabase.get()
                  .getCustomerGRTDetails(items[i].mrefno, items[i].trefno)
                  .then((List<GRTBean> onValue) async {
                for (GRTBean grtBean in onValue) {
                  query =
                      "DELETE FROM ${AppDatabase.grtQaMaster} WHERE ${TablesColumnFile.trefno} = ${grtBean.trefno} "
                      " AND ${TablesColumnFile.mrefno}  = ${grtBean.mrefno} ";
                  await AppDatabase.get().UpdateByQuery(query);
                }

                query =
                    "DELETE FROM ${AppDatabase.GRTMaster} WHERE ${TablesColumnFile.mloantrefno} = ${items[i].trefno} "
                    " AND ${TablesColumnFile.mloanmrefno}  = ${items[i].mrefno} ";
                await AppDatabase.get().UpdateByQuery(query);
              });
            }
          }
        }
        }catch(_){

        }
        try{
        query =
            "DELETE FROM ${AppDatabase.customerLoanDetailsMaster} WHERE ${TablesColumnFile.trefno} = ${items[i].trefno} "
            " AND ${TablesColumnFile.mrefno}  = ${items[i].mrefno} ";
        await AppDatabase.get().UpdateByQuery(query);
        }catch(_){

        }
      }
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print('path ${path}');
    return File('$path/counter.txt');
  }

  Future<int> deleteFile() async {
    try {
      final file = await _localFile;

      await file.delete();
    } catch (e) {
      return 0;
    }
  }
}
