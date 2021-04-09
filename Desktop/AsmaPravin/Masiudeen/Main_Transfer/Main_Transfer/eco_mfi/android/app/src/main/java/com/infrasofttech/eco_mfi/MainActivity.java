package com.infrasofttech.eco_mfi;

import android.app.ProgressDialog;
import android.bluetooth.BluetoothAdapter;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.os.SystemClock;
import android.util.Base64;
import android.util.Log;
import android.view.ViewTreeObserver;
import android.view.WindowManager;
import android.widget.Toast;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import com.evolute.textimage.TextGenerator;
import com.leopard.api.FPS;
import com.leopard.api.FpsConfig;
import com.leopard.api.FpsImageAPI;
import com.leopard.api.Printer;
import com.leopard.api.Setup;

import com.evolute.qrimage.QRCodeGenerator;


import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;


import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;


public class MainActivity extends FlutterActivity implements TaskCompleted {
    private static final String CHANNEL = "com.infrasofttech.eco_mfi";
    private byte[] bufvalue = {};
    FpsConfig fpsconfig = new FpsConfig();
    String base64encoded = null, base64decoded;
    String encodedStringforVerification = null;
    String encodedStringforConversion = null;
    private String iRetVal;
    public static final int DEVICE_NOTCONNECTED = -100;
    private static final int NO_ERROR = 0;
    public static final int TIME_OUT = -2;
    public static Setup setupInstance = null;
    public BluetoothComm mBTcomm = null;
    public static BluetoothAdapter mBT = BluetoothAdapter.getDefaultAdapter();
    private boolean mbBleStatusBefore = false;
    public static Printer ptr;
    private static ProgressDialog dlgPg;
    public boolean firstTimePrint;
    SharedPreferences appPref;
    SharedPreferences prefs;
    byte[] decodeServerData = null;
    int iRetValRes;
    String retVal;
    ///*for printing*/ TestPrintTask testprint = null;
    FPS fps;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.d("onCreate:: ", " called");
        getWindow().setStatusBarColor(0x00000000);
        GeneratedPluginRegistrant.registerWith(this);
        /**
         *
         */
        try {

            //Toast.makeText(MainActivity.this, "getting context !!!!!!", Toast.LENGTH_SHORT).show();
            setupInstance = new Setup();
            InputStream inputStream = getResources().openRawResource(R.raw.licence_nodlg);
            boolean activate = setupInstance.blActivateLibrary(MainActivity.this, inputStream);
            if (activate) {
                Log.d("DiscoverBT", "Leopard Library Activated......");
            } else if (!activate) {
                Log.d("DiscoverBT", "Leopard Library Not Activated...");
            }


        } catch (Exception e) {
            e.printStackTrace();


        }

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, Result result) {
                        base64encoded = null;
                        encodedStringforVerification = null;
                        encodedStringforConversion = null;
                        mBTcomm = null;
                        // TODO
                        Log.d("onMethodCall:: ", call.method);
                        /**
                         * @implNote
                         * "callValue" used for specific print call
                         * " 1 "  for MINISTATEMENT
                         *
                         * " 2 "  for CENTER SAVING COLLECTION
                         * " 3 "  for GROUP SAVING  COLLECTION
                         * " 4 "  for CUSTOMER SAVING  COLLECTION
                         * " 5 "  for TODAY'S SAVING  COLLECTION
                         *
                         * " 6 "  for WITHDRAWAL OR DEPOSIT PRINT
                         *
                         * " 7 "  for CENTER LOAN COLLECTION
                         * " 8 "  for GROUP LOAN  COLLECTION
                         * " 9 "  for CUSTOMER LOAN  COLLECTION
                         * " 10 "  for TODAY'S LOAN  COLLECTION
                         * " 11 "  for INDIVIDUAL LOAN  CLOSURE
                         * " 12 "  for GROUP LOAN  CLOSURE
                         * " 13 "  for LOAN DISBURSTMENT
                         * " 14 "  for GROUP AND INDIVIDUAL SAVING COLLECTION RECEIPT (MINI REPORTS)
                         * " 15 "  for GROUP AND INDIVIDUAL LOAN COLLECTION RECEIPT (MINI REPORTS)
                         * " 16 "  for TRANSACTIONS SUMMARY RECEIPT FORMAT (MINI REPORTS)

                         */
                        if (call.method.equalsIgnoreCase("ministatementPrint")) { // Calling for printing value for MINISTATEMENT
                            String mBluetoothAdd = call.argument("BluetoothADD");
                            String mlbrcode = call.argument("mlbrcode");
                            String mbramchname = call.argument("mbramchname");
                            String date = call.argument("date");
                            String prdAccId = call.argument("prdAccId");
                            String mlongname = call.argument("mlongname");
                            String macttotballcy = call.argument("macttotballcy");
                            String repeatedStringEntryDate = call.argument("repeatedStringEntryDate");
                            String repeatedStringAmount = call.argument("repeatedStringAmount");
                            String repeatedStringDrCr = call.argument("repeatedStringDrCr");
                            String repeatedStringRemarks = call.argument("repeatedStringRemarks");
                            String header = call.argument("header");

                            PrintingParams printingParams = new PrintingParams(1, mBluetoothAdd, mlbrcode, mbramchname, date, prdAccId, mlongname, macttotballcy,
                                    repeatedStringEntryDate, repeatedStringAmount, repeatedStringDrCr, repeatedStringRemarks,
                                    "", "", "", "", "", "",header);
                            PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                            printAsync.execute(printingParams);

                        } else if (call.method.equalsIgnoreCase("svngcollcenterprint")) {  // Calling for printing value for CENTER SAVING COLLECTION
                            String mBluetoothAdd = call.argument("BluetoothADD");
                            String mlbrcode = call.argument("mlbrcode");
                            String date = call.argument("date");
                            String mcenterid = call.argument("mcenterid");
                            String repeatedStringAmount = call.argument("repeatedStringAmount");
                            String repeatedStringprdAccId = call.argument("repeatedStringprdAccId");
                            String repeatedStringEntryDate = call.argument("repeatedStringEntryDate");
                            String projectName = call.argument("company");

                            String trefno = call.argument("trefno");
                            String repeatedStringCustomerNumber = call.argument("repeatedStringCustomerNumber");
                            String branchName = call.argument("branchName");
                            String centerName = call.argument("centerName");
                            String total = call.argument("total");
                            String userName = call.argument("username");
                            String header = call.argument("header");

                            PrintingParams printingParams = new PrintingParams(2, mBluetoothAdd, mlbrcode, userName, date,
                                    "", "", mcenterid,
                                    repeatedStringAmount, repeatedStringprdAccId, repeatedStringEntryDate, "",
                                    projectName, trefno, repeatedStringCustomerNumber, branchName, centerName, total,header);
                            PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                            printAsync.execute(printingParams);

                        } else if (call.method.equalsIgnoreCase("svngcollgroupprint")) { // Calling for printing value for GROUP SAVING  COLLECTION
                            String mBluetoothAdd = call.argument("BluetoothADD");
                            String mlbrcode = call.argument("mlbrcode");
                            String date = call.argument("date");
                            String mgroupcd = call.argument("mgroupcd");
                            String repeatedStringAmount = call.argument("repeatedStringAmount");
                            String repeatedStringprdAccId = call.argument("repeatedStringprdAccId");
                            String repeatedStringEntryDate = call.argument("repeatedStringEntryDate");
                            String projectName = call.argument("company");

                            String trefno = call.argument("trefno");
                            String repeatedStringCustomerNumber = call.argument("repeatedStringCustomerNumber");
                            String branchName = call.argument("branchName");
                            String centerName = call.argument("centerName");
                            String total = call.argument("total");
                            String userName = call.argument("username");
                            String header = call.argument("header");


                            PrintingParams printingParams = new PrintingParams(3, mBluetoothAdd, mlbrcode, userName, date, "", "", mgroupcd,
                                    repeatedStringAmount, repeatedStringprdAccId, repeatedStringEntryDate, "",
                                    projectName, trefno, repeatedStringCustomerNumber, branchName, centerName, total,header);
                            PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                            printAsync.execute(printingParams);


                        } else if (call.method.equalsIgnoreCase("svngcollcustnoprint")) { // Calling for printing value for CUSTOMER SAVING  COLLECTION
                            String mBluetoothAdd = call.argument("BluetoothADD");
                            String mlbrcode = call.argument("mlbrcode");
                            String date = call.argument("date");
                            String mcustno = call.argument("mcustno");
                            String repeatedStringAmount = call.argument("repeatedStringAmount");
                            String repeatedStringprdAccId = call.argument("repeatedStringprdAccId");
                            // String repeatedStringEntryDate = call.argument("repeatedStringEntryDate");
                            String projectName = call.argument("company");
                            String trefno = call.argument("trefno");
                            String total = call.argument("total");
                            String customerName = call.argument("customerName");
                            String userName = call.argument("username");
                            String branchName = call.argument("branchName");
                            String header = call.argument("header");

                            PrintingParams printingParams = new PrintingParams(4, mBluetoothAdd, mlbrcode, userName,
                                    date, "", customerName, mcustno,
                                    repeatedStringAmount, repeatedStringprdAccId, "", "", projectName,
                                    trefno, "", branchName, "", total,header);
                            PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                            printAsync.execute(printingParams);

                        } else if (call.method.equalsIgnoreCase("svngcolltodaysprint")) { // Calling for printing value for TODAY SAVING  COLLECTION
                            String mBluetoothAdd = call.argument("BluetoothADD");
                            String mlbrcode = call.argument("mlbrcode");
                            String date = call.argument("date");
                            String repeatedStringAmount = call.argument("repeatedStringAmount");
                            String repeatedStringprdAccId = call.argument("repeatedStringprdAccId");
                            String repeatedStringCustNo = call.argument("repeatedStringCustNo");
                            String projectName = call.argument("company");
                            String total = call.argument("total");
                            String userName = call.argument("username");
                            String header = call.argument("header");

                            PrintingParams printingParams = new PrintingParams(5, mBluetoothAdd, mlbrcode, userName, date, "",
                                    "", "",
                                    repeatedStringAmount, repeatedStringprdAccId, repeatedStringCustNo, "", projectName,
                                    "", "", "", "", total,header);
                            PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                            printAsync.execute(printingParams);


                        } else if (call.method.equalsIgnoreCase("withdrawlDepositPrint")) {

                            String projectName = call.argument("company");
                            if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_FULLERTON)) {
                                String mBluetoothAdd = call.argument("BluetoothADD");
                                String date = call.argument("date");
                                String transactionTime = call.argument("TransactionTime");
                                String voluntaryCompulsorySavingAC = call.argument("VoluntaryCompulsorySavingAC");
                                String customerName = call.argument("CustomerName");
                                String transactionreference = call.argument("TransactionReference");
                                String customernrcno = call.argument("CustomerNRCNo");
                                String depositwithdrawalamount = call.argument("DepositWithdrawalAmount");
                                String totalbalance = call.argument("TotalBalance");
                                String contactphoneno = call.argument("ContactPhoneNo");
                                String loanofficers = call.argument("LoanOfficers");
                                String transactiontype = call.argument("TransactionType");
                                String companyName = call.argument("company");
                                String header = call.argument("header");


                                PrintingParams printingParams = new PrintingParams(6, mBluetoothAdd, date,//3
                                        transactionTime, voluntaryCompulsorySavingAC, customerName, transactionreference, customernrcno,//8
                                        depositwithdrawalamount, totalbalance, contactphoneno, loanofficers,companyName, //13
                                        transactiontype, "", "", "", "",header);//19
                                PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                                printAsync.execute(printingParams);

                            }
                            else if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_WASASA)) {

                                String mBluetoothAdd = call.argument("BluetoothADD");
                                String date = call.argument("date");
                                String transactionTime = call.argument("TransactionTime");
                                String voluntaryCompulsorySavingAC = call.argument("VoluntaryCompulsorySavingAC");
                                String customerName = call.argument("CustomerName");
                                String transactionreference = call.argument("TransactionReference");
                                String customernrcno = call.argument("CustomerNRCNo");
                                String depositwithdrawalamount = call.argument("DepositWithdrawalAmount");
                                String totalbalance = call.argument("TotalBalance");
                                String contactphoneno = call.argument("ContactPhoneNo");
                                String loanofficers = call.argument("LoanOfficers");
                                String transactiontype = call.argument("TransactionType");
                                String companyName = call.argument("company");
                                String header = call.argument("header");
                                String lbrCode  =  call.argument("lbrcode");
                                String foprintingname = call.argument("username");
                                PrintingParams printingParams = new PrintingParams(6, mBluetoothAdd, date, //3
                                        transactionTime, voluntaryCompulsorySavingAC, customerName, transactionreference, customernrcno, //8
                                        depositwithdrawalamount, totalbalance, contactphoneno, loanofficers,companyName,  //13
                                        transactiontype, lbrCode, foprintingname, "", "",header); //19
                                PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                                printAsync.execute(printingParams);


                            }
                            // calling for withdrawl or deposit print



                        } else if (call.method.equalsIgnoreCase("loancollcenterprint")) {  // Calling for printing value for CENTER LOAN COLLECTION
                            String mBluetoothAdd = call.argument("BluetoothADD");
                            String mlbrcode = call.argument("mlbrcode");
                            String date = call.argument("date");
                            String mcenterid = call.argument("mcenterid");
                            String repeatedStringAmount = call.argument("repeatedStringAmount");
                            String repeatedStringprdAccId = call.argument("repeatedStringprdAccId");
                            String repeatedStringEntryDate = call.argument("repeatedStringEntryDate");
                            String projectName = call.argument("company");

                            String trefno = call.argument("trefno");
                            String repeatedStringCustomerNumber = call.argument("repeatedStringCustomerNumber");
                            String branchName = call.argument("branchName");
                            String centerName = call.argument("centerName");
                            String total = call.argument("total");
                            String userName = call.argument("username");
                            String header = call.argument("header");

                            PrintingParams printingParams = new PrintingParams(7, mBluetoothAdd, mlbrcode, userName, date,
                                    "", "", mcenterid,
                                    repeatedStringAmount, repeatedStringprdAccId, repeatedStringEntryDate, "",
                                    projectName, trefno, repeatedStringCustomerNumber, branchName, centerName, total,header);
                            PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                            printAsync.execute(printingParams);

                        } else if (call.method.equalsIgnoreCase("loancollgroupprint")) {// Calling for printing value for GROUP LOAN  COLLECTION

                            String projectName = call.argument("company");

                            if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_FULLERTON)) {
                                String mBluetoothAdd_FL = call.argument("BluetoothADD");
                                String mgroupcd_FL = call.argument("mgroupcd");
                                String repeatedStringAmount_FL = call.argument("repeatedStringAmount");
                                String repeatedStringCustName_FL = call.argument("repeatedStringCustName");
                                String trefno_FL = call.argument("trefno");
                                String centerNo_FL = call.argument("centerNo");
                                String total_FL = call.argument("total");


                                String repeatedStringCustomerNumber_FL = call.argument("repeatedStringCustomerNumber");
                                String contactNo_FL = call.argument("contactNo");
                                String createdDate_FL = call.argument("createdDate");
                                String createdTime_FL = call.argument("createdTime");
                                String userName_FL = call.argument("username");


                                PrintingParams printingParams = new PrintingParams(8, mBluetoothAdd_FL, createdDate_FL,
                                        createdTime_FL, trefno_FL, mgroupcd_FL, centerNo_FL, repeatedStringCustomerNumber_FL,
                                        repeatedStringCustName_FL, repeatedStringAmount_FL, total_FL, contactNo_FL,
                                        projectName, userName_FL, "", "", "", "","");
                                PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                                printAsync.execute(printingParams);

                            } else if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_WASASA)) {
                                String mBluetoothAdd = call.argument("BluetoothADD");
                                String mlbrcode = call.argument("mlbrcode");
                                String date = call.argument("date");
                                String mgroupcd = call.argument("mgroupcd");
                                String repeatedStringAmount = call.argument("repeatedStringAmount");
                                String repeatedStringprdAccId = call.argument("repeatedStringprdAccId");
                                String repeatedStringEntryDate = call.argument("repeatedStringEntryDate");


                                String trefno = call.argument("trefno");
                                String repeatedStringCustomerNumber = call.argument("repeatedStringCustomerNumber");
                                String branchName = call.argument("branchName");
                                String centerName = call.argument("centerName");
                                String total = call.argument("total");
                                String userName = call.argument("username");
                                String header = call.argument("header");


                                PrintingParams printingParams = new PrintingParams(8, mBluetoothAdd, mlbrcode, userName, date, "", "", mgroupcd,
                                        repeatedStringAmount, repeatedStringprdAccId, repeatedStringEntryDate, "",
                                        projectName, trefno, repeatedStringCustomerNumber, branchName, centerName, total,header);
                                PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                                printAsync.execute(printingParams);

                            }



                        } else if (call.method.equalsIgnoreCase("loancollcustnoprint")) { // Calling for printing value for CUSTOMER LOAN  COLLECTION
                            String projectName = call.argument("company");

                            if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_FULLERTON)) {
                                String mBluetoothAdd_FL = call.argument("BluetoothADD");
                                String date_FL = call.argument("createdDate");
                                String trns_time_FL = call.argument("createdTime");
                                String tref_FL = call.argument("trefno");
                                String custNo_FL = call.argument("mcustno");
                                String custName_FL = call.argument("customerName");
                                String loanRepayAcnt_FL = call.argument("repeatedStringprdAccId");
                                String loanRepayPrincpl_FL = call.argument("LoanRepaymentPrin");
                                String loanRepayInt_FL = call.argument("LoanRepaymentInt");
                                String othrChrgsPnlty_FL = call.argument("OtherChargesPenalty");
                                String totalRepayAmnt_FL = call.argument("TotalRepaymentAmount");
                                String loanOunstndinBal_FL = call.argument("LoanOutstandingBalance");
                                String contctNo_FL = call.argument("contactNo");
                                String loanOffcr_FL = call.argument("username");

                                PrintingParams printingParams = new PrintingParams(9, mBluetoothAdd_FL, date_FL, trns_time_FL,
                                        tref_FL, custNo_FL, custName_FL, loanRepayAcnt_FL,
                                        "", loanRepayPrincpl_FL, loanRepayInt_FL,
                                        othrChrgsPnlty_FL, projectName,
                                        totalRepayAmnt_FL, "", loanOunstndinBal_FL, contctNo_FL, loanOffcr_FL,"");
                                PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                                printAsync.execute(printingParams);


                            } else if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_WASASA)) {

                                String mBluetoothAdd = call.argument("BluetoothADD");
                                String mlbrcode = call.argument("mlbrcode");
                                String date = call.argument("date");
                                String mcustno = call.argument("mcustno");
                                String repeatedStringAmount = call.argument("repeatedStringAmount");
                                String repeatedStringprdAccId = call.argument("repeatedStringprdAccId");

                                String projectName_WS = call.argument("company");
                                String trefno = call.argument("trefno");
                                String total = call.argument("total");
                                String customerName = call.argument("customerName");
                                String userName = call.argument("username");
                                String branchName = call.argument("branchName");
                                String header = call.argument("header");
                                PrintingParams printingParams = new PrintingParams(9, mBluetoothAdd, mlbrcode, userName,
                                        date, "", customerName, mcustno,
                                        repeatedStringAmount, repeatedStringprdAccId, "",
                                        "", projectName_WS,
                                        trefno, "", branchName, "", total,header);
                                PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                                printAsync.execute(printingParams);

                            }


                        } else if (call.method.equalsIgnoreCase("loancolltodaysprint")) { // Calling for printing value for TODAY LOAN  COLLECTION
                            String mBluetoothAdd = call.argument("BluetoothADD");
                            String mlbrcode = call.argument("mlbrcode");
                            String date = call.argument("date");
                            String repeatedStringAmount = call.argument("repeatedStringAmount");
                            String repeatedStringprdAccId = call.argument("repeatedStringprdAccId");
                            String repeatedStringCustNo = call.argument("repeatedStringCustomerNumber");
                            String projectName = call.argument("company");
                            String total = call.argument("total");
                            String userName = call.argument("username");
                            String header = call.argument("header");

                            PrintingParams printingParams = new PrintingParams(10, mBluetoothAdd, mlbrcode, userName, date, "",
                                    "", "",
                                    repeatedStringAmount, repeatedStringprdAccId, repeatedStringCustNo, "", projectName,
                                    "", "", "", "", total,header);
                            PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                            printAsync.execute(printingParams);


                        } else if (call.method.equalsIgnoreCase("loanClosureCustPrint")) { // Calling for printing value for CUSTOMER LOAN  CLOSURE
                            String mBluetoothAdd = call.argument("BluetoothADD");
                            String mlbrcode = call.argument("mlbrcode");
                            String date = call.argument("date");
                            String mcustno = call.argument("mcustno");
                            String repeatedStringAmount = call.argument("repeatedStringAmount");
                            String repeatedStringprdAccId = call.argument("repeatedStringprdAccId");
                            String repeatedStringCustomerNumber = call.argument("repeatedStringCustomerNumber");
                            String branchName = call.argument("branchName");

                            String projectName = call.argument("company");
                            String trefno = call.argument("trefno");
                            String centerName = call.argument("centerName");
                            String total = call.argument("total");
                            String customerName = call.argument("customerName");
                            String userName = call.argument("username");
                            String userCode = call.argument("userCode");
                            String remarks = call.argument("remarks");
                            String header = call.argument("header");

                            PrintingParams printingParams = new PrintingParams(11, mBluetoothAdd, mlbrcode, userName,
                                    date, remarks, customerName, mcustno,
                                    repeatedStringAmount, repeatedStringprdAccId, centerName, userCode, projectName,
                                    trefno, repeatedStringCustomerNumber, branchName, "", total,header);
                            PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                            printAsync.execute(printingParams);

                        } else if (call.method.equalsIgnoreCase("loanClosureGroupPrint")) { // Calling for printing value for GROUP LOAN  COLLECTION
                            String mBluetoothAdd = call.argument("BluetoothADD");
                            String mlbrcode = call.argument("mlbrcode");
                            String date = call.argument("date");
                            String mgroupcd = call.argument("mgroupcd");
                            String repeatedStringAmount = call.argument("repeatedStringAmount");
                            String repeatedStringprdAccId = call.argument("repeatedStringprdAccId");
                            String repeatedStringEntryDate = call.argument("repeatedStringEntryDate");
                            String projectName = call.argument("company");

                            String trefno = call.argument("trefno");
                            String repeatedStringCustomerNumber = call.argument("repeatedStringCustomerNumber");
                            String branchName = call.argument("branchName");
                            String centerName = call.argument("centerName");
                            String total = call.argument("total");
                            String userName = call.argument("username");
                            String header = call.argument("header");


                            PrintingParams printingParams = new PrintingParams(12, mBluetoothAdd, mlbrcode, userName, date, "", "", mgroupcd,
                                    repeatedStringAmount, repeatedStringprdAccId, repeatedStringEntryDate, "",
                                    projectName, trefno, repeatedStringCustomerNumber, branchName, centerName, total,header);
                            PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                            printAsync.execute(printingParams);


                        } else if (call.method.equalsIgnoreCase("disbursmentIndvPrint")) { // Calling for Individual LOAN DISBURSTMENT

                            String projectName = call.argument("companyName");

                            if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_FULLERTON)) {
                                String mBluetoothAdd = call.argument("BluetoothADD");
                                String mlbrcode = call.argument("mlbrcode");
                                String date = call.argument("date");
                                String mcenterid = call.argument("mcenterid");
                                String customername = call.argument("customername");
                                String productType = call.argument("productType");
                                String leadsid = call.argument("leadsid");
                                String loanRepaymentAccount = call.argument("loanRepaymentAccount");

                                String disbursedAmount = call.argument("disbursedAmount");
                                String documentationFees = call.argument("documentationFees");
                                String insuranceCharges = call.argument("insuranceCharges");
                                String contactNo = call.argument("contactNo");
                                String loanOfficer = call.argument("loanOfficer");
                                String custNumber = call.argument("custNumber");
                                String companyName = call.argument("companyName");


                                PrintingParams printingParams = new PrintingParams(13, mBluetoothAdd, date, custNumber,
                                        customername, productType, leadsid, loanRepaymentAccount,
                                        disbursedAmount, documentationFees, insuranceCharges, contactNo,
                                        companyName, loanOfficer, "", "", "", "","");
                                PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                                printAsync.execute(printingParams);


                            } else if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_WASASA)) {

                                String mBluetoothAdd_WS = call.argument("BluetoothADD");
                                String mBranchName_WS = call.argument("branchName");
                                String mDisbursementDate_WS = call.argument("date");
                                String mTrefNo_WS = call.argument("trefno");
                                String mBatchNo_WS = call.argument("batchno");
                                String mSetNo_WS = call.argument("setno");
                                String mPrdAcctId_WS = call.argument("loanRepaymentAccount");
                                String mCustomerName_WS = call.argument("custName");
                                String mDisbursementAmount_WS = call.argument("disbursedAmount");
                                String mPreparedBy_WS = call.argument("loanOfficer");
                                String mPassbookFee = call.argument("passbookFee");
                                String mProcessingFee = call.argument("processingFee");
                                String mPremiumAmount = call.argument("premiumAmount");
                                String mTotalFee = call.argument("totalFee");
                                String header = call.argument("header");
                                String receipttype = call.argument("receipttype");


                                PrintingParams printingParams = new PrintingParams(13, mBluetoothAdd_WS, mBranchName_WS, mDisbursementDate_WS,//4
                                        mTrefNo_WS, mBatchNo_WS, mPrdAcctId_WS, mCustomerName_WS,//8
                                        mDisbursementAmount_WS, mPreparedBy_WS, mSetNo_WS, receipttype,//12
                                        projectName, mPassbookFee, mProcessingFee, mPremiumAmount, mTotalFee, mDisbursementAmount_WS,header);//19
                                PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                                printAsync.execute(printingParams);




                            }







                        }else if (call.method.equalsIgnoreCase("MR_GrpAndIndivdlSvnCltn")) { // Calling Group and individual saving collection receipt
                            String mBluetoothAdd = call.argument("BluetoothADD");
                            String mlbrcode = call.argument("mlbrcode");
                            String date = call.argument("date");
                            String repeatedStringGroupAmount = call.argument("repeatedStringGroupAmount");
                            String repeatedStringGroupName = call.argument("repeatedStringGroupName");
                            String individualAmountString = call.argument("individualAmountString");
                            String branchName = call.argument("branchName");
                            String companyName = call.argument("company");
                            String trefno = call.argument("trefno");

                            String total = call.argument("total");
                            String username = call.argument("username");
                            String repeatedStringGroupID = call.argument("repeatedStringGroupId");
                            String header = call.argument("header");




                            PrintingParams printingParams = new PrintingParams(14, mBluetoothAdd, mlbrcode, date,
                                    repeatedStringGroupAmount, repeatedStringGroupName, individualAmountString, branchName,
                                    trefno, total, username, repeatedStringGroupID,
                                    companyName, "", "", "", "", "",header);
                            PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                            printAsync.execute(printingParams);


                        }else if (call.method.equalsIgnoreCase("MR_GrpAndIndivdlLoanCltn")) { // Group and individual Loan collection receipt
                            String mBluetoothAdd = call.argument("BluetoothADD");
                            String mlbrcode = call.argument("mlbrcode");
                            String date = call.argument("date");
                            String repeatedStringGroupAmount = call.argument("repeatedStringGroupAmount");
                            String repeatedStringGroupName = call.argument("repeatedStringGroupName");
                            String individualAmountString = call.argument("individualAmountString");
                            String branchName = call.argument("branchName");
                            String companyName = call.argument("company");
                            String trefno = call.argument("trefno");

                            String total = call.argument("total");
                            String username = call.argument("username");
                            String repeatedStringGroupID = call.argument("repeatedStringGroupId");
                            String header = call.argument("header");

                            PrintingParams printingParams = new PrintingParams(15, mBluetoothAdd, mlbrcode, date,
                                    repeatedStringGroupAmount, repeatedStringGroupName, individualAmountString, branchName,
                                    trefno, total, username, repeatedStringGroupID,
                                    companyName, "", "", "", "", "",header);
                            PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                            printAsync.execute(printingParams);


                        }
                        else if (call.method.equalsIgnoreCase("MR_TransactionsSummary")) { // Calling for Transactions summary receipt format
                            String mBluetoothAdd = call.argument("BluetoothADD");
                            String mlbrcode = call.argument("mlbrcode");
                            String date = call.argument("date");
                            String mcenterid = call.argument("mcenterid");
                            String customername = call.argument("customername");
                            String productType = call.argument("productType");
                            String leadsid = call.argument("leadsid");
                            String loanRepaymentAccount = call.argument("loanRepaymentAccount");

                            String disbursedAmount = call.argument("disbursedAmount");
                            String documentationFees = call.argument("documentationFees");
                            String insuranceCharges = call.argument("insuranceCharges");
                            String contactNo = call.argument("contactNo");
                            String loanOfficer = call.argument("loanOfficer");
                            String custNumber = call.argument("custNumber");
                            String companyName = call.argument("companyName");
                            String header = call.argument("header");


                            PrintingParams printingParams = new PrintingParams(16, mBluetoothAdd, date, custNumber,
                                    customername, productType, leadsid, loanRepaymentAccount,
                                    disbursedAmount, documentationFees, insuranceCharges, contactNo,
                                    companyName, loanOfficer, "", "", "", "",header);
                            PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                            printAsync.execute(printingParams);


                        }
                        else if (call.method.equalsIgnoreCase("cashbooksummaryprint")) { // Calling for Individual LOAN DISBURSTMENT

                            String projectName = call.argument("companyName");



                            if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_FULLERTON)) {
                               // System.out.println("Fullerton Print k andar");
                                String mBluetoothAdd = call.argument("BluetoothADD");
                                String mlbrcode = call.argument("mlbrcode");
                                String branchName = call.argument("branchName");
                                String date = call.argument("date");
                                String time = call.argument("time");
                                String operationDate = call.argument("operationDate");
                                String openCash = call.argument("openCash");
                                String inflowCash = call.argument("inflowCash");

                                String outflowCash = call.argument("outflowCash");
                                String userCode = call.argument("userCode");
                                String userName = call.argument("userName");
                                String header = call.argument("header");


                                PrintingParams printingParams = new PrintingParams(17, mBluetoothAdd, mlbrcode, branchName,
                                date, time, operationDate, openCash,
                                inflowCash, outflowCash, userCode, userName,
                                        projectName, "", "", "", "", "","");
                                PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                                printAsync.execute(printingParams);


                            } else if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_WASASA)) {
                                String mBluetoothAdd = call.argument("BluetoothADD");
                                String mlbrcode = call.argument("mlbrcode");
                                String branchName = call.argument("branchName");
                                String date = call.argument("date");
                                String time = call.argument("time");
                                String operationDate = call.argument("operationDate");
                                String openCash = call.argument("openCash");
                                String inflowCash = call.argument("inflowCash");

                                String outflowCash = call.argument("outflowCash");
                                String userCode = call.argument("userCode");
                                String userName = call.argument("userName");
                                String header = call.argument("header");


                                PrintingParams printingParams = new PrintingParams(17, mBluetoothAdd, mlbrcode, branchName,
                                date, time, operationDate, openCash,
                                inflowCash, outflowCash, userCode, userName,
                                        projectName, "", "", "", "", "",header);
                                       // System.out.println("yhan se nikla data");
                                 PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                                printAsync.execute(printingParams);
                                





                            }







                        }

                        else if (call.method.equalsIgnoreCase("cashbooktransactionprint")) { // Calling for Individual LOAN DISBURSTMENT

                            String projectName = call.argument("companyName");
                           // System.out.println("print k andar");



                            if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_FULLERTON)) {
                               // System.out.println("Fullerton Print k andar");
                                String mBluetoothAdd = call.argument("BluetoothADD");
                                String mlbrcode = call.argument("mlbrcode");
                                String branchName = call.argument("branchName");
                                String date = call.argument("date");
                                String time = call.argument("time");
                                String operationDate = call.argument("operationDate");
                                String openCash = call.argument("openCash");
                                String inflowCash = call.argument("inflowCash");

                                String outflowCash = call.argument("outflowCash");
                                String userCode = call.argument("userCode");
                                String userName = call.argument("userName");
                                String header = call.argument("header");


                                PrintingParams printingParams = new PrintingParams(18, mBluetoothAdd, mlbrcode, branchName,
                                        date, time, operationDate, openCash,
                                        inflowCash, outflowCash, userCode, userName,
                                        projectName, "", "", "", "", "","");
                                PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                                printAsync.execute(printingParams);


                            } else if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_WASASA)) {
                               // System.out.println(" Doosra wala Wasasa Print k andar");
                                String mBluetoothAdd = call.argument("BluetoothADD");
                                String mlbrcode = call.argument("mlbrcode");
                                String branchName = call.argument("branchName");
                                String date = call.argument("date");
                                String time = call.argument("time");
                                String operationDate = call.argument("operationDate");
                                String transactionTime = call.argument("TransactionTime");
                                String customerNumber = call.argument("CustomerNumber");

                                String accountid = call.argument("Accountid");
                                String referenceNumber = call.argument("referenceNumber");
                                String TransactionType = call.argument("TransactionType");
                                String Amount = call.argument("Amount");
                                String userName = call.argument("userName");

                                String header = call.argument("header");


                                PrintingParams printingParams = new PrintingParams(18, mBluetoothAdd, mlbrcode, branchName,
                                        date, time, operationDate, transactionTime,
                                        customerNumber, accountid, referenceNumber,TransactionType,projectName, Amount,
                                        userName, "", "", "",header);
                                PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                                printAsync.execute(printingParams);






                            }







                        }else if (call.method.equalsIgnoreCase("InternalTransactionPrint")) { // Calling for Individual LOAN DISBURSTMENT

                            String projectName = call.argument("companyName");


                              if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_WASASA)) {
                                String mBluetoothAdd = call.argument("BluetoothADD");
                                String lbrcode = call.argument("lbrcode");
                                String date = call.argument("date");
                                String TransactionTime = call.argument("TransactionTime");
                                String accountid = call.argument("acctId");
                                  String creditAcctId = call.argument("creditAcctId");
                                  String debitAcctId = call.argument("debitAcctId");
                                String TransactionReference = call.argument("TransactionReference");
                                String TransactionType = call.argument("TransactionType");
                                String amount = call.argument("amount");
                                String username = call.argument("username");
                                  String remarks = call.argument("remarks");
                                String header = call.argument("header");
                                  String acountname = call.argument("acountname");



                                PrintingParams printingParams = new PrintingParams(19, mBluetoothAdd, lbrcode, date, //4
                                        TransactionTime, accountid, creditAcctId, debitAcctId,//8
                                        TransactionReference, amount, username,remarks,projectName, TransactionType, //14
                                        acountname, "", "", "",header); //19
                                PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                                printAsync.execute(printingParams);
                            }

                        }else if (call.method.equalsIgnoreCase("withdrawaltodaysprint")) { // Calling for Individual LOAN DISBURSTMENT

                            String projectName = call.argument("companyName");
                            if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_WASASA)) {
                                String mBluetoothAdd = call.argument("BluetoothADD");

                                String date = call.argument("date");
                                String time = call.argument("time");
                                String operationDate = call.argument("operationDate");
                                String Accountid = call.argument("Accountid");
                                String Amount = call.argument("Amount");
                                String TotalAmount = call.argument("TotalAmount");
                                String header = call.argument("header");
                                String userName = call.argument("userName");
                                String branchName = call.argument("branchName");
                                String mlbrcode = call.argument("mlbrcode");
                                String CustomerNumbers = call.argument("CustomerNumbers");

                                PrintingParams printingParams = new PrintingParams(20, mBluetoothAdd, date,time, //4
                                        operationDate, Accountid, Amount, TotalAmount,//8
                                        userName, branchName, mlbrcode,CustomerNumbers,projectName, "", //14
                                        "", "", "", "",header); //19
                                PrintAsync printAsync = new PrintAsync(MainActivity.this, result);
                                printAsync.execute(printingParams);
                            }

                        }


                        else if (call.method.equalsIgnoreCase("callingForFPS")) { // calling for Finger Print Capture only
                            String mBluetoothAdd = call.argument("BluetoothADD");
                            String mTypeOfFinger = call.argument("TYPEofFINGER");
                            String mUserType = call.argument("UserType");
                            VerifyTempParams params = new VerifyTempParams(mBluetoothAdd, "capture", mTypeOfFinger, mUserType,
                                    "", "", "", "",
                                    "", "", "", "", "", "");
                            VerifyTempleAsync verifyTemp = new VerifyTempleAsync(MainActivity.this, result);
                            verifyTemp.execute(params);

                        } else if (call.method.equalsIgnoreCase("callingForFPSMatch")) { // calling for Finger print Match only
                            String mBluetoothAdd = call.argument("BluetoothADD");
                            String LhThumbValue = call.argument("LhThumbValue");
                            String LhIndexFingerValue = call.argument("LhIndexFingerValue");
                            String LhMiddleFingerValue = call.argument("LhMiddleFingerValue");
                            String LhRingFingerValue = call.argument("LhRingFingerValue");
                            String LhPinkyFingerValue = call.argument("LhPinkyFingerValue");

                            String RhThumbValue = call.argument("RhThumbValue");
                            String RhIndexFingerValue = call.argument("RhIndexFingerValue");
                            String RhMiddleFingerValue = call.argument("RhMiddleFingerValue");
                            String RhRingFingerValue = call.argument("RhRingFingerValue");
                            String RhPinkyFingerValue = call.argument("RhPinkyFingerValue");

                            VerifyTempParams params = new VerifyTempParams(mBluetoothAdd, "match", "", "",
                                    LhThumbValue, LhIndexFingerValue, LhMiddleFingerValue, LhRingFingerValue, LhPinkyFingerValue,
                                    RhThumbValue, RhIndexFingerValue, RhMiddleFingerValue, RhRingFingerValue, RhPinkyFingerValue);
                            VerifyTempleAsync verifyTemp = new VerifyTempleAsync(MainActivity.this, result);
                            verifyTemp.execute(params);

                        } else {
                            Log.d("notImplemented:: ", call.method);
                        }
                    }
                });


        ViewTreeObserver vto = getFlutterView().getViewTreeObserver();
        vto.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
            @Override
            public void onGlobalLayout() {
                getFlutterView().getViewTreeObserver().removeOnGlobalLayoutListener(this);
                getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);
            }
        });


    }


    public boolean createConn(String sMac) {
        Log.e("Connect 1", "Create Connection");
        if (null == this.mBTcomm) {
            Log.e("Connect 2", "Create Connection");
            this.mBTcomm = new BluetoothComm(sMac);
            Log.e("Connect 3", "Create Connection");
            if (this.mBTcomm.createConn()) {
                Log.e("Connect 4", "Create Connection");
                return true;
            } else {
                this.mBTcomm = null;
                Log.e("Connect 5", "Create Connection");
                return false;
            }
        } else return true;
    }

    public static void progressDialog(Context context, String msg) {
        dlgPg = new ProgressDialog(context);

        try {

            dlgPg.setMessage(msg);
            dlgPg.setIndeterminate(true);
            dlgPg.setCancelable(false);
            dlgPg.show();
        } catch (NullPointerException np) {

        }

    }

    @Override
    public void onTaskComplete(Integer result) {
        //Toast.makeText(this, "The result is " + result, Toast.LENGTH_LONG).show();
        retVal = result + "";
    }

    private class startBluetoothDeviceTask extends AsyncTask<String, String, Integer> {

        private static final int RET_BULETOOTH_IS_START = 0x0001;
        private static final int RET_BLUETOOTH_START_FAIL = 0x04;
        private static final int miWATI_TIME = 15;
        private static final int miSLEEP_TIME = 150;
        private ProgressDialog mpd;

        @Override
        protected Integer doInBackground(String... arg0) {
            Log.e("Test 0.2 Discover", "BT");
            int iWait = miWATI_TIME * 1000;
            /* BT isEnable */
            if (!mBT.isEnabled()) {
                mBT.enable();
                //Wait miSLEEP_TIME seconds, start the Bluetooth device before you start scanning
                while (iWait > 0) {
                    if (!mBT.isEnabled()) iWait -= miSLEEP_TIME;
                    else break;
                    SystemClock.sleep(miSLEEP_TIME);
                }
                if (iWait < 0) return RET_BLUETOOTH_START_FAIL;
            }
            return RET_BULETOOTH_IS_START;
        }

        @Override
        public void onPreExecute() {
            Log.e("Test 0.1 Discover", "BT");
            mpd = new ProgressDialog(MainActivity.this);
            mpd.setMessage(getString(R.string.actDiscovery_msg_starting_device));
            mpd.setCancelable(false);
            mpd.setCanceledOnTouchOutside(false);
            mpd.show();
            mbBleStatusBefore = mBT.isEnabled();
        }

        /**
         * After blocking cleanup task execution
         */
        @Override
        public void onPostExecute(Integer result) {
            if (mpd.isShowing()) mpd.dismiss();
            Log.e("Test 0.3 Discover", "BT");
            if (RET_BLUETOOTH_START_FAIL == result) {
                android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(MainActivity.this);
                builder.setTitle(getString(R.string.dialog_title_sys_err));
                builder.setMessage(getString(R.string.actDiscovery_msg_start_bluetooth_fail));
                builder.setPositiveButton(R.string.btn_ok, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        mBT.disable();
                        Log.e("Test 0.4 Discover", "BT");
                    }
                });
                builder.create().show();
            } else if (RET_BULETOOTH_IS_START == result) {
                Log.e("Test 0.5 Discover", "BT");
            }
        }
    }

    public class VerifyTempleAsync extends AsyncTask<VerifyTempParams, Integer, ResultWrapper> {
        private TaskCompleted mCallback;
        private Context mContext;
        private Result result;

        public VerifyTempleAsync(Context context, Result result) {
            this.mContext = context;
            this.mCallback = (TaskCompleted) context;
            this.result = result;

        }

        /* Task of VerifyTempleAsync performing in the background */
        @Override
        protected ResultWrapper doInBackground(VerifyTempParams... params) {

            String bleAddress = params[0].bleAddress;
            String matchOrCaputre = params[0].matchOrCaputre;
            String fingerType = params[0].fingerType;
            String userType = params[0].userType;

            String LhThumbValueRec = params[0].LhThumbValue;
            String LhIndexFingerValueRec = params[0].LhIndexFingerValue;
            String LhMiddleFingerValueRec = params[0].LhMiddleFingerValue;
            String LhRingFingerValueRec = params[0].LhRingFingerValue;
            String LhPinkyFingerValueRec = params[0].LhPinkyFingerValue;

            String RhThumbValueRec = params[0].RhThumbValue;
            String RhIndexFingerValueRec = params[0].RhIndexFingerValue;
            String RhMiddleFingerValueRec = params[0].RhMiddleFingerValue;
            String RhRingFingerValueRec = params[0].RhRingFingerValue;
            String RhPinkyFingerValueRec = params[0].RhPinkyFingerValue;

            if (createConn(bleAddress)) {


                if (matchOrCaputre.equalsIgnoreCase("capture")) {

                    OutputStream outSt = BluetoothComm.mosOut;
                    InputStream inSt = BluetoothComm.misIn;
                    //   System.out.println("ApplicationID outStrm " + outSt + "ApplicationID inptStrm " + inSt);
                    try {
                        fps = new FPS(setupInstance, outSt, inSt);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
// code for getting finger print image
                    int iReturnvalue = 0;
                    bufvalue = new byte[3500];
                    iReturnvalue = fps.iGetFingerImageCompressed(bufvalue, new
                            FpsConfig(0, (byte) 0x0f));
                    if (iReturnvalue > 0) {
                        byte[] dataforVerification = {};

                        dataforVerification = fps.bGetMinutiaeData();
                        encodedStringforVerification = Base64.encodeToString(dataforVerification, Base64.DEFAULT);// we have to pass this data to the iFpsVerifyMinutiae
                        Log.w("imageDataaaa!!", dataforVerification.toString());
                        Log.w("StringforVerification", encodedStringforVerification);

                        byte[] dataforconversion = {};
                        dataforconversion = fps.bGetImageData();
                        byte[] bBmpData = FpsImageAPI.bConvertRaw2bmp(dataforconversion);
                        encodedStringforConversion = Base64.encodeToString(bBmpData, Base64.DEFAULT);

                      /*  ByteArrayOutputStream baos = new ByteArrayOutputStream();
                        byte[] imageBytes = baos.toByteArray();
                        imageBytes = Base64.decode(encodedStringforConversion, Base64.DEFAULT);
                         decodedImage = BitmapFactory.decodeByteArray(imageBytes, 0, imageBytes.length);*/


                        Log.w("StringforConversion", encodedStringforConversion);
                        Log.w("bmpData!!", bBmpData.toString());


                        Log.w("RESULT", "Get Compressed Image Capture data Success");

                        // Toast.makeText(getApplicationContext(), "Get Compressed Image Capture data Success", Toast.LENGTH_SHORT).show();
                    } else if (iReturnvalue == FPS.TIME_OUT) {
                        Log.w("RESULT", "Get Compressed Image Capture data Time out");
                        // Toast.makeText(getApplicationContext(), "Get Compressed Image Capture data Time out", Toast.LENGTH_SHORT).show();
                        Log.w("RESULT", "Get Compressed Image Capture data Success");
                    } else if (iReturnvalue == FPS.FAILURE) {
                        Log.w("RESULT", "Get Compressed Image data Failed");
                        //Toast.makeText(getApplicationContext(), "Get Compressed Image data Failed", Toast.LENGTH_SHORT).show();
                    } else if (iReturnvalue == FPS.PARAMETER_ERROR) {
                        Log.w("RESULT", "Parameter Error");
                        Toast.makeText(getApplicationContext(), "Parameter Error",
                                Toast.LENGTH_SHORT).show();
                    } else if (iReturnvalue == FPS.FPS_ILLEGAL_LIBRARY) {
                        Log.w("RESULT", "Illegal Library");
                        Toast.makeText(getApplicationContext(), "Illegal Library",
                                Toast.LENGTH_SHORT).show();
                    } else if (iReturnvalue == FPS.FPS_INACTIVE_PERIPHERAL) {
                        Log.w("RESULT", "Inactive peripheral");
                        Toast.makeText(getApplicationContext(), "Inactive peripheral",
                                Toast.LENGTH_SHORT).show();
                    } else if (iReturnvalue == FPS.FPS_INVALID_DEVICE_ID) {
                        Log.w("RESULT", "Invalid device serial number");
                        // Toast.makeText(getApplicationContext(), "Invali`d device serial number", Toast.LENGTH_SHORT).show();
                    } else if (iReturnvalue == FPS.FPS_DEMO_VERSION) {
                        Log.w("RESULT", "API does not Support Demo Mode");
                        //Toast.makeText(getApplicationContext(), "API does not Support Demo Mode", Toast.LENGTH_SHORT).show();
                    }


                    // bufvalue = new byte[3500];
                   /* fpsconfig = new FpsConfig(0, (byte) 0x0F);//this class used to initialize the  bFpsCaptureTemplate API
                    bufvalue = fps.bFpsCaptureTemplate(fpsconfig);
                    if (bufvalue != null)
                        base64encoded = Base64.encodeToString(bufvalue, Base64.DEFAULT);
                    // System.out.println("finger base64encoded byte[] bufvalue 1 " + base64encoded.toString());
                    iRetValRes = fps.iGetReturnCode();*/
                    ResultWrapper resultWrapper = new ResultWrapper(matchOrCaputre, iReturnvalue, encodedStringforVerification, userType, encodedStringforConversion);

                    return resultWrapper;


                } else if (matchOrCaputre.equalsIgnoreCase("match")) {

                    OutputStream outSt = BluetoothComm.mosOut;
                    InputStream inSt = BluetoothComm.misIn;

                    try {
                        fps = new FPS(setupInstance, outSt, inSt);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }


                    String LhThumbData = LhThumbValueRec;
                    String LhIndexFingerData = LhIndexFingerValueRec;
                    String LhMiddleFingerData = LhMiddleFingerValueRec;
                    String LhRingFingerData = LhRingFingerValueRec;
                    String LhPinkyFingerData = LhPinkyFingerValueRec;

                    String RhThumbData = RhThumbValueRec;
                    String RhIndexFingerData = RhIndexFingerValueRec;
                    String RhMiddleFingerData = RhMiddleFingerValueRec;
                    String RhRingFingerData = RhRingFingerValueRec;
                    String RhPinkyFingerData = RhPinkyFingerValueRec;

                    ArrayList<String> savedFingerList = new ArrayList<String>();
                    savedFingerList.clear();
                    if (LhThumbData != null && LhThumbData.length() > 3) {
                        decodeServerData = Base64.decode(LhThumbData, Base64.DEFAULT);
                        byte[] data = decodeServerData;
                        savedFingerList.add(LhThumbData);
                    }
                    if (LhIndexFingerData != null && LhIndexFingerData.length() > 3) {
                        decodeServerData = Base64.decode(LhIndexFingerData, Base64.DEFAULT);
                        savedFingerList.add(LhIndexFingerData);
                    }
                    if (LhMiddleFingerData != null && LhMiddleFingerData.length() > 3) {
                        decodeServerData = Base64.decode(LhMiddleFingerData, Base64.DEFAULT);
                        savedFingerList.add(LhMiddleFingerData);
                    }
                    if (LhRingFingerData != null && LhRingFingerData.length() > 3) {
                            decodeServerData = Base64.decode(LhRingFingerData, Base64.DEFAULT);
                            savedFingerList.add(LhRingFingerData);
                    }
                    if (LhPinkyFingerData != null && LhPinkyFingerData.length() > 3) {
                        decodeServerData = Base64.decode(LhPinkyFingerData, Base64.DEFAULT);
                        savedFingerList.add(LhPinkyFingerData);
                    }
                    if (RhThumbData != null && RhThumbData.length() > 3) {
                        decodeServerData = Base64.decode(RhThumbData, Base64.DEFAULT);
                        savedFingerList.add(RhThumbData);
                    }
                    if (RhIndexFingerData != null && RhIndexFingerData.length() > 3) {
                        decodeServerData = Base64.decode(RhIndexFingerData, Base64.DEFAULT);
                        savedFingerList.add(RhIndexFingerData);
                    }
                    if (RhMiddleFingerData != null && RhMiddleFingerData.length() > 3) {
                        decodeServerData = Base64.decode(RhMiddleFingerData, Base64.DEFAULT);
                        savedFingerList.add(RhMiddleFingerData);
                    }
                    if (RhRingFingerData != null && RhRingFingerData.length() > 3) {
                        decodeServerData = Base64.decode(RhRingFingerData, Base64.DEFAULT);
                        savedFingerList.add(RhRingFingerData);
                    }
                    if (RhPinkyFingerData != null && RhPinkyFingerData.length() > 3) {
                        decodeServerData = Base64.decode(RhPinkyFingerData, Base64.DEFAULT);
                        savedFingerList.add(RhPinkyFingerData);
                    }
                    iRetValRes = -1;
                    for (int i = 0; i < savedFingerList.size(); i++) {

                        //iRetValRes = fps.iFpsVerifyTemplate(Base64.decode(savedFingerList.get(i), Base64.DEFAULT), new FpsConfig(0, (byte) 0x0f));
                        iRetValRes = fps.iFpsVerifyMinutiae(Base64.decode(savedFingerList.get(i), Base64.DEFAULT), new FpsConfig(0, (byte) 0x0f));
                        if (iRetValRes == -5)
                            break;

                    }

                    ResultWrapper resultWrapper = new ResultWrapper(matchOrCaputre, iRetValRes, "", "", encodedStringforConversion);

                    return resultWrapper;


                }


            } else {
                // Toast.makeText(MainActivity.this, "BT device not configured.\nON device Bluetooth button.", Toast.LENGTH_SHORT).show();
                Log.d("ERROR!!!", "BT device not configured.\\nON device Bluetooth button.");
            }
            iRetValRes = -100;
            ResultWrapper resultWrapper = new ResultWrapper(matchOrCaputre, iRetValRes, "", "", encodedStringforConversion);

            return resultWrapper;
            // return  retVal;


        }        /* displays the progress dialog until background task is completed */

        @Override
        protected void onPreExecute() {
            Log.d("In preexecute", "Place your finger on FPS ...");
            progressDialog(MainActivity.this, "Place your finger on FPS ...");
            Log.d("In preexecute", "Place your finger on FPS ...");
            super.onPreExecute();
        }

        /*
         * This function sends message to handler to display the status messages
         * of Diagnose in the dialog box
         */
        @Override
        protected void onPostExecute(ResultWrapper wrapper) {
            dlgPg.dismiss();

            if (wrapper.matchOrCaputre.equalsIgnoreCase("capture")) {
                if (wrapper.resultCode > 0) {
                    // Toast.makeText(MainActivity.this, "SUCCESS", Toast.LENGTH_SHORT).show();
                    // result.success(wrapper);
                    // HashMap hashMap  = new HashMap();

                    JSONObject jObjectData = new JSONObject();


                    // Create Json Object Data
                    try {
                        jObjectData.put("FINGERDATA", wrapper.base64FingerData);
                        jObjectData.put("IMAGEDATA", wrapper.encodedStringforConversion);
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }


                    // result.success(
                    // "{\"FINGERDATA\":\"wrapper.base64FingerData}\",\"IMAGEDATA\":\"${wrapper.encodedStringforConversion}\"}");
                    // result.success(wrapper);
                    result.success(jObjectData.toString());
                    Log.d("FP Match Result", "SUCCESS");

                } else if (wrapper.resultCode == FPS.FAILURE) {
                    Toast.makeText(MainActivity.this, "FAILURE", Toast.LENGTH_SHORT).show();
                    result.success(wrapper.base64FingerData);
                    Log.d("FP Match Result", "FAILURE");
                } else if (wrapper.resultCode == DEVICE_NOTCONNECTED) {
                    Toast.makeText(MainActivity.this, "Device not Connected!!", Toast.LENGTH_SHORT).show();
                    Log.d("FPS", "Device not Connected");

                } else if (wrapper.resultCode == NO_ERROR) {
                    Toast.makeText(MainActivity.this, "Finger not found!!", Toast.LENGTH_SHORT).show();
                    result.success(wrapper.base64FingerData);
                    Log.d("FPS", "Finger not found");

                } else if (wrapper.resultCode == TIME_OUT) {
                    Log.d("FP Capture Result", "TIME OUT");
                    result.success(wrapper.base64FingerData);
                    Toast.makeText(MainActivity.this, "TIME OUT !! Please Try again", Toast.LENGTH_SHORT).show();
                }

                mCallback.onTaskComplete(wrapper.resultCode);
                super.onPostExecute(wrapper);


            } else if (wrapper.matchOrCaputre.equalsIgnoreCase("match")) {
                if (iRetValRes == FPS.SUCCESS) {
                    Toast.makeText(MainActivity.this, "SUCCESS", Toast.LENGTH_SHORT).show();
                    result.success(Integer.toString(wrapper.resultCode));
                    Log.d("FP Match Result", "SUCCESS");

                } else if (iRetValRes == FPS.FAILURE) {
                    Toast.makeText(MainActivity.this, "FAILURE", Toast.LENGTH_SHORT).show();
                    result.success(Integer.toString(wrapper.resultCode));
                    Log.d("FP Match Result", "FAILURE");
                } else if (iRetValRes == DEVICE_NOTCONNECTED) {
                    Toast.makeText(MainActivity.this, "Device not Connected!!", Toast.LENGTH_SHORT).show();
                    Log.d("FPS", "Device not Connected");

                } else if (iRetValRes == NO_ERROR) {
                    Toast.makeText(MainActivity.this, "Finger not found!!", Toast.LENGTH_SHORT).show();
                    result.success(Integer.toString(wrapper.resultCode));
                    Log.d("FPS", "Finger not found");

                } else if (iRetValRes == TIME_OUT) {
                    Log.d("FP Capture Result", "TIME OUT");
                    result.success(Integer.toString(wrapper.resultCode));
                    Toast.makeText(MainActivity.this, "TIME OUT !! Please Try again", Toast.LENGTH_SHORT).show();
                }

                mCallback.onTaskComplete(wrapper.resultCode);
                super.onPostExecute(wrapper);


            }
        }
    }

    public class VerifyTempParams {
        String bleAddress;
        String matchOrCaputre;
        String fingerType;
        String userType;
        String LhThumbValue;
        String LhIndexFingerValue;
        String LhMiddleFingerValue;
        String LhRingFingerValue;
        String LhPinkyFingerValue;

        String RhThumbValue;
        String RhIndexFingerValue;
        String RhMiddleFingerValue;
        String RhRingFingerValue;
        String RhPinkyFingerValue;


        public VerifyTempParams(String bleAddress, String matchOrCaputre, String fingerType, String userType,
                                String LhThumbValue, String LhIndexFingerValue, String LhMiddleFingerValue, String LhRingFingerValue, String LhPinkyFingerValue,
                                String RhThumbValue, String RhIndexFingerValue, String RhMiddleFingerValue, String RhRingFingerValue, String RhPinkyFingerValue) {
            this.bleAddress = bleAddress;
            this.matchOrCaputre = matchOrCaputre;
            this.fingerType = fingerType;
            this.userType = userType;

            this.LhThumbValue = LhThumbValue;
            this.LhIndexFingerValue = LhIndexFingerValue;
            this.LhMiddleFingerValue = LhMiddleFingerValue;
            this.LhRingFingerValue = LhRingFingerValue;
            this.LhPinkyFingerValue = LhPinkyFingerValue;

            this.RhThumbValue = RhThumbValue;
            this.RhIndexFingerValue = RhIndexFingerValue;
            this.RhMiddleFingerValue = RhMiddleFingerValue;
            this.RhRingFingerValue = RhRingFingerValue;
            this.RhPinkyFingerValue = RhPinkyFingerValue;


        }


    }

    public class ResultWrapper {

        String matchOrCaputre;
        Integer resultCode;
        String base64FingerData;
        String userType;
        String encodedStringforConversion;


        public ResultWrapper(String matchOrCaputre, Integer resultCode, String base64FingerData, String userType, String encodedStringforConversion) {
            this.matchOrCaputre = matchOrCaputre;
            this.resultCode = resultCode;
            this.base64FingerData = base64FingerData;
            this.userType = userType;
            this.encodedStringforConversion = encodedStringforConversion;

        }

    }

    /**
     * class for giving input to the AsyncTask for printing
     *
     * @author ujjwal.kumar
     */
    public class PrintingParams {
        int callValue;
        String bleAddress;
        String mlbrcode;
        String mbramchname;
        String date;
        String prdAccId;
        String mlongname;
        String macttotballcy;

        String repeatedStringEntryDate;
        String repeatedStringAmount;
        String repeatedStringDrCr;
        String repeatedStringRemarks;
        String projectName;

        String trefno;
        String repeatedStringCustomerNumber;
        String branchName;
        String centerName;
        String total;
        String header;


        public PrintingParams(int callValue, String bleAddress, String mlbrcode, String mbramchname, String date, String prdAccId, //6
                              String mlongname, String macttotballcy, String repeatedStringEntryDate, String repeatedStringAmount, //10
                              String repeatedStringDrCr, String repeatedStringRemarks, String projectName, String trefno,//14
                               String repeatedStringCustomerNumber, String branchName, String centerName, String total,String header) { //19
            this.callValue = callValue;
            this.bleAddress = bleAddress;
            this.mlbrcode = mlbrcode;
            this.mbramchname = mbramchname;
            this.date = date;
            this.prdAccId = prdAccId;
            this.mlongname = mlongname;
            this.macttotballcy = macttotballcy;
            this.repeatedStringEntryDate = repeatedStringEntryDate;
            this.repeatedStringAmount = repeatedStringAmount;
            this.repeatedStringDrCr = repeatedStringDrCr;
            this.repeatedStringRemarks = repeatedStringRemarks;
            this.projectName = projectName;
            this.trefno = trefno;
            this.repeatedStringCustomerNumber = repeatedStringCustomerNumber;
            this.branchName = branchName;
            this.centerName = centerName;
            this.total = total;
            this.header = header;
        }
    }

    /**
     * Async Task for Printing
     *
     * @author ujjwal.kumar
     */
    public class PrintAsync extends AsyncTask<PrintingParams, Integer, String> {
        private TaskCompleted mCallback;
        private Context mContext;
        private Result result;

        public PrintAsync(Context context, Result result) {
            this.mContext = context;
            this.mCallback = (TaskCompleted) context;
            this.result = result;
        }

        /* Task of VerifyTempleAsync performing in the background */
        /* displays the progress dialog until background task is completed */
        @Override
        protected String doInBackground(PrintingParams... printingParams) {
            String prtRetVal = "";

            int callValue = printingParams[0].callValue;
            String bleAddress = printingParams[0].bleAddress;
            String mlbrcode = printingParams[0].mlbrcode;
            String mbramchname = printingParams[0].mbramchname;
            String date = printingParams[0].date;
            String prdAccId = printingParams[0].prdAccId;
            String mlongname = printingParams[0].mlongname;
            String macttotballcy = printingParams[0].macttotballcy;
            String repeatedStringEntryDate = printingParams[0].repeatedStringEntryDate;
            String repeatedStringAmount = printingParams[0].repeatedStringAmount;
            String repeatedStringDrCr = printingParams[0].repeatedStringDrCr;
            String repeatedStringRemarks = printingParams[0].repeatedStringRemarks;
            String projectName = printingParams[0].projectName;


            String trefno = printingParams[0].trefno;
            String repeatedStringCustomerNumber = printingParams[0].repeatedStringCustomerNumber;
            String branchName = printingParams[0].branchName;
            String centerName = printingParams[0].centerName;
            String total = printingParams[0].total;
            String header = printingParams[0].header;


            if (callValue == 1) {
                // Cocde for Printer
                String print_bill = "";
                String SeparationString = "  ";
                try {

                    if (firstTimePrint) {
                        // System.out.println("for second time print");
                        try {

                            try {
                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;

                                if (setupInstance != null)

                                    ptr = new Printer(setupInstance, outSt, inSt);

                            } catch (NullPointerException npe) {
                                npe.printStackTrace();
                            }
                            ptr.iFlushBuf();
                            // testprint = new TestPrintTask();
                            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                Log.e("DiscoverBT SharedPref", "---> Value Selected");
                            else {
                                //testprint.execute(0);
                            }
                        } catch (Exception n) {
                            n.printStackTrace();

                        }
                    } else {

                        if (createConn(bleAddress)) {

                            OutputStream outSt = BluetoothComm.mosOut;
                            InputStream inSt = BluetoothComm.misIn;
                            //  System.out.println("OutputStream " + outSt);
                            //  System.out.println("InputStream " + inSt);
                            // System.out.println("setupInstance " + setupInstance);
                            try {

                                if (setupInstance != null)
                                    ptr = new Printer(setupInstance, outSt, inSt);

                            } catch (NullPointerException npe) {
                                npe.printStackTrace();
                            }

                            try {
                                String[] repeatedDrCrList = repeatedStringDrCr.split("~");
                                String[] repetedEntryDateList = repeatedStringEntryDate.split("~");
                                String[] repeatedAmountList = repeatedStringAmount.split("~");
                                String[] repeatedStringRemarksList = repeatedStringRemarks.split("~");
                                ptr.iFlushBuf();
                                //   System.out.println("before print task ");
                                // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                // iRetVal = ptr.iStartPrinting(1);
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {

                                    for (String head : header.split("~") ){
                                        print_bill += " "+ head+"\n" ;
                                    }  
                                    // print_bill += "  Wasasa MFI S.C  " + "\n";
                                    // print_bill += "  Address: Sebbeta ,Oromia" + "\n";  // name of company
                                    // print_bill += "  Phone: +251 11 338 41 33" + "\n";
                                    print_bill += "  BranchCode: " + mlbrcode + "\n";
                                    print_bill += "  BranchName: " + mbramchname + "\n";
                                    print_bill += "  Date: " + date + "\n";
                                    print_bill += "  Account Id: " + prdAccId + "\n";
                                    print_bill += "  Name: " + mlongname + "\n";

                                    print_bill += "                      \n";
                                    print_bill += " Date   " + "    Amount " + "      DrCr " + "   Remarks \n";
                                    print_bill += "-----------------------------------------\n";
                                    for (int i = 0; i < repeatedDrCrList.length; i++) {

                                       /* String[] repeatedDRCR  = new String[repeatedDrCrList.length] ;

                                                if(repeatedDrCrList[i].equalsIgnoreCase("Dr")){
                                                    repeatedDRCR[i] = "withdraw";
                                                } else if(repeatedDrCrList[i].equalsIgnoreCase("Cr")){
                                                    repeatedDRCR[i] = "deposit";
                                                }*/


                                        int amountLength = repeatedAmountList[i].length();
                                        String additionalAmountSpaces = "";
                                        for (int j = 0; j <= (11 - amountLength); j++) {
                                            additionalAmountSpaces += " ";
                                        }
                                        int remarksLength = repeatedStringRemarksList[i].length();
                                        if (remarksLength <= 12) {
                                            print_bill += repetedEntryDateList[i].toString().substring(0, 10) + SeparationString + repeatedAmountList[i] + additionalAmountSpaces + SeparationString + repeatedDrCrList[i] + SeparationString + repeatedStringRemarksList[i].substring(0, remarksLength) + "\n";
                                            print_bill += "                            " + "\n";
                                        } else if (remarksLength > 12) {
                                            print_bill += repetedEntryDateList[i].toString().substring(0, 10) + SeparationString + repeatedAmountList[i] + additionalAmountSpaces + SeparationString + repeatedDrCrList[i] + SeparationString + repeatedStringRemarksList[i].substring(0, 12) + "\n";

                                            for (int j = 11; j < remarksLength; j += 12) {
                                                //  System.out.println("j"+j);
                                                if (j + 13 < remarksLength) {
                                                    print_bill += "                              " + repeatedStringRemarksList[i].substring(j + 1, j + 13) + "\n";
                                                } else {
                                                    //  System.out.println("Inside else ");
                                                    print_bill += "                              " + repeatedStringRemarksList[i].substring(j + 1, remarksLength) + "\n";
                                                }
                                            }
                                        }
                                        print_bill += "-----------------------------------------\n";
                                    }
                                    print_bill += "  Balance: " + macttotballcy + "\n";
                                    print_bill += "                      \n";
                                    print_bill += "  Issuer Signature: " +" \n";

                                    print_bill += "                      \n";
                                    print_bill += "                      \n";
                                    print_bill += "           *** END ***\n";
                                    print_bill += "                      \n";
                                    print_bill += "                      \n";


                                    ptr.iPrinterAddData((byte) 0x03, print_bill);
                                    ptr.iStartPrinting(1);
                                } else {
                                    ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                }
                            } catch (NullPointerException n) {
                                n.printStackTrace();
                            }
                        } else {
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else if (callValue == 2) { // Calling for printing value for CENTER SAVING COLLECTION

                if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_WASASA)) {
                    // Cocde for Printer
                    String print_coll_group = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //  System.out.println("OutputStream " + outSt);
                                //  System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {
                                    String[] repeatedEntryDate = repeatedStringDrCr.split("~");
                                    String[] repetedAmount = repeatedStringEntryDate.split("~");
                                    String[] repeatedPrdAccId = repeatedStringAmount.split("~");
                                    String[] repeatedStringCustomernumber = repeatedStringCustomerNumber.split("~");
                                    ptr.iFlushBuf();
                                    //    System.out.println("before print task ");
                                    // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                    // iRetVal = ptr.iStartPrinting(1);
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        // print_coll_group += "  Waldaa Aksiyoona Qusannoo fi Liqaa  " + "\n";
                                        // print_coll_group += "         " + "     " + "Wasaasaa \n";// name of company
                                        // print_coll_group += "   Teessoon: Sabbataa ,Oromiyaa" + "\n";  // name of company
                                        // print_coll_group += "   Bilb : +251 11 338 41 33" + "\n";  // name of company
                                        for (String head : header.split("~") ){
                                            print_coll_group += " "+ head+"\n" ;
                                        }  

                                        print_coll_group += "   Ragaa Qusannoon ittiin Sassaabamu  " + "\n";
                                        print_coll_group += "         " + "     " + "(Invoice) \n";// invoice detail caption

                                        print_coll_group += "       Damee: " + mlbrcode + "/" + branchName + "\n";  //Branch code
                                        print_coll_group += "       Guyyaa: " + date + "\n";  // Date
                                        print_coll_group += "       Lakk(:Trefno): " + trefno + "\n";  // TrefNO
                                        print_coll_group += "       Maqaa Garee: " + centerName + "\n";// Gropup name
                                        print_coll_group += " Lakk.   " + "  " + "  Lakkoofsa " + "    " + " Qarshii  \n";
                                        print_coll_group += " Maamila " + "    Herreegaa   \n";
                                        print_coll_group += "--------------------------------------\n";
                                        for (int i = 0; i < repeatedEntryDate.length; i++) {
                                            int amountLength = repetedAmount[i].length();
                                            String additionalAmountSpaces = "";
                                            for (int j = 0; j <= (11 - amountLength); j++) {
                                                additionalAmountSpaces += " ";
                                            }

                                            print_coll_group += repeatedStringCustomernumber[i] + SeparationString + SeparationString + SeparationString + (repeatedPrdAccId[i]) + additionalAmountSpaces + (repetedAmount[i]) + "\n";
                                            print_coll_group += "--------------------------------------\n";
                                        }
                                        print_coll_group += " Dimshaasha : " + total + " \n"; // Total

                                        String valbfrdecml = "";
                                        String valaftrdecml = "";
                                        String afterdecmlparam = "";
                                        if (total.equals("0.00")) {
                                            print_coll_group += "    Jechaan : zeeroo" + " \n";  // Amount in words
                                        } else {
                                            // print_coll_group += "    Jechaan : " + NumberToWordsConverter.convert(Integer.parseInt(total)) + " \n";  // Amount in words
                                            valbfrdecml = total.substring(0, total.indexOf('.'));
                                            valaftrdecml = total.substring(total.indexOf('.') + 1);

                                            if (valaftrdecml.equals("00")) {
                                                afterdecmlparam = " zeeroo";

                                            } else {
                                                afterdecmlparam = NumberToWordsConverter.convert(Integer.parseInt(valaftrdecml),true);
                                            }
                                            print_coll_group += "    Jechaan : " + NumberToWordsConverter.convert(Integer.parseInt(valbfrdecml)) + " saantima " + afterdecmlparam + " \n";  // Amount in words
                                        }


                                        print_coll_group += " Maamila Qarshii Galii Godhee" + " \n";
                                        print_coll_group += "  _______________________________________ " + " \n";
                                        print_coll_group += " Mallattoo:  " + " \n"; // Signature
                                        print_coll_group += " Nama Qarshii Fuudhe:  " + " \n"; // Caption
                                        print_coll_group += " Maqaa:  " + mbramchname + " \n";
                                        print_coll_group += " Mallattoo:  " + " \n"; // // User name


                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "           *** END ***\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";

                                        ptr.iPrinterAddData((byte) 0x03, print_coll_group);
                                        ptr.iStartPrinting(1);

                                        /**
                                         * Added by UJK for image printing
                                         * in this we have to convert the string into bitmap
                                         * then convert it into 24bit bitmap
                                         * then make a byteArrayInputStream and then pass it to the ptr.iBmpprint().
                                         *
                                         */

//                                        Bitmap bitmap = TextGenerator.bmpDrawText(print_coll_group);
//                                        Bitmap bmpfinal = TextGenerator.bmpConvertTo_24Bit(bitmap);//	(ImageWidth.Inch_2,s2, 40, Justify.ALIGN_LEFT, bold);*/
//                                        byte[] bBmpFileData = TextGenerator.bGetBmpFileData(bmpfinal);
//                                        Log.d("bmp", "Result : abt to prn ");
//                                        ByteArrayInputStream bis = new ByteArrayInputStream(bBmpFileData);
//                                        int xx = ptr.iBmpPrint(bis);
//                                        Log.e("bmp1", "Result 1--->: " + xx);


                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                } else {
                    // Cocde for Printer
                    String print_coll_center = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;
                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);
                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();
                            }
                        } else {

                            if (createConn(bleAddress)) {
                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                try {
                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);
                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                try {
                                    String[] repeatedEntryDate = repeatedStringDrCr.split("~");
                                    String[] repetedAmount = repeatedStringEntryDate.split("~");
                                    String[] repeatedPrdAccId = repeatedStringAmount.split("~");
                                    ptr.iFlushBuf();

                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        print_coll_center += "           BranchCode: " + mlbrcode + "\n";
                                        print_coll_center += "       Date: " + date + "\n";
                                        print_coll_center += "           Center Id: " + macttotballcy + "\n";
                                        print_coll_center += "                      \n";
                                        print_coll_center += " Date   " + "    Amount " + "         PrdAccID \n";
                                        print_coll_center += "-----------------------------------------\n";
                                        for (int i = 0; i < repeatedEntryDate.length; i++) {
                                            int amountLength = repetedAmount[i].length();
                                            String additionalAmountSpaces = "";
                                            for (int j = 0; j <= (11 - amountLength); j++) {
                                                additionalAmountSpaces += " ";
                                            }
                                            print_coll_center += repeatedEntryDate[i].toString().substring(0, 10) + SeparationString + repetedAmount[i] + additionalAmountSpaces + SeparationString + (repeatedPrdAccId[i]) + "\n";
                                            print_coll_center += "                            " + "\n";
                                            print_coll_center += "-----------------------------------------\n";
                                        }
                                        print_coll_center += "                      \n";
                                        print_coll_center += "                      \n";
                                        print_coll_center += "           *** END ***\n";
                                        print_coll_center += "                      \n";
                                        print_coll_center += "                      \n";
                                        ptr.iPrinterAddData((byte) 0x03, print_coll_center);
                                        ptr.iStartPrinting(1);
                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                }

            } else if (callValue == 3) { // print saving collection group for wassasa
                if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_WASASA)) {//WASASA MFI S.C
                    // Cocde for Printer
                    String print_coll_group = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //  System.out.println("OutputStream " + outSt);
                                //  System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {
                                    String[] repeatedEntryDate = repeatedStringDrCr.split("~");
                                    String[] repetedAmount = repeatedStringEntryDate.split("~");
                                    String[] repeatedPrdAccId = repeatedStringAmount.split("~");
                                    String[] repeatedStringCustomernumber = repeatedStringCustomerNumber.split("~");
                                    ptr.iFlushBuf();
                                    //    System.out.println("before print task ");
                                    // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                    // iRetVal = ptr.iStartPrinting(1);
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        // print_coll_group += "  Waldaa Aksiyoona Qusannoo fi Liqaa  " + "\n";
                                        // print_coll_group += "         " + "     " + "Wasaasaa \n";// name of company
                                        // print_coll_group += "   Teessoon: Sabbataa ,Oromiyaa" + "\n";  // name of company
                                        // print_coll_group += "   Bilb : +251 11 338 41 33" + "\n";  // name of company
                                        for (String head : header.split("~") ){
                                            print_coll_group += " "+ head+"\n" ;
                                        }  

                                        print_coll_group += "   Ragaa Qusannoon ittiin Sassaabamu  " + "\n";
                                        print_coll_group += "         " + "     " + "(Invoice) \n";// invoice detail caption

                                        print_coll_group += "       Damee: " + mlbrcode + "/" + branchName + "\n";  //Branch code
                                        print_coll_group += "       Guyyaa: " + date + "\n";  // Date
                                        print_coll_group += "       Lakk(:Trefno): " + trefno + "\n";  // TrefNO
                                        print_coll_group += "       Maqaa Garee: " + centerName + "\n";// Gropup name
                                        print_coll_group += " Lakk.   " + "  " + "  Lakkoofsa " + "    " + " Qarshii  \n";
                                        print_coll_group += " Maamila " + "    Herreegaa   \n";
                                        print_coll_group += "--------------------------------------\n";
                                        for (int i = 0; i < repeatedEntryDate.length; i++) {
                                            int amountLength = repetedAmount[i].length();
                                            String additionalAmountSpaces = "";
                                            for (int j = 0; j <= (11 - amountLength); j++) {
                                                additionalAmountSpaces += " ";
                                            }

                                            print_coll_group += repeatedStringCustomernumber[i] + SeparationString + SeparationString + SeparationString + (repeatedPrdAccId[i]) + additionalAmountSpaces + (repetedAmount[i]) + "\n";
                                            print_coll_group += "--------------------------------------\n";
                                        }
                                        print_coll_group += " Dimshaasha : " + total + " \n"; // Total

                                        String valbfrdecml = "";
                                        String valaftrdecml = "";
                                        String afterdecmlparam = "";
                                        if (total.equals("0.00")) {
                                            print_coll_group += "    Jechaan : zeeroo" + " \n";  // Amount in words
                                        } else {
                                            valbfrdecml = total.substring(0, total.indexOf('.'));
                                            valaftrdecml = total.substring(total.indexOf('.') + 1);

                                            if (valaftrdecml.equals("00")) {
                                                afterdecmlparam = " zeeroo";

                                            } else {
                                                afterdecmlparam = NumberToWordsConverter.convert(Integer.parseInt(valaftrdecml),true);
                                            }
                                            print_coll_group += "    Jechaan : " + NumberToWordsConverter.convert(Integer.parseInt(valbfrdecml)) + " saantima " + afterdecmlparam + " \n";  // Amount in words
                                        }

                                        print_coll_group += " Maamila Qarshii Galii Godhee " + " \n";
                                        print_coll_group += "  _______________________________________ " + " \n";
                                        print_coll_group += " Mallattoo:  " + " \n"; // Signature
                                        print_coll_group += " Nama Qarshii Fuudhe:  " + " \n"; // Caption
                                        print_coll_group += " Maqaa:  " + mbramchname + " \n"; // User name
                                        print_coll_group += " Mallattoo:  " + " \n"; // Signature


                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "           *** END ***\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";

                                        ptr.iPrinterAddData((byte) 0x03, print_coll_group);
                                        ptr.iStartPrinting(1);

                                        /**
                                         * Added by UJK for image printing
                                         * in this we have to convert the string into bitmap
                                         * then convert it into 24bit bitmap
                                         * then make a byteArrayInputStream and then pass it to the ptr.iBmpprint().
                                         *
                                         */

//                                        Bitmap bitmap = TextGenerator.bmpDrawText(print_coll_group);
//                                        Bitmap bmpfinal = TextGenerator.bmpConvertTo_24Bit(bitmap);//	(ImageWidth.Inch_2,s2, 40, Justify.ALIGN_LEFT, bold);*/
//                                        byte[] bBmpFileData = TextGenerator.bGetBmpFileData(bmpfinal);
//                                        Log.d("bmp", "Result : abt to prn ");
//                                        ByteArrayInputStream bis = new ByteArrayInputStream(bBmpFileData);
//                                        int xx = ptr.iBmpPrint(bis);
//                                        Log.e("bmp1", "Result 1--->: " + xx);


                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                } else {
                    // Cocde for Printer
                    String print_coll_group = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //  System.out.println("OutputStream " + outSt);
                                //  System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {
                                    String[] repeatedEntryDate = repeatedStringDrCr.split("~");
                                    String[] repetedAmount = repeatedStringEntryDate.split("~");
                                    String[] repeatedPrdAccId = repeatedStringAmount.split("~");
                                    ptr.iFlushBuf();
                                    //    System.out.println("before print task ");
                                    // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                    // iRetVal = ptr.iStartPrinting(1);
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        print_coll_group += "           शाखा क्र्मांक: " + mlbrcode + "\n";
                                        //print_bill += "  BranchName: " + mbramchname + "\n";
                                        print_coll_group += "       दिनांक: " + date + "\n";
                                        print_coll_group += "           Group Id: " + macttotballcy + "\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += " Date   " + "    Amount " + "         PrdAccID \n";
                                        print_coll_group += "-----------------------------------------\n";
                                        for (int i = 0; i < repeatedEntryDate.length; i++) {
                                            int amountLength = repetedAmount[i].length();
                                            String additionalAmountSpaces = "";
                                            for (int j = 0; j <= (11 - amountLength); j++) {
                                                additionalAmountSpaces += " ";
                                            }

                                            print_coll_group += repeatedEntryDate[i].toString().substring(0, 10) + SeparationString + repetedAmount[i] + additionalAmountSpaces + SeparationString + (repeatedPrdAccId[i]) + "\n";
                                            print_coll_group += "                            " + "\n";


                                            print_coll_group += "-----------------------------------------\n";
                                        }
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "           *** END ***\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";

                                        // String test =  "  शाखा क्र्मांक: " + mlbrcode + "\n";

                                        /**
                                         * Added by UJK for image printing
                                         * in this we have to convert the string into bitmap
                                         * then convert it into 24bit bitmap
                                         * then make a byteArrayInputStream and then pass it to the ptr.iBmpprint().
                                         *
                                         */

                                        Bitmap bitmap = TextGenerator.bmpDrawText(print_coll_group);
                                        Bitmap bmpfinal = TextGenerator.bmpConvertTo_24Bit(bitmap);//	(ImageWidth.Inch_2,s2, 40, Justify.ALIGN_LEFT, bold);*/
                                        byte[] bBmpFileData = TextGenerator.bGetBmpFileData(bmpfinal);
                                        Log.d("bmp", "Result : abt to prn ");
                                        ByteArrayInputStream bis = new ByteArrayInputStream(bBmpFileData);
                                        int xx = ptr.iBmpPrint(bis);
                                        Log.e("bmp1", "Result 1--->: " + xx);

                                        //ptr.iPrinterAddData((byte) 0x03, print_coll_group);

                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                }


            } else if (callValue == 4) { // printing for individual saving collection
                if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_WASASA)) {//WASASA MFI S.C
                    // Cocde for Printer
                    String print_coll_group = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //  System.out.println("OutputStream " + outSt);
                                //  System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {
                                    //String[] repeatedEntryDate = repeatedStringDrCr.split("~");
                                    String repetedAmount = repeatedStringEntryDate;
                                    String[] repeatedPrdAccId = repeatedStringAmount.split("~");
                                    String[] repeatedStringCustomernumber = repeatedStringCustomerNumber.split("~");
                                    ptr.iFlushBuf();
                                    //    System.out.println("before print task ");
                                    // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                    // iRetVal = ptr.iStartPrinting(1);
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        // print_coll_group += "  Waldaa Aksiyoona Qusannoo fi Liqaa  " + "\n";
                                        // print_coll_group += "         " + "     " + "Wasaasaa \n";// name of company
                                        // print_coll_group += "   Teessoon: Sabbataa ,Oromiyaa" + "\n";  // name of company
                                        // print_coll_group += "   Bilb : +251 11 338 41 33" + "\n";  // name of company
                                        for (String head : header.split("~") ){
                                            print_coll_group += " "+ head+"\n" ;
                                        }  

                                        print_coll_group += "   Ragaa Qusannoon ittiin Sassaabamu  " + "\n";
                                        print_coll_group += "         " + "     " + "(Invoice) \n";// invoice detail caption

                                        print_coll_group += "    Damee: " + mlbrcode + "/" + branchName + "\n";  //Branch code
                                        print_coll_group += "    Guyyaa: " + date + "\n";  // Date
                                        print_coll_group += "    Lakk(:Trefno): " + trefno + "\n";  // TrefNO
                                        print_coll_group += "    Lakkoofsa Herreegaa: " + repeatedStringAmount + "\n";  // PrdAcctId
                                        print_coll_group += "    Maqaa maamila :  " + mlongname + " \n";//Customer Name
                                        print_coll_group += "    Qarshii Sassaabamee:  " + total + " \n";//Amount Collected

                                        String valbfrdecml = "";
                                        String valaftrdecml = "";
                                        String afterdecmlparam = "";
                                        if (total.equals("0.00")) {
                                            print_coll_group += "    Jechaan : zeeroo" + " \n";  // Amount in words
                                        } else {
                                            valbfrdecml = total.substring(0, total.indexOf('.'));
                                            valaftrdecml = total.substring(total.indexOf('.') + 1);

                                            if (valaftrdecml.equals("00")) {
                                                afterdecmlparam = " zeeroo";

                                            } else { 
                                                afterdecmlparam = NumberToWordsConverter.convert(Integer.parseInt(valaftrdecml),true);
                                            }
                                             print_coll_group += "    Jechaan : " + NumberToWordsConverter.convert(Integer.parseInt(valbfrdecml)) + " saantima " + afterdecmlparam + " \n";  // Amount in words
                                        }

                                        print_coll_group += "    Ibsa :  " + " \n";//User Narration
                                        print_coll_group += " Nama Qarshii Fuudhe:  " + " \n"; // User name
                                        print_coll_group += " Maqaa:  " + mbramchname + " \n"; // User name
                                        print_coll_group += " Mallattoo: ___________  " + " \n"; // Signature

                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "           *** END ***\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";

                                        ptr.iPrinterAddData((byte) 0x03, print_coll_group);
                                        int iReturnvalue = ptr.iStartPrinting(1);
                                        Log.e("printerRETVAL", Integer.toString(iReturnvalue));


                                        /**
                                         * Added by UJK for image printing
                                         * in this we have to convert the string into bitmap
                                         * then convert it into 24bit bitmap
                                         * then make a byteArrayInputStream and then pass it to the ptr.iBmpprint().
                                         *
                                         */

//                                        Bitmap bitmap = TextGenerator.bmpDrawText(print_coll_group);
//                                        Bitmap bmpfinal = TextGenerator.bmpConvertTo_24Bit(bitmap);//	(ImageWidth.Inch_2,s2, 40, Justify.ALIGN_LEFT, bold);*/
//                                        byte[] bBmpFileData = TextGenerator.bGetBmpFileData(bmpfinal);
//                                        Log.d("bmp", "Result : abt to prn ");
//                                        ByteArrayInputStream bis = new ByteArrayInputStream(bBmpFileData);
//                                        int xx = ptr.iBmpPrint(bis);
//                                        Log.e("bmp1", "Result 1--->: " + xx);


                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                } else {
                    // Cocde for Printer
                    String print_coll_cust = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //   System.out.println("OutputStream " + outSt);
                                //   System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {
                                    String[] repeatedEntryDate = repeatedStringDrCr.split("~");
                                    String[] repetedAmount = repeatedStringEntryDate.split("~");
                                    String[] repeatedPrdAccId = repeatedStringAmount.split("~");
                                    ptr.iFlushBuf();
                                    //   System.out.println("before print task ");
                                    // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                    // iRetVal = ptr.iStartPrinting(1);
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        print_coll_cust += "           BranchCode: " + mlbrcode + "\n";
                                        //print_bill += "  BranchName: " + mbramchname + "\n";
                                        print_coll_cust += "       Date: " + date + "\n";
                                        print_coll_cust += "           Cust No  : " + macttotballcy + "\n";
                                        print_coll_cust += "                      \n";
                                        print_coll_cust += " Date   " + "    Amount " + "         PrdAccID \n";
                                        print_coll_cust += "-----------------------------------------\n";
                                        for (int i = 0; i < repeatedEntryDate.length; i++) {
                                            int amountLength = repetedAmount[i].length();
                                            String additionalAmountSpaces = "";
                                            for (int j = 0; j <= (11 - amountLength); j++) {
                                                additionalAmountSpaces += " ";
                                            }

                                            print_coll_cust += repeatedEntryDate[i].toString().substring(0, 10) + SeparationString + repetedAmount[i] + additionalAmountSpaces + SeparationString + (repeatedPrdAccId[i]) + "\n";
                                            print_coll_cust += "                            " + "\n";


                                            print_coll_cust += "-----------------------------------------\n";
                                        }
                                        print_coll_cust += "                      \n";
                                        print_coll_cust += "                      \n";
                                        print_coll_cust += "           *** END ***\n";
                                        print_coll_cust += "                      \n";
                                        print_coll_cust += "                      \n";


                                        ptr.iPrinterAddData((byte) 0x03, print_coll_cust);
                                        ptr.iStartPrinting(1);
                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                }

            } else if (callValue == 5) {
                if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_WASASA)) {
                    // Cocde for Printer
                    String print_coll_today = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //     System.out.println("OutputStream " + outSt);
                                //   System.out.println("InputStream " + inSt);
                                //   System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {
                                    String[] repeatedCustNo = repeatedStringDrCr.split("~");
                                    String[] repetedAmount = repeatedStringEntryDate.split("~");
                                    String[] repeatedPrdAccId = repeatedStringAmount.split("~");
                                    ptr.iFlushBuf();
                                    //     System.out.println("before print task ");
                                    // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                    // iRetVal = ptr.iStartPrinting(1);
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        // print_coll_today += "  Waldaa Aksiyoona Qusannoo fi Liqaa  " + "\n";
                                        // print_coll_today += "         " + "     " + "Wasaasaa \n";// name of company
                                        // print_coll_today += "   Teessoon: Sabbataa ,Oromiyaa" + "\n";  // name of company
                                        // print_coll_today += "   Bilb : +251 11 338 41 33" + "\n";  // name of company
                                        for (String head : header.split("~") ){
                                            print_coll_today += " "+ head+"\n" ;
                                        }  

                                        print_coll_today += "   Ragaa Qusannoon ittiin Sassaabamu  " + "\n";
                                        print_coll_today += "         " + "     " + "(Invoice) \n";// invoice detail caption

                                        print_coll_today += "       Damee: " + mlbrcode + "/" + branchName + "\n";  //Branch code
                                        print_coll_today += "       Guyyaa: " + date + "\n";  // Date
                                        print_coll_today += "       Lakk(:Trefno): " + trefno + "\n";  // TrefNO
                                        print_coll_today += "       Maqaa Garee: " + centerName + "\n";// Gropup name
                                        print_coll_today += " Lakk.   " + "  " + "  Lakkoofsa " + "    " + " Qarshii  \n";
                                        print_coll_today += " Maamila " + "    Herreegaa   \n";
                                        print_coll_today += "--------------------------------------\n";
                                        for (int i = 0; i < repeatedCustNo.length; i++) {
                                            int amountLength = repetedAmount[i].length();
                                            String additionalAmountSpaces = "";
                                            for (int j = 0; j <= (11 - amountLength); j++) {
                                                additionalAmountSpaces += " ";
                                            }

                                            print_coll_today += repeatedCustNo[i] + SeparationString + SeparationString + SeparationString + (repeatedPrdAccId[i]) + additionalAmountSpaces + (repetedAmount[i]) + "\n";
                                            print_coll_today += "--------------------------------------\n";


                                        }
                                        print_coll_today += " Dimshaasha : " + total + " \n"; // Total

                                        String valbfrdecml = "";
                                        String valaftrdecml = "";
                                        String afterdecmlparam = "";
                                        if (total.equals("0.00")) {
                                            print_coll_today += "    Jechaan : zeeroo" + " \n";  // Amount in words
                                        } else {
                                            valbfrdecml = total.substring(0, total.indexOf('.'));
                                            valaftrdecml = total.substring(total.indexOf('.') + 1);

                                            if (valaftrdecml.equals("00")) {
                                                afterdecmlparam = " zeeroo";

                                            } else {
                                                afterdecmlparam = NumberToWordsConverter.convert(Integer.parseInt(valaftrdecml),true);
                                            }
                                            print_coll_today += "    Jechaan : " + NumberToWordsConverter.convert(Integer.parseInt(valbfrdecml)) + " saantima " + afterdecmlparam + " \n";  // Amount in words
                                        }
                                        print_coll_today += " Maamila Qarshii Galii Godhee " + " \n";
                                        print_coll_today += "  _______________________________________ " + " \n";
                                        print_coll_today += " Mallattoo:  " + " \n"; // Signature
                                        print_coll_today += " Nama Qarshii Fuudhe:  " + " \n"; // Caption
                                        print_coll_today += " Maqaa:  " + mbramchname + " \n"; // User name


                                        print_coll_today += "                      \n";
                                        print_coll_today += "                      \n";
                                        print_coll_today += "           *** END ***\n";
                                        print_coll_today += "                      \n";
                                        print_coll_today += "                      \n";


                                        ptr.iPrinterAddData((byte) 0x03, print_coll_today);
                                        ptr.iStartPrinting(1);
                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                } else {
                    // Cocde for Printer
                    String print_coll_today = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //     System.out.println("OutputStream " + outSt);
                                //   System.out.println("InputStream " + inSt);
                                //   System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {
                                    String[] repeatedCustNo = repeatedStringDrCr.split("~");
                                    String[] repetedAmount = repeatedStringEntryDate.split("~");
                                    String[] repeatedPrdAccId = repeatedStringAmount.split("~");
                                    ptr.iFlushBuf();
                                    //     System.out.println("before print task ");
                                    // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                    // iRetVal = ptr.iStartPrinting(1);
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        print_coll_today += "           BranchCode: " + mlbrcode + "\n";
                                        //print_bill += "  BranchName: " + mbramchname + "\n";
                                        print_coll_today += "       Date: " + date + "\n";
                                        print_coll_today += "                      \n";
                                        print_coll_today += "   PrdAccID " + "     Amount " + "       Cust No \n";
                                        print_coll_today += "-----------------------------------------\n";
                                        for (int i = 0; i < repeatedCustNo.length; i++) {
                                            int amountLength = repetedAmount[i].length();
                                            String additionalAmountSpaces = "";
                                            for (int j = 0; j <= (11 - amountLength); j++) {
                                                additionalAmountSpaces += " ";
                                            }

                                            print_coll_today += repeatedPrdAccId[i].toString() + SeparationString + repetedAmount[i] + additionalAmountSpaces + SeparationString + (repeatedCustNo[i]) + "\n";
                                            print_coll_today += "                            " + "\n";


                                            print_coll_today += "-----------------------------------------\n";
                                        }
                                        print_coll_today += "                      \n";
                                        print_coll_today += "                      \n";
                                        print_coll_today += "           *** END ***\n";
                                        print_coll_today += "                      \n";
                                        print_coll_today += "                      \n";


                                        ptr.iPrinterAddData((byte) 0x03, print_coll_today);
                                        ptr.iStartPrinting(1);
                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                }

            } else if (callValue == 6) {

                if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_FULLERTON)) {
                    // printing for cash deposit and withdrawal
                    // Cocde for Printer
                    String print_coll_group = "";
                    String SeparationString = " ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //  System.out.println("OutputStream " + outSt);
                                //  System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {
                                    String[] repeatedEntryDate = repeatedStringDrCr.split("~");
                                    String[] repetedAmount = repeatedStringEntryDate.split("~");
                                    String[] repeatedPrdAccId = repeatedStringAmount.split("~");
                                    ptr.iFlushBuf();
                                    //    System.out.println("before print task ");
                                    // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                    // iRetVal = ptr.iStartPrinting(1);
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        print_coll_group += "   FULLERTON FINANCE MYANMAR Co Ltd " + "\n";
                                        print_coll_group += "         -----------------\n";
                                        print_coll_group += "      ေန႔ရက : " + mlbrcode + "\n";// Date
                                        print_coll_group += "      စာရင္းသြင္းခ်ိန္ :" + mbramchname + "\n";// Time
                                        print_coll_group += "      စုေငြစာရငးအမွတ္ :" + "\n";
                                        print_coll_group += date + "\n"; //voluntaryCompulsorySavingAC
                                        print_coll_group += "      အသငးသားအမည္ :" + "\n";
                                        print_coll_group += prdAccId + "\n";//customerName
                                        print_coll_group += "      စာရင္းသြငး၊ထုတ္အမွတ္စဥ္ :" + "\n";
                                        print_coll_group += mlongname + "\n";//TransactionReference
                                        print_coll_group += "      အသငးသား မွတ္ပံုတင္အမွတ္ :" + "\n";
                                        print_coll_group += macttotballcy + "\n";//CustomerNRCNo

                                        if (trefno.equalsIgnoreCase(Constants.Label_Withdrawal)){
                                            print_coll_group += "      စုေငြ ထုတ္ယူေငြ ပမာဏ :" + "\n";//withdrawal Amount
                                            print_coll_group += repeatedStringEntryDate + "\n";

                                        }else if(trefno.equalsIgnoreCase(Constants.Label_Deposit)){
                                            print_coll_group += "      စုေငြ စုေဆာင္းေငြ ပမာဏ :" + "\n";//DepositAmount
                                            print_coll_group += repeatedStringEntryDate + "\n";

                                        }


                                        print_coll_group += "      လက္က်န္ စုေငြ ပမာဏ :" + "\n";
                                        print_coll_group += repeatedStringAmount + "\n";//Total Balance of Saving
                                        print_coll_group += "      ဆက္သြယ္ရန္ဖံုးနံပါတ္ :" + "\n";
                                        print_coll_group += repeatedStringDrCr + "\n";//Contact Phone No
                                        print_coll_group += "      စာရင္းသြင္းတာဝန္ခံ၏ စာရင္းအမွတ္ :" + "\n";
                                        print_coll_group += repeatedStringRemarks + "\n";//Loan Officers / Transaction Officer Code

                                        print_coll_group += "                            " + "\n";


                                        print_coll_group += "-----------------------------\n";

                                        print_coll_group += "           *** END ***\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";


                                        /**
                                         * Added by UJK for image printing
                                         * in this we have to convert the string into bitmap
                                         * then convert it into 24bit bitmap
                                         * then make a byteArrayInputStream and then pass it to the ptr.iBmpprint().
                                         *
                                         */

                                        Bitmap bitmap = TextGenerator.bmpDrawText(print_coll_group);
                                        Bitmap bmpfinal = TextGenerator.bmpConvertTo_24Bit(bitmap);//	(ImageWidth.Inch_2,s2, 40, Justify.ALIGN_LEFT, bold);*/
                                        byte[] bBmpFileData = TextGenerator.bGetBmpFileData(bmpfinal);
                                        Log.d("bmp", "Result : abt to prn ");
                                        ByteArrayInputStream bis = new ByteArrayInputStream(bBmpFileData);
                                        int xx = ptr.iBmpPrint(bis);
                                        Log.e("bmp1", "Result 1--->: " + xx);

                                        //ptr.iPrinterAddData((byte) 0x03, print_coll_group);

                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                }else if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_WASASA)) {
                    // Print For Wasasa Savings Withdrawal
                    String print_coll_today = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //     System.out.println("OutputStream " + outSt);
                                //   System.out.println("InputStream " + inSt);
                                //   System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {

                                    ptr.iFlushBuf();
                                    //     System.out.println("before print task ");
                                    // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                    // iRetVal = ptr.iStartPrinting(1);
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        // print_coll_today += "  Waldaa Aksiyoona Qusannoo fi Liqaa  " + "\n";
                                        // print_coll_today += "         " + "     " + "Wasaasaa \n";// name of company
                                        // print_coll_today += "   Teessoon: Sabbataa ,Oromiyaa" + "\n";  // name of company
                                        // print_coll_today += "   Bilb : +251 11 338 41 33" + "\n";  // name of company
                                        for (String head : header.split("~") ){
                                            print_coll_today += " "+ head+"\n" ;
                                        }
                                        print_coll_today += "--------------------------------------\n";
                                        print_coll_today += "   Ragaa Qusannoon ittiin Bahu " + "\n";
                                        print_coll_today += "         " + "     " + "(Invoice) \n";// invoice detail caption
                                        print_coll_today += "--------------------------------------\n";

                                        print_coll_today += "  Damee: " + repeatedStringCustomerNumber + "\n";  //Branch code
                                        print_coll_today += "  Guyyaa: " + mlbrcode + "\n";  // Date
                                        print_coll_today += "  Lakk(refno): " + mlongname + "\n";  // TrefNO
                                        print_coll_today += "  Lakkoofsa Herreegaa: " + date + "\n";// Account Number:
                                        print_coll_today += "  Maqaa Maamila: "+ prdAccId+"\n"; // Customer Name:
                                        print_coll_today += "  Hanga Qarshii: "+ repeatedStringEntryDate + "     \n"; //Withdrawal Amount:

                                        String valbfrdecml = "";
                                        String valaftrdecml = "";
                                        String afterdecmlparam = "";
                                        if (repeatedStringEntryDate.equals("0.00")) {
                                            print_coll_today += "  Jechaan : zeeroo" + " \n";  // Amount in words
                                        } else {
                                            valbfrdecml = repeatedStringEntryDate.substring(0, repeatedStringEntryDate.indexOf('.'));
                                            valaftrdecml = repeatedStringEntryDate.substring(repeatedStringEntryDate.indexOf('.') + 1);

                                            if (valaftrdecml.equals("00")) {
                                                afterdecmlparam = " zeeroo";

                                            } else {
                                                afterdecmlparam = NumberToWordsConverter.convert(Integer.parseInt(valaftrdecml),true);
                                            }
                                            print_coll_today += "  Jechaan : " + NumberToWordsConverter.convert(Integer.parseInt(valbfrdecml)) + " saantima " + afterdecmlparam + " \n";  // Amount in words
                                        }
                                        print_coll_today += "  Nama Qopheesse : " + " \n";
                                        print_coll_today += "  Maqaa:  " + branchName +" \n";   //FONAME
                                        print_coll_today += "  Mallattoo:  " + " \n";
                                        print_coll_today += "   " + " \n";
                                        print_coll_today += "  Nama Qarshii Kaffale:  " + " \n";
                                        print_coll_today += "  Maqaa:  "  + " \n";
                                        print_coll_today += "  Mallattoo::  " + " \n";
                                        print_coll_today += "  Nama Mirkaneesse:  " + " \n";
                                        print_coll_today += "  Maqaa:  " + " \n";
                                        print_coll_today += "  Mallattoo:  " + " \n";
                                        print_coll_today += "  Mallattoo Maamilaa:  " + " \n";



                                        print_coll_today += "                      \n";
                                        print_coll_today += "                      \n";
                                        print_coll_today += "           *** END ***\n";
                                        print_coll_today += "                      \n";
                                        print_coll_today += "                      \n";

                                        ptr.iPrinterAddData((byte) 0x03, print_coll_today);
                                        ptr.iStartPrinting(1);
                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                }


            } else if (callValue == 7) {
                if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_WASASA)) {
                    // Cocde for Printer
                    String print_coll_group = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //  System.out.println("OutputStream " + outSt);
                                //  System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {
                                    String[] repeatedEntryDate = repeatedStringDrCr.split("~");
                                    String[] repetedAmount = repeatedStringEntryDate.split("~");
                                    String[] repeatedPrdAccId = repeatedStringAmount.split("~");
                                    String[] repeatedStringCustomernumber = repeatedStringCustomerNumber.split("~");
                                    ptr.iFlushBuf();
                                    //    System.out.println("before print task ");
                                    // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                    // iRetVal = ptr.iStartPrinting(1);
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        // print_coll_group += "  Waldaa Aksiyoona Qusannoo fi Liqaa  " + "\n";
                                        // print_coll_group += "         " + "     " + "Wasaasaa \n";// name of company
                                        // print_coll_group += "   Teessoon: Sabbataa ,Oromiyaa" + "\n";  // name of company
                                        // print_coll_group += "   Bilb : +251 11 338 41 33" + "\n";  // name of company
                                        for (String head : header.split("~") ){
                                            print_coll_group += " "+ head+"\n" ;
                                        }  
                                        

                                        print_coll_group += "   Ragaa Liqaa ittiin Sassaabamu (Invoice)  " + "\n";
                                        print_coll_group += "         " + "     " + "(Invoice) \n";// invoice detail caption

                                        print_coll_group += "       Damee: " + mlbrcode + "/" + branchName + "\n";  //Branch code
                                        print_coll_group += "       Guyyaa: " + date + "\n";  // Date
                                        print_coll_group += "       Lakk(:Trefno): " + trefno + "\n";  // TrefNO
                                        print_coll_group += "       Maqaa Garee: " + centerName + "\n";// Gropup name
                                        print_coll_group += " Lakk.   " + "  " + "  Lakkoofsa " + "    " + " Qarshii  \n";
                                        print_coll_group += " Maamila " + "    Herreegaa   \n";
                                        print_coll_group += "--------------------------------------\n";
                                        for (int i = 0; i < repeatedEntryDate.length; i++) {
                                            int amountLength = repetedAmount[i].length();
                                            String additionalAmountSpaces = "";
                                            for (int j = 0; j <= (11 - amountLength); j++) {
                                                additionalAmountSpaces += " ";
                                            }

                                            print_coll_group += repeatedStringCustomernumber[i] + SeparationString + SeparationString + SeparationString + (repeatedPrdAccId[i]) + additionalAmountSpaces + (repetedAmount[i]) + "\n";
                                            print_coll_group += "--------------------------------------\n";
                                        }
                                        print_coll_group += " Dimshaasha : " + total + " \n"; // Total

                                        String valbfrdecml = "";
                                        String valaftrdecml = "";
                                        String afterdecmlparam = "";
                                        if (total.equals("0.00")) {
                                            print_coll_group += "    Jechaan : zeeroo" + " \n";  // Amount in words
                                        } else {
                                            valbfrdecml = total.substring(0, total.indexOf('.'));
                                            valaftrdecml = total.substring(total.indexOf('.') + 1);

                                            if (valaftrdecml.equals("00")) {
                                                afterdecmlparam = " zeeroo";

                                            } else {
                                                afterdecmlparam = NumberToWordsConverter.convert(Integer.parseInt(valaftrdecml),true);
                                            }
                                            print_coll_group += " Jechaan : " + NumberToWordsConverter.convert(Integer.parseInt(valbfrdecml)) + " saantima " + afterdecmlparam + " \n";  // Amount in words
                                        }

                                        print_coll_group += " Maamila Qarshii Galii Godhee  " + " \n";
                                        print_coll_group += "  _______________________________________ " + " \n";
                                        print_coll_group += " Mallattoo:  " + " \n"; // Signature
                                        print_coll_group += " Nama Qarshii Fuudhe:  " + " \n"; // Caption
                                        print_coll_group += " Maqaa:  " + mbramchname + " \n"; // User name
                                        print_coll_group += " Mallattoo:  " + " \n"; // Signature


                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "           *** END ***\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";

                                        ptr.iPrinterAddData((byte) 0x03, print_coll_group);
                                        ptr.iStartPrinting(1);

                                        /**
                                         * Added by UJK for image printing
                                         * in this we have to convert the string into bitmap
                                         * then convert it into 24bit bitmap
                                         * then make a byteArrayInputStream and then pass it to the ptr.iBmpprint().
                                         *
                                         */

//                                        Bitmap bitmap = TextGenerator.bmpDrawText(print_coll_group);
//                                        Bitmap bmpfinal = TextGenerator.bmpConvertTo_24Bit(bitmap);//	(ImageWidth.Inch_2,s2, 40, Justify.ALIGN_LEFT, bold);*/
//                                        byte[] bBmpFileData = TextGenerator.bGetBmpFileData(bmpfinal);
//                                        Log.d("bmp", "Result : abt to prn ");
//                                        ByteArrayInputStream bis = new ByteArrayInputStream(bBmpFileData);
//                                        int xx = ptr.iBmpPrint(bis);
//                                        Log.e("bmp1", "Result 1--->: " + xx);


                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                } else {
                    // Cocde for Printer
                    String print_coll_center = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;
                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);
                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();
                            }
                        } else {

                            if (createConn(bleAddress)) {
                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                try {
                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);
                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                try {
                                    String[] repeatedEntryDate = repeatedStringDrCr.split("~");
                                    String[] repetedAmount = repeatedStringEntryDate.split("~");
                                    String[] repeatedPrdAccId = repeatedStringAmount.split("~");
                                    ptr.iFlushBuf();

                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        print_coll_center += "           BranchCode: " + mlbrcode + "\n";
                                        print_coll_center += "       Date: " + date + "\n";
                                        print_coll_center += "           Center Id: " + macttotballcy + "\n";
                                        print_coll_center += "                      \n";
                                        print_coll_center += " Date   " + "    Amount " + "         PrdAccID \n";
                                        print_coll_center += "-----------------------------------------\n";
                                        for (int i = 0; i < repeatedEntryDate.length; i++) {
                                            int amountLength = repetedAmount[i].length();
                                            String additionalAmountSpaces = "";
                                            for (int j = 0; j <= (11 - amountLength); j++) {
                                                additionalAmountSpaces += " ";
                                            }
                                            print_coll_center += repeatedEntryDate[i].toString().substring(0, 10) + SeparationString + repetedAmount[i] + additionalAmountSpaces + SeparationString + (repeatedPrdAccId[i]) + "\n";
                                            print_coll_center += "                            " + "\n";
                                            print_coll_center += "-----------------------------------------\n";
                                        }
                                        print_coll_center += "                      \n";
                                        print_coll_center += "                      \n";
                                        print_coll_center += "           *** END ***\n";
                                        print_coll_center += "                      \n";
                                        print_coll_center += "                      \n";
                                        ptr.iPrinterAddData((byte) 0x03, print_coll_center);
                                        ptr.iStartPrinting(1);
                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                }

            } else if (callValue == 8) {
                if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_WASASA)) {//WASASA MFI S.C
                    // Cocde for Printer
                    String print_coll_group = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //  System.out.println("OutputStream " + outSt);
                                //  System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {
                                    String[] repeatedEntryDate = repeatedStringDrCr.split("~");
                                    String[] repetedAmount = repeatedStringEntryDate.split("~");
                                    String[] repeatedPrdAccId = repeatedStringAmount.split("~");
                                    String[] repeatedStringCustomernumber = repeatedStringCustomerNumber.split("~");
                                    ptr.iFlushBuf();
                                    //    System.out.println("before print task ");
                                    // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                    // iRetVal = ptr.iStartPrinting(1);
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        // print_coll_group += "  Waldaa Aksiyoona Qusannoo fi Liqaa  " + "\n";
                                        // print_coll_group += "         " + "     " + "Wasaasaa \n";// name of company
                                        // print_coll_group += "   Teessoon: Sabbataa ,Oromiyaa" + "\n";  // name of company
                                        // print_coll_group += "   Bilb : +251 11 338 41 33" + "\n";  // name of company
                                        for (String head : header.split("~") ){
                                            print_coll_group += " "+ head+"\n" ;
                                        }  
                                        print_coll_group += "   Ragaa Liqaa ittiin Sassaabamu  " + "\n";
                                        print_coll_group += "         " + "     " + "(Invoice) \n";// invoice detail caption

                                        print_coll_group += "       Damee: " + mlbrcode + "/" + branchName + "\n";  //Branch code
                                        print_coll_group += "       Guyyaa: " + date + "\n";  // Date
                                        print_coll_group += "       Lakk(:Trefno): " + trefno + "\n";  // TrefNO
                                        print_coll_group += "       Maqaa Garee: " + centerName + "\n";// Gropup name
                                        print_coll_group += " Lakk.   " + "  " + "  Lakkoofsa " + "    " + " Qarshii  \n";
                                        print_coll_group += " Maamila " + "    Herreegaa   \n";
                                        print_coll_group += "--------------------------------------\n";
                                        for (int i = 0; i < repeatedEntryDate.length; i++) {
                                            int amountLength = repetedAmount[i].length();
                                            String additionalAmountSpaces = "";
                                            for (int j = 0; j <= (11 - amountLength); j++) {
                                                additionalAmountSpaces += " ";
                                            }

                                            print_coll_group += repeatedStringCustomernumber[i] + SeparationString + SeparationString + SeparationString + (repeatedPrdAccId[i]) + additionalAmountSpaces + (repetedAmount[i]) + "\n";
                                            print_coll_group += "--------------------------------------\n";
                                        }
                                        print_coll_group += " Dimshaasha : " + total + " \n"; // Total

                                        String valbfrdecml = "";
                                        String valaftrdecml = "";
                                        String afterdecmlparam = "";
                                        if (total.equals("0.00")) {
                                            print_coll_group += "    Jechaan : zeeroo" + " \n";  // Amount in words
                                        } else {
                                            valbfrdecml = total.substring(0, total.indexOf('.'));
                                            valaftrdecml = total.substring(total.indexOf('.') + 1);

                                            if (valaftrdecml.equals("00")) {
                                                afterdecmlparam = " zeeroo";

                                            } else {
                                                afterdecmlparam = NumberToWordsConverter.convert(Integer.parseInt(valaftrdecml),true);
                                            }
                                            print_coll_group += "    Jechaan : " + NumberToWordsConverter.convert(Integer.parseInt(valbfrdecml)) + " saantima " + afterdecmlparam + " \n";  // Amount in words
                                        }





                                        print_coll_group += " Maamila Qarshii Galii Godhee " + " \n";
                                        print_coll_group += "  _______________________________________ " + " \n";
                                        print_coll_group += " Mallattoo:  " + " \n"; // Signature
                                        print_coll_group += " Nama Qarshii Fuudhe:  " + " \n"; // Caption
                                        print_coll_group += " Maqaa:  " + mbramchname + " \n";
                                        print_coll_group += " Mallattoo:  " + " \n"; // Signature// User name


                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "           *** END ***\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";

                                        ptr.iPrinterAddData((byte) 0x03, print_coll_group);
                                        ptr.iStartPrinting(1);

                                        /**
                                         * Added by UJK for image printing
                                         * in this we have to convert the string into bitmap
                                         * then convert it into 24bit bitmap
                                         * then make a byteArrayInputStream and then pass it to the ptr.iBmpprint().
                                         *
                                         */

//                                        Bitmap bitmap = TextGenerator.bmpDrawText(print_coll_group);
//                                        Bitmap bmpfinal = TextGenerator.bmpConvertTo_24Bit(bitmap);//	(ImageWidth.Inch_2,s2, 40, Justify.ALIGN_LEFT, bold);*/
//                                        byte[] bBmpFileData = TextGenerator.bGetBmpFileData(bmpfinal);
//                                        Log.d("bmp", "Result : abt to prn ");
//                                        ByteArrayInputStream bis = new ByteArrayInputStream(bBmpFileData);
//                                        int xx = ptr.iBmpPrint(bis);
//                                        Log.e("bmp1", "Result 1--->: " + xx);


                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                } else if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_FULLERTON)) {
                    // Cocde for Printer
                    String print_coll_group = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //  System.out.println("OutputStream " + outSt);
                                //  System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {
                                    String[] repeatedCustID = macttotballcy.split("~");
                                    String[] repetedCustName = repeatedStringEntryDate.split("~");
                                    String[] repeatedAmount = repeatedStringAmount.split("~");
                                    ptr.iFlushBuf();
                                    //    System.out.println("before print task ");
                                    // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                    // iRetVal = ptr.iStartPrinting(1);
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        print_coll_group += "   FULLERTON FINANCE MYANMAR Co Ltd " + "\n";
                                        print_coll_group += "         -----------------\n";
                                        print_coll_group += "      ေန႔ရက္ : " + "\n";//Date
                                        print_coll_group += mlbrcode + "\n";
                                        print_coll_group += "      စာရင္းသြင္းခ်ိန္ :" + "\n";//Transaction Time
                                        print_coll_group += mbramchname + "\n";
                                        print_coll_group += "      စာရင္းသြင္း၊ထုတ္အမွတ္စဥ္ :" + "\n";//Transaction Reference
                                        print_coll_group += date + "\n";
                                        print_coll_group += "      အုပ္စုၿပန္လည္ေပးဆပ္ေငြ လက္ခံရရွိၿခင္း" + "\n";//Group Wise Loan Repayment Deposit Receipts
                                        print_coll_group += "      အုပ္စုအမွတ္:"+prdAccId + "\n";//Group ID No
                                        print_coll_group += "      စုရပ္အမွတ္ :"+mlongname + "\n";//Center No
                                        print_coll_group += "                      \n";
                                        for (int i = 0; i < repeatedCustID.length; i++) {
                                            int amountLength = repeatedAmount[i].length();
                                            String additionalAmountSpaces = "";
                                            for (int j = 0; j <= (11 - amountLength); j++) {
                                                additionalAmountSpaces += " ";
                                            }
                                            print_coll_group += "--------------------------------------\n";
                                            print_coll_group += "အသင္းသား အမွတ္" + "\n";
                                            print_coll_group += repeatedCustID[i]+ "\n";
                                            print_coll_group += "အသင္းသား အမည္" + "\n";
                                            print_coll_group += repetedCustName[i]+ "\n";
                                            print_coll_group += "စုစုေပါင္း ေပးသြင္းေငြ" + "\n";
                                            print_coll_group += repeatedAmount[i]+ "\n";
                                            print_coll_group += "--------------------------------------\n";
                                        }

                                        print_coll_group += "      အုပ္စု၏စုစုေပါင္း ေပးသြင္းေငြ :" + "\n";//Total Repayment Amount of group
                                        print_coll_group += repeatedStringDrCr + "\n";
                                        print_coll_group += "      ဆက္သြယ္ရန္ဖံုးနံပါတ္ :" + "\n";//Contact Phone No
                                        print_coll_group += repeatedStringRemarks + "\n";
                                        print_coll_group += "      စာရင္းသြင္းတာဝန္ခံ၏ စာရင္းအမွတ္ :" + "\n";//Loan Officers/Transaction Officer Code
                                        print_coll_group += trefno + "\n";


                                        print_coll_group += "-----------------------------\n";

                                        print_coll_group += "           *** END ***\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";


                                        /**
                                         * Added by UJK for image printing
                                         * in this we have to convert the string into bitmap
                                         * then convert it into 24bit bitmap
                                         * then make a byteArrayInputStream and then pass it to the ptr.iBmpprint().
                                         *
                                         */

                                        Bitmap bitmap = TextGenerator.bmpDrawText(print_coll_group);
                                        Bitmap bmpfinal = TextGenerator.bmpConvertTo_24Bit(bitmap);//	(ImageWidth.Inch_2,s2, 40, Justify.ALIGN_LEFT, bold);*/
                                        byte[] bBmpFileData = TextGenerator.bGetBmpFileData(bmpfinal);
                                        Log.d("bmp", "Result : abt to prn ");
                                        ByteArrayInputStream bis = new ByteArrayInputStream(bBmpFileData);
                                        int xx = ptr.iBmpPrint(bis);
                                        Log.e("bmp1", "Result 1--->: " + xx);

                                        //ptr.iPrinterAddData((byte) 0x03, print_coll_group);

                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                } else {
                    // Cocde for Printer
                    String print_coll_group = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //  System.out.println("OutputStream " + outSt);
                                //  System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {
                                    String[] repeatedEntryDate = repeatedStringDrCr.split("~");
                                    String[] repetedAmount = repeatedStringEntryDate.split("~");
                                    String[] repeatedPrdAccId = repeatedStringAmount.split("~");
                                    ptr.iFlushBuf();
                                    //    System.out.println("before print task ");
                                    // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                    // iRetVal = ptr.iStartPrinting(1);
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        print_coll_group += "           शाखा क्र्मांक: " + mlbrcode + "\n";
                                        //print_bill += "  BranchName: " + mbramchname + "\n";
                                        print_coll_group += "       दिनांक: " + date + "\n";
                                        print_coll_group += "           Group Id: " + macttotballcy + "\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += " Date   " + "    Amount " + "         PrdAccID \n";
                                        print_coll_group += "-----------------------------------------\n";
                                        for (int i = 0; i < repeatedEntryDate.length; i++) {
                                            int amountLength = repetedAmount[i].length();
                                            String additionalAmountSpaces = "";
                                            for (int j = 0; j <= (11 - amountLength); j++) {
                                                additionalAmountSpaces += " ";
                                            }

                                            print_coll_group += repeatedEntryDate[i].toString().substring(0, 10) + SeparationString + repetedAmount[i] + additionalAmountSpaces + SeparationString + (repeatedPrdAccId[i]) + "\n";
                                            print_coll_group += "                            " + "\n";


                                            print_coll_group += "-----------------------------------------\n";
                                        }
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "           *** END ***\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";

                                        // String test =  "  शाखा क्र्मांक: " + mlbrcode + "\n";

                                        /**
                                         * Added by UJK for image printing
                                         * in this we have to convert the string into bitmap
                                         * then convert it into 24bit bitmap
                                         * then make a byteArrayInputStream and then pass it to the ptr.iBmpprint().
                                         *
                                         */

                                        Bitmap bitmap = TextGenerator.bmpDrawText(print_coll_group);
                                        Bitmap bmpfinal = TextGenerator.bmpConvertTo_24Bit(bitmap);//	(ImageWidth.Inch_2,s2, 40, Justify.ALIGN_LEFT, bold);*/
                                        byte[] bBmpFileData = TextGenerator.bGetBmpFileData(bmpfinal);
                                        Log.d("bmp", "Result : abt to prn ");
                                        ByteArrayInputStream bis = new ByteArrayInputStream(bBmpFileData);
                                        int xx = ptr.iBmpPrint(bis);
                                        Log.e("bmp1", "Result 1--->: " + xx);

                                        //ptr.iPrinterAddData((byte) 0x03, print_coll_group);

                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                }
// calling for loan customer collection

            } else if (callValue == 9) {
                if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_WASASA)) {//WASASA MFI S.C

                    // Cocde for Printer
                    String print_coll_group = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //  System.out.println("OutputStream " + outSt);
                                //  System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {
                                    //String[] repeatedEntryDate = repeatedStringDrCr.split("~");
                                    String repetedAmount = repeatedStringEntryDate;
                                    String[] repeatedPrdAccId = repeatedStringAmount.split("~");
                                    String[] repeatedStringCustomernumber = repeatedStringCustomerNumber.split("~");
                                    ptr.iFlushBuf();
                                    //    System.out.println("before print task ");
                                    // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                    // iRetVal = ptr.iStartPrinting(1);
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        for (String head : header.split("~") ){
                                            print_coll_group += " "+ head+"\n" ;
                                        } 
                                         // header

                                        print_coll_group += "   Ragaa Liqaa ittiin Sassaabamu  " + "\n";
                                        print_coll_group += "         " + "     " + "(Invoice) \n";// invoice detail caption

                                        print_coll_group += "    Damee: " + mlbrcode + "/" + branchName + "\n";  //Branch code
                                        print_coll_group += "    Guyyaa: " + date + "\n";  // Date
                                        print_coll_group += "    Lakk(:Trefno): " + trefno + "\n";  // TrefNO
                                        print_coll_group += "    Lakkoofsa Herreegaa: " + repeatedStringAmount + "\n";  // PrdAcctId
                                        print_coll_group += "    Maqaa maamila :  " + mlongname + " \n";//Customer Name
                                        print_coll_group += "    Qarshii Sassaabamee:  " + total + " \n";//Amount Collected

                                        String valbfrdecml = "";
                                        String valaftrdecml = "";
                                        String afterdecmlparam = "";
                                        if (total.equals("0.00")) {
                                            print_coll_group += "    Jechaan : zeeroo" + " \n";  // Amount in words
                                        } else {
                                            valbfrdecml = total.substring(0, total.indexOf('.'));
                                            valaftrdecml = total.substring(total.indexOf('.') + 1);

                                            if (valaftrdecml.equals("00")||valaftrdecml.equals("0")) {
                                                afterdecmlparam = " zeeroo";

                                            } else {
                                                afterdecmlparam = NumberToWordsConverter.convert(Integer.parseInt(valaftrdecml),true);
                                            }
                                            print_coll_group += "    Jechaan : " + NumberToWordsConverter.convert(Integer.parseInt(valbfrdecml)) + " saantima " + afterdecmlparam + " \n";  // Amount in words
                                        }

                                        print_coll_group += "    Ibsa :  " + " \n";//User Narration
                                        print_coll_group += " Nama Qarshii Fuudhe: " + " \n";
                                        print_coll_group += " Maqaa:  " + mbramchname + " \n"; // User name
                                        print_coll_group += " Mallattoo: ___________  " + " \n"; // Signature

                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "           *** END ***\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";

                                        ptr.iPrinterAddData((byte) 0x03, print_coll_group);
                                        ptr.iStartPrinting(1);

                                        /**
                                         * Added by UJK for image printing
                                         * in this we have to convert the string into bitmap
                                         * then convert it into 24bit bitmap
                                         * then make a byteArrayInputStream and then pass it to the ptr.iBmpprint().
                                         *
                                         */

//                                        Bitmap bitmap = TextGenerator.bmpDrawText(print_coll_group);
//                                        Bitmap bmpfinal = TextGenerator.bmpConvertTo_24Bit(bitmap);//	(ImageWidth.Inch_2,s2, 40, Justify.ALIGN_LEFT, bold);*/
//                                        byte[] bBmpFileData = TextGenerator.bGetBmpFileData(bmpfinal);
//                                        Log.d("bmp", "Result : abt to prn ");
//                                        ByteArrayInputStream bis = new ByteArrayInputStream(bBmpFileData);
//                                        int xx = ptr.iBmpPrint(bis);
//                                        Log.e("bmp1", "Result 1--->: " + xx);


                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }


                } else if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_FULLERTON)) {
                    // printing for Loan Repayment Customer wise
                    // Cocde for Printer
                    String print_coll_group = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //  System.out.println("OutputStream " + outSt);
                                //  System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {
                                    String[] repeatedEntryDate = repeatedStringDrCr.split("~");
                                    String[] repetedAmount = repeatedStringEntryDate.split("~");
                                    String[] repeatedPrdAccId = repeatedStringAmount.split("~");
                                    ptr.iFlushBuf();
                                    //    System.out.println("before print task ");
                                    // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                    // iRetVal = ptr.iStartPrinting(1);
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        print_coll_group += "   FULLERTON FINANCE MYANMAR Co Ltd " + "\n";
                                        print_coll_group += "         -----------------\n";
                                        print_coll_group += "      ေန႔ရက္ : " + "\n";//Date
                                        print_coll_group += mlbrcode + "\n";
                                        print_coll_group += "      စာရင္းသြင္းခ်ိန္ :" + "\n";//Transaction Time
                                        print_coll_group += mbramchname + "\n";
                                        print_coll_group += "      စာရင္းသြင္း၊ထုတ္အမွတ္စဥ္ :" + "\n";//Transaction Reference
                                        print_coll_group += date + "\n";
                                        print_coll_group += "      အသင္းသားအမည္ :" + "\n";//Customer ID No
                                        print_coll_group += prdAccId + "\n";
                                        print_coll_group += "      အသင္းသားအမွတ္ :" + "\n";//Customer Name
                                        print_coll_group += mlongname + "\n";
                                        print_coll_group += "      ေခ်းေငြၿပန္လည္ေပးသြင္းရသည္ စာရင္းအမွတ္ :" + "\n";//Loan Repayment A/C
                                        print_coll_group += macttotballcy + "\n";
                                       // print_coll_group += "      ပံုမွန္စုေငြ :" + "\n";//Compulsory Saving Amount
                                       // print_coll_group += repeatedStringEntryDate + "\n";
                                        print_coll_group += "      ေခ်းေငြ အရင္း ေပးသြင္းေငြ :" + "\n";//Loan Repayment (Prin)
                                        print_coll_group += repeatedStringAmount + "\n";
                                        print_coll_group += "      ေခ်းေငြ အတိုး ေပးသြင္းေငြ :" + "\n";//Loan Repayment (Int)
                                        print_coll_group += repeatedStringDrCr + "\n";
                                        print_coll_group += "      အၿခားေပးသြင္း အခေၾကးေငြမ်ား :" + "\n";//Other Charges/Penalty
                                        print_coll_group += repeatedStringRemarks + "\n";
                                        print_coll_group += "      စုစုေပါင္းေပးသြင္းေငြ :" + "\n";//Total Repayment Amount
                                        print_coll_group += trefno + "\n";
                                        //print_coll_group += "      စုေငြ စုစုေပါင္းလက္က်န္ :" + "\n";//Saving Balance ( Compulsory)
                                        //print_coll_group += repeatedStringCustomerNumber + "\n";
                                        print_coll_group += "      ေခ်းေငြ စုစုေပါင္းလက္က်န္ :" + "\n";//Loan Outstanding Balance
                                        print_coll_group += branchName + "\n";
                                        print_coll_group += "      ဆက္သြယ္ရန္ဖံုးနံပါတ္ :" + "\n";//Contact Phone No
                                        print_coll_group += centerName + "\n";
                                        print_coll_group += "      စာရင္းသြင္းတာဝန္ခံ၏ စာရင္းအမွတ္ :" + "\n";//Loan Officers
                                        print_coll_group += total + "\n";
                                        print_coll_group += "                      \n";


                                        print_coll_group += "                            " + "\n";


                                        print_coll_group += "-----------------------------\n";

                                        print_coll_group += "           *** END ***\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";


                                        /**
                                         * Added by UJK for image printing
                                         * in this we have to convert the string into bitmap
                                         * then convert it into 24bit bitmap
                                         * then make a byteArrayInputStream and then pass it to the ptr.iBmpprint().
                                         *
                                         */

                                        Bitmap bitmap = TextGenerator.bmpDrawText(print_coll_group);
                                        Bitmap bmpfinal = TextGenerator.bmpConvertTo_24Bit(bitmap);//	(ImageWidth.Inch_2,s2, 40, Justify.ALIGN_LEFT, bold);*/
                                        byte[] bBmpFileData = TextGenerator.bGetBmpFileData(bmpfinal);
                                        Log.d("bmp", "Result : abt to prn ");
                                        ByteArrayInputStream bis = new ByteArrayInputStream(bBmpFileData);
                                        int xx = ptr.iBmpPrint(bis);
                                        Log.e("bmp1", "Result 1--->: " + xx);

                                        //ptr.iPrinterAddData((byte) 0x03, print_coll_group);

                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }


                } else {
                    // Cocde for Printer
                    String print_coll_cust = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //   System.out.println("OutputStream " + outSt);
                                //   System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {
                                    String[] repeatedEntryDate = repeatedStringDrCr.split("~");
                                    String[] repetedAmount = repeatedStringEntryDate.split("~");
                                    String[] repeatedPrdAccId = repeatedStringAmount.split("~");
                                    ptr.iFlushBuf();
                                    //   System.out.println("before print task ");
                                    // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                    // iRetVal = ptr.iStartPrinting(1);
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        print_coll_cust += "           BranchCode: " + mlbrcode + "\n";
                                        //print_bill += "  BranchName: " + mbramchname + "\n";
                                        print_coll_cust += "       Date: " + date + "\n";
                                        print_coll_cust += "           Cust No  : " + macttotballcy + "\n";
                                        print_coll_cust += "                      \n";
                                        print_coll_cust += " Date   " + "    Amount " + "         PrdAccID \n";
                                        print_coll_cust += "-----------------------------------------\n";
                                        for (int i = 0; i < repeatedEntryDate.length; i++) {
                                            int amountLength = repetedAmount[i].length();
                                            String additionalAmountSpaces = "";
                                            for (int j = 0; j <= (11 - amountLength); j++) {
                                                additionalAmountSpaces += " ";
                                            }

                                            print_coll_cust += repeatedEntryDate[i].toString().substring(0, 10) + SeparationString + repetedAmount[i] + additionalAmountSpaces + SeparationString + (repeatedPrdAccId[i]) + "\n";
                                            print_coll_cust += "                            " + "\n";


                                            print_coll_cust += "-----------------------------------------\n";
                                        }
                                        print_coll_cust += "                      \n";
                                        print_coll_cust += "                      \n";
                                        print_coll_cust += "           *** END ***\n";
                                        print_coll_cust += "                      \n";
                                        print_coll_cust += "                      \n";


                                        ptr.iPrinterAddData((byte) 0x03, print_coll_cust);
                                        ptr.iStartPrinting(1);
                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                }


                // calling for customer laon collection

            } else if (callValue == 10) {
                if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_WASASA)) {
                    // Cocde for Printer
                    String print_coll_today = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //     System.out.println("OutputStream " + outSt);
                                //   System.out.println("InputStream " + inSt);
                                //   System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {
                                    String[] repeatedCustNo = repeatedStringDrCr.split("~");
                                    String[] repetedAmount = repeatedStringEntryDate.split("~");
                                    String[] repeatedPrdAccId = repeatedStringAmount.split("~");
                                    ptr.iFlushBuf();
                                    //     System.out.println("before print task ");
                                    // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                    // iRetVal = ptr.iStartPrinting(1);
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        // print_coll_today += "  Waldaa Aksiyoona Qusannoo fi Liqaa  " + "\n";
                                        // print_coll_today += "         " + "     " + "Wasaasaa \n";// name of company
                                        // print_coll_today += "   Teessoon: Sabbataa ,Oromiyaa" + "\n";  // name of company
                                        // print_coll_today += "   Bilb : +251 11 338 41 33" + "\n"; 
                                        for (String head : header.split("~") ){
                                            print_coll_today += " "+ head+"\n" ;
                                        }  // name of company

                                        print_coll_today += "   Ragaa Qusannoon ittiin Sassaabamu  " + "\n";
                                        print_coll_today += "         " + "     " + "(Invoice) \n";// invoice detail caption

                                        print_coll_today += "       Damee: " + mlbrcode + "/" + branchName + "\n";  //Branch code
                                        print_coll_today += "       Guyyaa: " + date + "\n";  // Date
                                        print_coll_today += "       Lakk(:Trefno): " + trefno + "\n";  // TrefNO
                                        print_coll_today += "       Maqaa Garee: " + centerName + "\n";// Gropup name
                                        print_coll_today += " Lakk.   " + "  " + "  Lakkoofsa " + "    " + " Qarshii  \n";
                                        print_coll_today += " Maamila " + "    Herreegaa   \n";
                                        print_coll_today += "--------------------------------------\n";
                                        for (int i = 0; i < repeatedCustNo.length; i++) {
                                            int amountLength = repetedAmount[i].length();
                                            String additionalAmountSpaces = "";
                                            for (int j = 0; j <= (11 - amountLength); j++) {
                                                additionalAmountSpaces += " ";
                                            }

                                            print_coll_today += repeatedCustNo[i] + SeparationString + SeparationString + SeparationString + (repeatedPrdAccId[i]) + additionalAmountSpaces + (repetedAmount[i]) + "\n";
                                            print_coll_today += "--------------------------------------\n";


                                        }
                                        print_coll_today += " Dimshaasha : " + total + " \n"; // Total

                                        String valbfrdecml = "";
                                        String valaftrdecml = "";
                                        String afterdecmlparam = "";
                                        if (total.equals("0.00")) {
                                            print_coll_today += "    Jechaan : zeeroo" + " \n";  // Amount in words
                                        } else {
                                            valbfrdecml = total.substring(0, total.indexOf('.'));
                                            valaftrdecml = total.substring(total.indexOf('.') + 1);

                                            if (valaftrdecml.equals("00")) {
                                                afterdecmlparam = " zeeroo";

                                            } else {
                                                afterdecmlparam = NumberToWordsConverter.convert(Integer.parseInt(valaftrdecml),true);
                                            }
                                            print_coll_today += "    Jechaan : " + NumberToWordsConverter.convert(Integer.parseInt(valbfrdecml)) + " saantima " + afterdecmlparam + " \n";  // Amount in words
                                        }


                                        print_coll_today += " Maamila Qarshii Galii Godhee " + " \n";
                                        print_coll_today += "  _______________________________________ " + " \n";
                                        print_coll_today += " Mallattoo:  " + " \n"; // Signature
                                        print_coll_today += " Nama Qarshii Fuudhe:  " + " \n"; // Caption
                                        print_coll_today += " Maqaa:  " + mbramchname + " \n"; // User name


                                        print_coll_today += "                      \n";
                                        print_coll_today += "                      \n";
                                        print_coll_today += "           *** END ***\n";
                                        print_coll_today += "                      \n";
                                        print_coll_today += "                      \n";


                                        ptr.iPrinterAddData((byte) 0x03, print_coll_today);
                                        ptr.iStartPrinting(1);
                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                } else {
                    // Cocde for Printer
                    String print_coll_today = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //     System.out.println("OutputStream " + outSt);
                                //   System.out.println("InputStream " + inSt);
                                //   System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {
                                    String[] repeatedCustNo = repeatedStringDrCr.split("~");
                                    String[] repetedAmount = repeatedStringEntryDate.split("~");
                                    String[] repeatedPrdAccId = repeatedStringAmount.split("~");
                                    ptr.iFlushBuf();
                                    //     System.out.println("before print task ");
                                    // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                    // iRetVal = ptr.iStartPrinting(1);
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        print_coll_today += "           BranchCode: " + mlbrcode + "\n";
                                        //print_bill += "  BranchName: " + mbramchname + "\n";
                                        print_coll_today += "       Date: " + date + "\n";
                                        print_coll_today += "                      \n";
                                        print_coll_today += "   PrdAccID " + "     Amount " + "       Cust No \n";
                                        print_coll_today += "-----------------------------------------\n";
                                        for (int i = 0; i < repeatedCustNo.length; i++) {
                                            int amountLength = repetedAmount[i].length();
                                            String additionalAmountSpaces = "";
                                            for (int j = 0; j <= (11 - amountLength); j++) {
                                                additionalAmountSpaces += " ";
                                            }

                                            print_coll_today += repeatedPrdAccId[i].toString() + SeparationString + repetedAmount[i] + additionalAmountSpaces + SeparationString + (repeatedCustNo[i]) + "\n";
                                            print_coll_today += "                            " + "\n";


                                            print_coll_today += "-----------------------------------------\n";
                                        }
                                        print_coll_today += "                      \n";
                                        print_coll_today += "                      \n";
                                        print_coll_today += "           *** END ***\n";
                                        print_coll_today += "                      \n";
                                        print_coll_today += "                      \n";


                                        ptr.iPrinterAddData((byte) 0x03, print_coll_today);
                                        ptr.iStartPrinting(1);
                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                }// calling for today's loan collection

            } else if (callValue == 11) {
                if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_WASASA)) {//WASASA MFI S.C

                    // Cocde for Printer
                    String print_coll_group = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //  System.out.println("OutputStream " + outSt);
                                //  System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {
                                    //String[] repeatedEntryDate = repeatedStringDrCr.split("~");
                                    String repetedAmount = repeatedStringEntryDate;
                                    String[] repeatedPrdAccId = repeatedStringAmount.split("~");
                                    String[] repeatedStringCustomernumber = repeatedStringCustomerNumber.split("~");
                                    ptr.iFlushBuf();
                                    //    System.out.println("before print task ");
                                    // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                    // iRetVal = ptr.iStartPrinting(1);
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        // print_coll_group += "  Waldaa Aksiyoona Qusannoo fi Liqaa  " + "\n";
                                        // print_coll_group += "         " + "     " + "Wasaasaa \n";// name of company
                                        // print_coll_group += "   Teessoon: Sabbataa ,Oromiyaa" + "\n";  // name of company
                                        // print_coll_group += "   Bilb : +251 11 338 41 33" + "\n";  // name of company
                                        for (String head : header.split("~") ){
                                            print_coll_group += " "+ head+"\n" ;
                                        }  

                                        print_coll_group += "   Ragaa Liqaa ittiin Sassaabamu  " + "\n";
                                        print_coll_group += "         " + "     " + "(Invoice) \n";// invoice detail caption

                                        print_coll_group += "    Damee: " + mlbrcode + "/" + branchName + "\n";  //Branch code
                                        print_coll_group += "    Guyyaa: " + date + "\n";  // Date
                                        print_coll_group += "    Lakk(:Trefno): " + trefno + "\n";  // TrefNO
                                        print_coll_group += "    Lakkoofsa Herreegaa: " + repeatedStringAmount + "\n";  // PrdAcctId
                                        print_coll_group += "    Maqaa maamila :  " + " \n";//Customer Name
                                        print_coll_group += mlongname + " \n";//Customer Name
                                       // total = "98678.65";
                                        print_coll_group += "    Qarshii Sassaabamee:  " + total + " \n";//Amount Collected
                                        String valbfrdecml = "";
                                        String valaftrdecml = "";
                                        String afterdecmlparam = "";
                                        if (total.equals("0.00")) {
                                            print_coll_group += "    Jechaan : zeeroo" + " \n";  // Amount in words
                                        } else {
                                            valbfrdecml = total.substring(0, total.indexOf('.'));
                                            valaftrdecml = total.substring(total.indexOf('.') + 1);

                                            if (valaftrdecml.equals("00")) {
                                                afterdecmlparam = " zeeroo";

                                            } else {
                                                afterdecmlparam = NumberToWordsConverter.convert(Integer.parseInt(valaftrdecml),true);
                                            }
                                            print_coll_group += "    Jechaan : " + NumberToWordsConverter.convert(Integer.parseInt(valbfrdecml)) + " saantima " + afterdecmlparam + " \n";  // Amount in words
                                        }



                                        print_coll_group += "    Ibsa :  ___________" + " \n";//User Narration
                                        print_coll_group += " Nama Qarshii Fuudhe: " + " \n"; // User name
                                        print_coll_group += " Maqaa: " + mbramchname + " \n"; // User name
                                        print_coll_group += " Mallattoo: ___________  " + " \n"; // Signature

                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "           *** END ***\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";

                                        ptr.iPrinterAddData((byte) 0x03, print_coll_group);
                                        ptr.iStartPrinting(1);

                                        /**
                                         * Added by UJK for image printing
                                         * in this we have to convert the string into bitmap
                                         * then convert it into 24bit bitmap
                                         * then make a byteArrayInputStream and then pass it to the ptr.iBmpprint().
                                         *
                                         */

//                                        Bitmap bitmap = TextGenerator.bmpDrawText(print_coll_group);
//                                        Bitmap bmpfinal = TextGenerator.bmpConvertTo_24Bit(bitmap);//	(ImageWidth.Inch_2,s2, 40, Justify.ALIGN_LEFT, bold);*/
//                                        byte[] bBmpFileData = TextGenerator.bGetBmpFileData(bmpfinal);
//                                        Log.d("bmp", "Result : abt to prn ");
//                                        ByteArrayInputStream bis = new ByteArrayInputStream(bBmpFileData);
//                                        int xx = ptr.iBmpPrint(bis);
//                                        Log.e("bmp1", "Result 1--->: " + xx);


                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }


                } else {
                    // Cocde for Printer
                    String print_coll_cust = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //   System.out.println("OutputStream " + outSt);
                                //   System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {
                                    String[] repeatedEntryDate = repeatedStringDrCr.split("~");
                                    String[] repetedAmount = repeatedStringEntryDate.split("~");
                                    String[] repeatedPrdAccId = repeatedStringAmount.split("~");
                                    ptr.iFlushBuf();
                                    //   System.out.println("before print task ");
                                    // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                    // iRetVal = ptr.iStartPrinting(1);
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        print_coll_cust += "           BranchCode: " + mlbrcode + "\n";
                                        //print_bill += "  BranchName: " + mbramchname + "\n";
                                        print_coll_cust += "       Date: " + date + "\n";
                                        print_coll_cust += "           Cust No  : " + macttotballcy + "\n";
                                        print_coll_cust += "                      \n";
                                        print_coll_cust += " Date   " + "    Amount " + "         PrdAccID \n";
                                        print_coll_cust += "-----------------------------------------\n";
                                        for (int i = 0; i < repeatedEntryDate.length; i++) {
                                            int amountLength = repetedAmount[i].length();
                                            String additionalAmountSpaces = "";
                                            for (int j = 0; j <= (11 - amountLength); j++) {
                                                additionalAmountSpaces += " ";
                                            }

                                            print_coll_cust += repeatedEntryDate[i].toString().substring(0, 10) + SeparationString + repetedAmount[i] + additionalAmountSpaces + SeparationString + (repeatedPrdAccId[i]) + "\n";
                                            print_coll_cust += "                            " + "\n";


                                            print_coll_cust += "-----------------------------------------\n";
                                        }
                                        print_coll_cust += "                      \n";
                                        print_coll_cust += "                      \n";
                                        print_coll_cust += "           *** END ***\n";
                                        print_coll_cust += "                      \n";
                                        print_coll_cust += "                      \n";


                                        ptr.iPrinterAddData((byte) 0x03, print_coll_cust);
                                        ptr.iStartPrinting(1);
                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                }


                // calling for customer laon collection

            } else if (callValue == 12) {
                if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_WASASA)) {//WASASA MFI S.C
                    // Cocde for Printer
                    String print_coll_group = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //  System.out.println("OutputStream " + outSt);
                                //  System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {
                                    String[] repeatedEntryDate = repeatedStringDrCr.split("~");
                                    String[] repetedAmount = repeatedStringEntryDate.split("~");
                                    String[] repeatedPrdAccId = repeatedStringAmount.split("~");
                                    String[] repeatedStringCustomernumber = repeatedStringCustomerNumber.split("~");
                                    ptr.iFlushBuf();
                                    //    System.out.println("before print task ");
                                    // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                    // iRetVal = ptr.iStartPrinting(1);
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        // print_coll_group += "  Waldaa Aksiyoona Qusannoo fi Liqaa  " + "\n";
                                        // print_coll_group += "         " + "     " + "Wasaasaa \n";// name of company
                                        // print_coll_group += "   Teessoon: Sabbataa ,Oromiyaa" + "\n";  // name of company
                                        // print_coll_group += "   Bilb : +251 11 338 41 33" + "\n";  // name of company
                                        for (String head : header.split("~") ){
                                            print_coll_group += " "+ head+"\n" ;
                                        }  
                                        print_coll_group += "   Ragaa Liqaa ittiin Sassaabamu  " + "\n";
                                        print_coll_group += "         " + "     " + "(Invoice) \n";// invoice detail caption

                                        print_coll_group += "       Damee: " + mlbrcode + "/" + branchName + "\n";  //Branch code
                                        print_coll_group += "       Guyyaa: " + date + "\n";  // Date
                                        print_coll_group += "       Lakk(:Trefno): " + trefno + "\n";  // TrefNO
                                        print_coll_group += "       Maqaa Garee: " + macttotballcy + "\n";// Gropup name
                                        print_coll_group += " Lakk.   " + "  " + "  Lakkoofsa " + "    " + " Qarshii  \n";
                                        print_coll_group += " Maamila " + "    Herreegaa   \n";
                                        print_coll_group += "--------------------------------------\n";
                                        for (int i = 0; i < repeatedEntryDate.length; i++) {
                                            int amountLength = repetedAmount[i].length();
                                            String additionalAmountSpaces = "";
                                            for (int j = 0; j <= (11 - amountLength); j++) {
                                                additionalAmountSpaces += " ";
                                            }

                                            print_coll_group += repeatedStringCustomernumber[i] + SeparationString + SeparationString + SeparationString + (repeatedPrdAccId[i]) + additionalAmountSpaces + (repetedAmount[i]) + "\n";
                                            print_coll_group += "--------------------------------------\n";
                                        }
                                        print_coll_group += " Dimshaasha : " + total + " \n"; // Total

                                        String valbfrdecml = "";
                                        String valaftrdecml = "";
                                        String afterdecmlparam = "";
                                        if (total.equals("0.00")) {
                                            print_coll_group += "    Jechaan : zeeroo" + " \n";  // Amount in words
                                        } else {
                                            valbfrdecml = total.substring(0, total.indexOf('.'));
                                            valaftrdecml = total.substring(total.indexOf('.') + 1);

                                            if (valaftrdecml.equals("00")) {
                                                afterdecmlparam = " zeeroo";

                                            } else {
                                                afterdecmlparam = NumberToWordsConverter.convert(Integer.parseInt(valaftrdecml),true);
                                            }
                                            print_coll_group += "    Jechaan : " + NumberToWordsConverter.convert(Integer.parseInt(valbfrdecml)) + " saantima " + afterdecmlparam + " \n";  // Amount in words
                                        }



                                        print_coll_group += " Maamila Qarshii Galii Godhee " + " \n";
                                        print_coll_group += "  _______________________________________ " + " \n";
                                        print_coll_group += " Mallattoo:  " + " \n"; // Signature
                                        print_coll_group += " Nama Qarshii Fuudhe:  " + " \n"; // Caption
                                        print_coll_group += " Maqaa:  " + mbramchname + " \n"; // User name


                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "           *** END ***\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";

                                        ptr.iPrinterAddData((byte) 0x03, print_coll_group);
                                        ptr.iStartPrinting(1);

                                        /**
                                         * Added by UJK for image printing
                                         * in this we have to convert the string into bitmap
                                         * then convert it into 24bit bitmap
                                         * then make a byteArrayInputStream and then pass it to the ptr.iBmpprint().
                                         *
                                         */

//                                        Bitmap bitmap = TextGenerator.bmpDrawText(print_coll_group);
//                                        Bitmap bmpfinal = TextGenerator.bmpConvertTo_24Bit(bitmap);//	(ImageWidth.Inch_2,s2, 40, Justify.ALIGN_LEFT, bold);*/
//                                        byte[] bBmpFileData = TextGenerator.bGetBmpFileData(bmpfinal);
//                                        Log.d("bmp", "Result : abt to prn ");
//                                        ByteArrayInputStream bis = new ByteArrayInputStream(bBmpFileData);
//                                        int xx = ptr.iBmpPrint(bis);
//                                        Log.e("bmp1", "Result 1--->: " + xx);


                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                } else {
                    // Cocde for Printer
                    String print_coll_group = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //  System.out.println("OutputStream " + outSt);
                                //  System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {
                                    String[] repeatedEntryDate = repeatedStringDrCr.split("~");
                                    String[] repetedAmount = repeatedStringEntryDate.split("~");
                                    String[] repeatedPrdAccId = repeatedStringAmount.split("~");
                                    ptr.iFlushBuf();
                                    //    System.out.println("before print task ");
                                    // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                    // iRetVal = ptr.iStartPrinting(1);
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        print_coll_group += "           शाखा क्र्मांक: " + mlbrcode + "\n";
                                        //print_bill += "  BranchName: " + mbramchname + "\n";
                                        print_coll_group += "       दिनांक: " + date + "\n";
                                        print_coll_group += "           Group Id: " + macttotballcy + "\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += " Date   " + "    Amount " + "         PrdAccID \n";
                                        print_coll_group += "-----------------------------------------\n";
                                        for (int i = 0; i < repeatedEntryDate.length; i++) {
                                            int amountLength = repetedAmount[i].length();
                                            String additionalAmountSpaces = "";
                                            for (int j = 0; j <= (11 - amountLength); j++) {
                                                additionalAmountSpaces += " ";
                                            }

                                            print_coll_group += repeatedEntryDate[i].toString().substring(0, 10) + SeparationString + repetedAmount[i] + additionalAmountSpaces + SeparationString + (repeatedPrdAccId[i]) + "\n";
                                            print_coll_group += "                            " + "\n";


                                            print_coll_group += "-----------------------------------------\n";
                                        }
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "           *** END ***\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";

                                        // String test =  "  शाखा क्र्मांक: " + mlbrcode + "\n";

                                        /**
                                         * Added by UJK for image printing
                                         * in this we have to convert the string into bitmap
                                         * then convert it into 24bit bitmap
                                         * then make a byteArrayInputStream and then pass it to the ptr.iBmpprint().
                                         *
                                         */

                                        Bitmap bitmap = TextGenerator.bmpDrawText(print_coll_group);
                                        Bitmap bmpfinal = TextGenerator.bmpConvertTo_24Bit(bitmap);//	(ImageWidth.Inch_2,s2, 40, Justify.ALIGN_LEFT, bold);*/
                                        byte[] bBmpFileData = TextGenerator.bGetBmpFileData(bmpfinal);
                                        Log.d("bmp", "Result : abt to prn ");
                                        ByteArrayInputStream bis = new ByteArrayInputStream(bBmpFileData);
                                        int xx = ptr.iBmpPrint(bis);
                                        Log.e("bmp1", "Result 1--->: " + xx);

                                        //ptr.iPrinterAddData((byte) 0x03, print_coll_group);

                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                }
// printing for Loan Disburstment

            } else if (callValue == 13) {
                if (projectName.trim().equalsIgnoreCase( Constants.PROJECT_NAME_FULLERTON)) {
                    // printing for Loan Disburstment
                    // Cocde for Printer
                    String print_coll_group = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //  System.out.println("OutputStream " + outSt);
                                //  System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {

                                    ptr.iFlushBuf();
                                    //    System.out.println("before print task ");
                                    // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                    // iRetVal = ptr.iStartPrinting(1);
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        print_coll_group += "   FULLERTON FINANCE MYANMAR Co Ltd " + "\n";
                                        print_coll_group += "         -----------------\n";
                                        print_coll_group += "      ေခ်းေငြထုတ္သည္႔ ေန႔ရက္ : " + "\n";// Loan Disburse Date
                                        print_coll_group += mlbrcode + "\n";
                                        print_coll_group += "      အသင္းသားအမွတ္ :" + "\n";//Customer ID No
                                        print_coll_group += mbramchname + "\n";
                                        print_coll_group += "      အသင္းသားအမည္ :" + "\n";//Customer Name
                                        print_coll_group += date + "\n";
                                        print_coll_group += "      ေခ်းေငြ အမ်ိဳးအစား :" + "\n";//Product Type
                                        print_coll_group += prdAccId + "\n";
                                        print_coll_group += "      ေခ်းေငြစာရင္းအမွတ္စဥ္ :" + "\n";//Loan ID
                                        print_coll_group += mlongname + "\n";
                                        print_coll_group += "      ေခ်းေငြၿပန္လည္ေပးသြင္းရသည္ စာရင္းအမွတ္ :" + "\n";//Loan Repayment A/C
                                        print_coll_group += macttotballcy + "\n";
                                        print_coll_group += "      ေခ်းေငြ ထုတ္ယူေငြ ပမာဏ :" + "\n";//Loan Disburse Amount
                                        print_coll_group += repeatedStringEntryDate + "\n";
                                        print_coll_group += "      ဝန္ေဆာင္ခေပးသြင္းေငြပမာဏ :" + "\n";//Documentation Fees
                                        print_coll_group += repeatedStringAmount + "\n";
                                        print_coll_group += "      ေခ်းေငြအာမခံေပးသြင္းေငြပမာဏ :" + "\n";//Insurance Charges
                                        print_coll_group += repeatedStringDrCr + "\n";
                                        print_coll_group += "      ဆက္သြယ္ရန္ဖံုးနံပါတ္ :" + "\n";//Contact Phone No
                                        print_coll_group += repeatedStringRemarks + "\n";
                                        print_coll_group += "      စာရင္းသြင္းတာဝန္ခံ၏ စာရင္းအမွတ္ :" + "\n";//Loan Officers
                                        print_coll_group += trefno + "\n";

                                        print_coll_group += "                            " + "\n";


                                        print_coll_group += "-----------------------------\n";

                                        print_coll_group += "           *** END ***\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";


                                        /**
                                         * Added by UJK for image printing
                                         * in this we have to convert the string into bitmap
                                         * then convert it into 24bit bitmap
                                         * then make a byteArrayInputStream and then pass it to the ptr.iBmpprint().
                                         *
                                         */

                                        Bitmap bitmap = TextGenerator.bmpDrawText(print_coll_group);
                                        Bitmap bmpfinal = TextGenerator.bmpConvertTo_24Bit(bitmap);//	(ImageWidth.Inch_2,s2, 40, Justify.ALIGN_LEFT, bold);*/
                                        byte[] bBmpFileData = TextGenerator.bGetBmpFileData(bmpfinal);
                                        Log.d("bmp", "Result : abt to prn ");
                                        ByteArrayInputStream bis = new ByteArrayInputStream(bBmpFileData);
                                        int xx = ptr.iBmpPrint(bis);
                                        Log.e("bmp1", "Result 1--->: " + xx);

                                        //ptr.iPrinterAddData((byte) 0x03, print_coll_group);

                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }


                } else if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_WASASA)) {

                    // Cocde for Printer
                    String print_coll_group = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //  System.out.println("OutputStream " + outSt);
                                //  System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {

                                    ptr.iFlushBuf();

                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        // print_coll_group += "  Wasasa MFI S.C  " + "\n";
                                        // print_coll_group += "  Address: Sebbeta ,Oromia" + "\n";
                                        // print_coll_group += "  Phone: +251 11 338 41 33" + "\n";
                                        for (String head : header.split("~") ){
                                            print_coll_group += " "+ head+"\n" ;
                                        }  

                                        print_coll_group += "  Loan Disbursement Voucher  " + "\n";
                                        print_coll_group += "--------------------------------------\n";
                                        print_coll_group += "                      \n";

                                        print_coll_group += " Branch Name: " + mlbrcode +  "\n";
                                        print_coll_group += " Disbursement Date: " + mbramchname + "\n";
                                        print_coll_group += " T.ref No.: " + date + "\n";
                                        print_coll_group += " Batch: " + prdAccId + "\n";
                                        print_coll_group += " Setno: " + repeatedStringDrCr + "\n";
                                        print_coll_group += " PrdAcctId: " + mlongname + "\n";
                                        print_coll_group += " Customer Name: " + macttotballcy + "\n";


                                        if(repeatedStringRemarks.equals("Customer")){
                                            print_coll_group += " Fees and Charges Collection Receipt"+ "\n";
                                            print_coll_group += " Passbook fee: "+ trefno + " \n";
                                            print_coll_group += " Processing fee: "+ repeatedStringCustomerNumber+"\n";
                                            print_coll_group += " Premium Amount: "+branchName+"\n";
                                            print_coll_group += " Total fee: "+centerName+"\n";
                                            String valbfrdecml = "";
                                            String valaftrdecml = "";
                                            String afterdecmlparam = "";

                                            if (centerName.equals("0.00")||centerName.equals("0.0")) {
                                                print_coll_group += "Amount In words: Zero "  + "\n";
                                            } else {
                                                valbfrdecml = centerName.substring(0, centerName.indexOf('.'));
                                                valaftrdecml = centerName.substring(centerName.indexOf('.') + 1);

                                                if (valaftrdecml.equals("00")||valaftrdecml.equals("0")) {
                                                    afterdecmlparam = " zeeroo";

                                                } else {
                                                    afterdecmlparam = NumberToWordsConverterENG.convert(Integer.parseInt(valaftrdecml));
                                                }
                                                print_coll_group += " Amount In words : " + NumberToWordsConverterENG.convert(Integer.parseInt(valbfrdecml)) + " and  " + afterdecmlparam + " \n";
                                        }


                                        }else{
                                            print_coll_group += " Disbursement Amount: " + repeatedStringEntryDate + "\n";
                                            String valbfrdecml = "";
                                            String valaftrdecml = "";
                                            String afterdecmlparam = "";

                                            if (repeatedStringEntryDate.equals("0.00")||repeatedStringEntryDate.equals("0.0")) {
                                                print_coll_group += " Amount In words: Zero "  + "\n";
                                            } else {
                                                valbfrdecml = repeatedStringEntryDate.substring(0, repeatedStringEntryDate.indexOf('.'));
                                                valaftrdecml = repeatedStringEntryDate.substring(repeatedStringEntryDate.indexOf('.') + 1);

                                                if (valaftrdecml.equals("00")||valaftrdecml.equals("0")) {
                                                    afterdecmlparam = " zeeroo";

                                                } else {
                                                    afterdecmlparam = NumberToWordsConverterENG.convert(Integer.parseInt(valaftrdecml));
                                                }
                                                print_coll_group += " Amount In words : " + NumberToWordsConverterENG.convert(Integer.parseInt(valbfrdecml)) + " and  " + afterdecmlparam + " \n";  // Amount in words
                                            }

                                            print_coll_group += " Customer Signature:  " + "\n";

                                        }



                                        print_coll_group += " Paid By (Cashier):"+"\n";
                                        print_coll_group += " Users Name:   "+ repeatedStringAmount + "\n";
                                        print_coll_group += " Signature:   "    + "\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += " Approved by:   "  + "\n";
                                        print_coll_group += " Signature:   "    + "\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "       *** END  ***    \n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";

                                        ptr.iPrinterAddData((byte) 0x03, print_coll_group);
                                        ptr.iStartPrinting(1);

                                        /**
                                         * Added by UJK for image printing
                                         * in this we have to convert the string into bitmap
                                         * then convert it into 24bit bitmap
                                         * then make a byteArrayInputStream and then pass it to the ptr.iBmpprint().
                                         *
                                         */

//                                        Bitmap bitmap = TextGenerator.bmpDrawText(print_coll_group);
//                                        Bitmap bmpfinal = TextGenerator.bmpConvertTo_24Bit(bitmap);//	(ImageWidth.Inch_2,s2, 40, Justify.ALIGN_LEFT, bold);*/
//                                        byte[] bBmpFileData = TextGenerator.bGetBmpFileData(bmpfinal);
//                                        Log.d("bmp", "Result : abt to prn ");
//                                        ByteArrayInputStream bis = new ByteArrayInputStream(bBmpFileData);
//                                        int xx = ptr.iBmpPrint(bis);
//                                        Log.e("bmp1", "Result 1--->: " + xx);


                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }



                }

            } else if (callValue == 14){
                if (projectName.trim().equalsIgnoreCase( Constants.PROJECT_NAME_WASASA)) {
                    // Cocde for Printer
                    String print_coll_group = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //  System.out.println("OutputStream " + outSt);
                                //  System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {
                                    String[] repeatedGroupId = repeatedStringRemarks.split("~");
                                    String[] repeatedGroupName = prdAccId.split("~");
                                    String[] repeatedAmountCollected = date.split("~");

                                    ptr.iFlushBuf();

                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        // print_coll_group += "  Waldaa Aksiyoona Qusannoo fi Liqaa  " + "\n";
                                        // print_coll_group += "         " + "     " + "Wasaasaa \n";// name of company
                                        // print_coll_group += "   Teessoon: Sabbataa ,Oromiyaa" + "\n";  // name of company
                                        // print_coll_group += "   Bilb : +251 11 338 41 33" + "\n";  // name of company
                                        for (String head : header.split("~") ){
                                            print_coll_group += " "+ head+"\n" ;
                                        }  
                                        print_coll_group += "   Cuunfaa Qusannoon ittiin Sassaabame  " + "\n";//Daily Saving Collection Summary

                                        print_coll_group += "       Damee: " + macttotballcy +  "\n";//Branch code
                                        print_coll_group += "       Guyyaa: " + mbramchname + "\n";  // Date


                                        if(!repeatedGroupName.equals("")){
                                            print_coll_group += " Lakk.   " + "  " + "  Maqaa " + "    " + " Qarshii  \n";
                                            print_coll_group += " Garee " + "      Garee   \n";
                                            print_coll_group += "--------------------------------------\n";
                                            for (int i = 0; i < repeatedGroupName.length; i++) {
                                                int amountLength = repeatedAmountCollected[i].length();
                                                String additionalAmountSpaces = "";
                                                for (int j = 0; j <= (11 - amountLength); j++) {
                                                    additionalAmountSpaces += " ";
                                                }

                                                print_coll_group += repeatedGroupId[i] + SeparationString + SeparationString + SeparationString + (repeatedGroupName[i]) + additionalAmountSpaces + (repeatedAmountCollected[i]) + "\n";
                                                print_coll_group += "--------------------------------------\n";
                                            }

                                        }else{

                                        }

                                        print_coll_group += " Qussannoo  Dhunfaa  Irraa : " + mlongname + " \n"; // Individual deposit clients
                                        print_coll_group += " Dimshaasha : " + repeatedStringAmount + " \n"; // Total

                                        String valbfrdecml = "";
                                        String valaftrdecml = "";
                                        String afterdecmlparam = "";
                                        if (repeatedStringAmount.equals("0.00")) {
                                            print_coll_group += "    Jechaan : zeeroo" + " \n";  // Amount in words
                                        } else {
                                            valbfrdecml = repeatedStringAmount.substring(0, repeatedStringAmount.indexOf('.'));
                                            valaftrdecml = repeatedStringAmount.substring(repeatedStringAmount.indexOf('.') + 1);

                                            if (valaftrdecml.equals("00")) {
                                                afterdecmlparam = " zeeroo";

                                            } else {
                                                afterdecmlparam = NumberToWordsConverter.convert(Integer.parseInt(valaftrdecml),true);
                                            }
                                            print_coll_group += "    Jechaan : " + NumberToWordsConverter.convert(Integer.parseInt(valbfrdecml)) + " saantima " + afterdecmlparam + " \n";  // Amount in words
                                        }



                                        print_coll_group += " Kan  Fuudhe: " + " \n";//Collected by;
                                        print_coll_group += " Maqaa:  " + repeatedStringDrCr + " \n"; // User name
                                        print_coll_group += " Mallattoo:  " + " \n"; // Signature

                                        print_coll_group += " Kan  Mirkaneessee  " + " \n";//Approved by
                                        print_coll_group += " Maqaa:  " + " \n"; // User name
                                        print_coll_group += " Mallattoo:  " + " \n"; // Signature
                                        print_coll_group += "  _______________________________________ " + " \n";





                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "           *** END ***\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";

                                        ptr.iPrinterAddData((byte) 0x03, print_coll_group);
                                        ptr.iStartPrinting(1);

                                        /**
                                         * Added by UJK for image printing
                                         * in this we have to convert the string into bitmap
                                         * then convert it into 24bit bitmap
                                         * then make a byteArrayInputStream and then pass it to the ptr.iBmpprint().
                                         *
                                         */

//                                        Bitmap bitmap = TextGenerator.bmpDrawText(print_coll_group);
//                                        Bitmap bmpfinal = TextGenerator.bmpConvertTo_24Bit(bitmap);//	(ImageWidth.Inch_2,s2, 40, Justify.ALIGN_LEFT, bold);*/
//                                        byte[] bBmpFileData = TextGenerator.bGetBmpFileData(bmpfinal);
//                                        Log.d("bmp", "Result : abt to prn ");
//                                        ByteArrayInputStream bis = new ByteArrayInputStream(bBmpFileData);
//                                        int xx = ptr.iBmpPrint(bis);
//                                        Log.e("bmp1", "Result 1--->: " + xx);


                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                }

            } else if (callValue == 15){
                if (projectName.trim().equalsIgnoreCase( Constants.PROJECT_NAME_WASASA)) {
                    // Cocde for Printer
                    String print_coll_group = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //  System.out.println("OutputStream " + outSt);
                                //  System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {
                                    String[] repeatedGroupId = repeatedStringRemarks.split("~");
                                    String[] repeatedGroupName = prdAccId.split("~");
                                    String[] repeatedAmountCollected = date.split("~");

                                    ptr.iFlushBuf();

                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        // print_coll_group += "  Waldaa Aksiyoona Qusannoo fi Liqaa  " + "\n";
                                        // print_coll_group += "         " + "     " + "Wasaasaa \n";// name of company
                                        // print_coll_group += "   Teessoon: Sabbataa ,Oromiyaa" + "\n";  // name of company
                                        // print_coll_group += "   Bilb : +251 11 338 41 33" + "\n";  // name of company
                                        for (String head : header.split("~") ){
                                            print_coll_group += " "+ head+"\n" ;
                                        }  
                                        print_coll_group += "   Cuunfaa Liqaan  ittiin Sassaabame  " + "\n";//Daily Loan Collection Summary

                                        print_coll_group += "       Damee: " + macttotballcy +  "\n";//Branch code
                                        print_coll_group += "       Guyyaa: " + mbramchname + "\n";  // Date


                                        if(!repeatedGroupName.equals("")){
                                            print_coll_group += " Lakk.   " + "  " + "  Maqaa " + "    " + " Qarshii  \n";
                                            print_coll_group += " Garee " + "      Garee   \n";
                                            print_coll_group += "--------------------------------------\n";
                                            for (int i = 0; i < repeatedGroupName.length; i++) {
                                                int amountLength = repeatedAmountCollected[i].length();
                                                String additionalAmountSpaces = "";
                                                for (int j = 0; j <= (11 - amountLength); j++) {
                                                    additionalAmountSpaces += " ";
                                                }

                                                print_coll_group += repeatedGroupId[i] + SeparationString + SeparationString + SeparationString + (repeatedGroupName[i]) + additionalAmountSpaces + (repeatedAmountCollected[i]) + "\n";
                                                print_coll_group += "--------------------------------------\n";
                                            }

                                        }else{

                                        }

                                        print_coll_group += " Liqaan  Dhunfaa  Irraa : " + mlongname + " \n"; // Individual deposit clients
                                        print_coll_group += " Dimshaasha : " + repeatedStringAmount + " \n"; // Total

                                        String valbfrdecml = "";
                                        String valaftrdecml = "";
                                        String afterdecmlparam = "";
                                        if (repeatedStringAmount.equals("0.00")) {
                                            print_coll_group += "    Jechaan : zeeroo" + " \n";  // Amount in words
                                        } else {
                                            valbfrdecml = repeatedStringAmount.substring(0, repeatedStringAmount.indexOf('.'));
                                            valaftrdecml = repeatedStringAmount.substring(repeatedStringAmount.indexOf('.') + 1);

                                            if (valaftrdecml.equals("00")) {
                                                afterdecmlparam = " zeeroo";

                                            } else {
                                                afterdecmlparam = NumberToWordsConverter.convert(Integer.parseInt(valaftrdecml),true);
                                            }
                                            print_coll_group += "    Jechaan : " + NumberToWordsConverter.convert(Integer.parseInt(valbfrdecml)) + " saantima " + afterdecmlparam + " \n";  // Amount in words
                                        }



                                        print_coll_group += " Kan  Fuudhe: " + " \n";//Collected by;
                                        print_coll_group += " Maqaa:  " + repeatedStringDrCr + " \n"; // User name
                                        print_coll_group += " Mallattoo:  " + " \n"; // Signature

                                        print_coll_group += " Kan  Mirkaneessee  " + " \n";//Approved by
                                        print_coll_group += " Maqaa:  " + " \n"; // User name
                                        print_coll_group += " Mallattoo:  " + " \n"; // Signature
                                        print_coll_group += "  _______________________________________ " + " \n";





                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "           *** END ***\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";

                                        ptr.iPrinterAddData((byte) 0x03, print_coll_group);
                                        ptr.iStartPrinting(1);

                                        /**
                                         * Added by UJK for image printing
                                         * in this we have to convert the string into bitmap
                                         * then convert it into 24bit bitmap
                                         * then make a byteArrayInputStream and then pass it to the ptr.iBmpprint().
                                         *
                                         */

//                                        Bitmap bitmap = TextGenerator.bmpDrawText(print_coll_group);
//                                        Bitmap bmpfinal = TextGenerator.bmpConvertTo_24Bit(bitmap);//	(ImageWidth.Inch_2,s2, 40, Justify.ALIGN_LEFT, bold);*/
//                                        byte[] bBmpFileData = TextGenerator.bGetBmpFileData(bmpfinal);
//                                        Log.d("bmp", "Result : abt to prn ");
//                                        ByteArrayInputStream bis = new ByteArrayInputStream(bBmpFileData);
//                                        int xx = ptr.iBmpPrint(bis);
//                                        Log.e("bmp1", "Result 1--->: " + xx);


                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                }

            } else if (callValue == 16){

            }

            else if (callValue == 17){
                //System.out.println("17 k andar bhi aaya");
                //System.out.println(projectName.trim());
                if (projectName.trim().equalsIgnoreCase( Constants.PROJECT_NAME_FULLERTON)) {

                    // printing for Loan Disburstment
                    // Cocde for Printer
                    String print_coll_group = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //  System.out.println("OutputStream " + outSt);
                                //  System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {

                                    ptr.iFlushBuf();
                                    //    System.out.println("before print task ");
                                    // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                    // iRetVal = ptr.iStartPrinting(1);
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        print_coll_group += "   FULLERTON FINANCE MYANMAR Co Ltd " + "\n";
                                        print_coll_group += "         -----------------\n";
                                        print_coll_group += "      ေခ်းေငြထုတ္သည္႔ ေန႔ရက္ : " + "\n";// Loan Disburse Date
                                        print_coll_group += mlbrcode + "\n";
                                        print_coll_group += "      အသင္းသားအမွတ္ :" + "\n";//Customer ID No
                                        print_coll_group += mbramchname + "\n";
                                        print_coll_group += "      အသင္းသားအမည္ :" + "\n";//Customer Name
                                        print_coll_group += date + "\n";
                                        print_coll_group += "      ေခ်းေငြ အမ်ိဳးအစား :" + "\n";//Product Type
                                        print_coll_group += prdAccId + "\n";
                                        print_coll_group += "      ေခ်းေငြစာရင္းအမွတ္စဥ္ :" + "\n";//Loan ID
                                        print_coll_group += mlongname + "\n";
                                        print_coll_group += "      ေခ်းေငြၿပန္လည္ေပးသြင္းရသည္ စာရင္းအမွတ္ :" + "\n";//Loan Repayment A/C
                                        print_coll_group += macttotballcy + "\n";
                                        print_coll_group += "      ေခ်းေငြ ထုတ္ယူေငြ ပမာဏ :" + "\n";//Loan Disburse Amount
                                        print_coll_group += repeatedStringEntryDate + "\n";
                                        print_coll_group += "      ဝန္ေဆာင္ခေပးသြင္းေငြပမာဏ :" + "\n";//Documentation Fees
                                        print_coll_group += repeatedStringAmount + "\n";
                                        print_coll_group += "      ေခ်းေငြအာမခံေပးသြင္းေငြပမာဏ :" + "\n";//Insurance Charges
                                        print_coll_group += repeatedStringDrCr + "\n";
                                        print_coll_group += "      ဆက္သြယ္ရန္ဖံုးနံပါတ္ :" + "\n";//Contact Phone No
                                        print_coll_group += repeatedStringRemarks + "\n";
                                        print_coll_group += "      စာရင္းသြင္းတာဝန္ခံ၏ စာရင္းအမွတ္ :" + "\n";//Loan Officers
                                        print_coll_group += trefno + "\n";

                                        print_coll_group += "                            " + "\n";


                                        print_coll_group += "-----------------------------\n";

                                        print_coll_group += "           *** END ***\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";


                                        /**
                                         * Added by UJK for image printing
                                         * in this we have to convert the string into bitmap
                                         * then convert it into 24bit bitmap
                                         * then make a byteArrayInputStream and then pass it to the ptr.iBmpprint().
                                         *
                                         */

                                        Bitmap bitmap = TextGenerator.bmpDrawText(print_coll_group);
                                        Bitmap bmpfinal = TextGenerator.bmpConvertTo_24Bit(bitmap);//	(ImageWidth.Inch_2,s2, 40, Justify.ALIGN_LEFT, bold);*/
                                        byte[] bBmpFileData = TextGenerator.bGetBmpFileData(bmpfinal);
                                        Log.d("bmp", "Result : abt to prn ");
                                        ByteArrayInputStream bis = new ByteArrayInputStream(bBmpFileData);
                                        int xx = ptr.iBmpPrint(bis);
                                        Log.e("bmp1", "Result 1--->: " + xx);

                                        //ptr.iPrinterAddData((byte) 0x03, print_coll_group);

                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }


                } else if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_WASASA)) {

                   // System.out.println("wasasa k andar aaya");
                    // Cocde for Printer
                    String print_coll_group = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //  System.out.println("OutputStream " + outSt);
                                //  System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {

                                    ptr.iFlushBuf();

                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        // print_coll_group += "  Wasasa MFI S.C  " + "\n";
                                        // print_coll_group += "  Address: Sebbeta ,Oromia" + "\n";
                                        // print_coll_group += "  Phone: +251 11 338 41 33" + "\n";
                                      

                                        
                                        for (String head : header.split("~") ){
                                            print_coll_group += " "+ head+"\n" ;
                                        }  

                                        print_coll_group += "  Cash Register " + "\n";
                                        print_coll_group += "--------------------------------------\n";
                                        print_coll_group += "                      \n";

                                        print_coll_group += "  Name: " + repeatedStringRemarks +  "\n";
                                        print_coll_group += "  Branch: " + mbramchname + "\n";
                                        print_coll_group += "  Operation Date: " + mlongname + "\n";
                                        print_coll_group += "  Time: " + prdAccId + "\n";
                                        print_coll_group += "  Date: " + date + "\n";
                                        print_coll_group += "  Open Cash: " + macttotballcy + "\n";
                                        print_coll_group += "  Inflow /Cash Receipt " + "\n";

                                        for (String head : repeatedStringEntryDate.split("~") ){
                                            print_coll_group += " "+ head+"\n" ;
                                        }  

                                        print_coll_group += "  Outflow / Cash Receipt " + "\n";
                                        for (String head : repeatedStringAmount.split("~") ){
                                            print_coll_group += " "+ head+"\n" ;
                                        }  
                                        
                                        print_coll_group += "   Prepared By:  " + "\n";
                                        print_coll_group += "   Signature:   " + "\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "   Approved by:   " + "\n";
                                        print_coll_group += "   Signature:   "  + "\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "           *** END ***\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";

                

                                        ptr.iPrinterAddData((byte) 0x03, print_coll_group);
                                        ptr.iStartPrinting(1);

                                        /**
                                         * Added by UJK for image printing
                                         * in this we have to convert the string into bitmap
                                         * then convert it into 24bit bitmap
                                         * then make a byteArrayInputStream and then pass it to the ptr.iBmpprint().
                                         *
                                         */

//                                        Bitmap bitmap = TextGenerator.bmpDrawText(print_coll_group);
//                                        Bitmap bmpfinal = TextGenerator.bmpConvertTo_24Bit(bitmap);//	(ImageWidth.Inch_2,s2, 40, Justify.ALIGN_LEFT, bold);*/
//                                        byte[] bBmpFileData = TextGenerator.bGetBmpFileData(bmpfinal);
//                                        Log.d("bmp", "Result : abt to prn ");
//                                        ByteArrayInputStream bis = new ByteArrayInputStream(bBmpFileData);
//                                        int xx = ptr.iBmpPrint(bis);
//                                        Log.e("bmp1", "Result 1--->: " + xx);


                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                               // System.out.println("Eklse m chala gaya");
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }



                }

           





            }
            else if (callValue == 18){

                if (projectName.trim().equalsIgnoreCase( Constants.PROJECT_NAME_FULLERTON)) {

                    // printing for Loan Disburstment
                    // Cocde for Printer
                    String print_coll_group = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //  System.out.println("OutputStream " + outSt);
                                //  System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {

                                    ptr.iFlushBuf();
                                    //    System.out.println("before print task ");
                                    // ptr.iPrinterAddData((byte) 0x03, "Printing from flutter1");
                                    // iRetVal = ptr.iStartPrinting(1);
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        print_coll_group += "   FULLERTON FINANCE MYANMAR Co Ltd " + "\n";
                                        print_coll_group += "         -----------------\n";
                                        print_coll_group += "      ေခ်းေငြထုတ္သည္႔ ေန႔ရက္ : " + "\n";// Loan Disburse Date
                                        print_coll_group += mlbrcode + "\n";
                                        print_coll_group += "      အသင္းသားအမွတ္ :" + "\n";//Customer ID No
                                        print_coll_group += mbramchname + "\n";
                                        print_coll_group += "      အသင္းသားအမည္ :" + "\n";//Customer Name
                                        print_coll_group += date + "\n";
                                        print_coll_group += "      ေခ်းေငြ အမ်ိဳးအစား :" + "\n";//Product Type
                                        print_coll_group += prdAccId + "\n";
                                        print_coll_group += "      ေခ်းေငြစာရင္းအမွတ္စဥ္ :" + "\n";//Loan ID
                                        print_coll_group += mlongname + "\n";
                                        print_coll_group += "      ေခ်းေငြၿပန္လည္ေပးသြင္းရသည္ စာရင္းအမွတ္ :" + "\n";//Loan Repayment A/C
                                        print_coll_group += macttotballcy + "\n";
                                        print_coll_group += "      ေခ်းေငြ ထုတ္ယူေငြ ပမာဏ :" + "\n";//Loan Disburse Amount
                                        print_coll_group += repeatedStringEntryDate + "\n";
                                        print_coll_group += "      ဝန္ေဆာင္ခေပးသြင္းေငြပမာဏ :" + "\n";//Documentation Fees
                                        print_coll_group += repeatedStringAmount + "\n";
                                        print_coll_group += "      ေခ်းေငြအာမခံေပးသြင္းေငြပမာဏ :" + "\n";//Insurance Charges
                                        print_coll_group += repeatedStringDrCr + "\n";
                                        print_coll_group += "      ဆက္သြယ္ရန္ဖံုးနံပါတ္ :" + "\n";//Contact Phone No
                                        print_coll_group += repeatedStringRemarks + "\n";
                                        print_coll_group += "      စာရင္းသြင္းတာဝန္ခံ၏ စာရင္းအမွတ္ :" + "\n";//Loan Officers
                                        print_coll_group += trefno + "\n";

                                        print_coll_group += "                            " + "\n";


                                        print_coll_group += "-----------------------------\n";

                                        print_coll_group += "           *** END ***\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";


                                        /**
                                         * Added by UJK for image printing
                                         * in this we have to convert the string into bitmap
                                         * then convert it into 24bit bitmap
                                         * then make a byteArrayInputStream and then pass it to the ptr.iBmpprint().
                                         *
                                         */

                                        Bitmap bitmap = TextGenerator.bmpDrawText(print_coll_group);
                                        Bitmap bmpfinal = TextGenerator.bmpConvertTo_24Bit(bitmap);//	(ImageWidth.Inch_2,s2, 40, Justify.ALIGN_LEFT, bold);*/
                                        byte[] bBmpFileData = TextGenerator.bGetBmpFileData(bmpfinal);
                                        Log.d("bmp", "Result : abt to prn ");
                                        ByteArrayInputStream bis = new ByteArrayInputStream(bBmpFileData);
                                        int xx = ptr.iBmpPrint(bis);
                                        Log.e("bmp1", "Result 1--->: " + xx);

                                        //ptr.iPrinterAddData((byte) 0x03, print_coll_group);

                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }


                } else if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_WASASA)) {


                    // Cocde for Printer
                    String print_coll_group = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //  System.out.println("OutputStream " + outSt);
                                //  System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {

                                    ptr.iFlushBuf();

                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        // print_coll_group += "  Wasasa MFI S.C  " + "\n";
                                        // print_coll_group += "  Address: Sebbeta ,Oromia" + "\n";
                                        // print_coll_group += "  Phone: +251 11 338 41 33" + "\n";



                                        for (String head : header.split("~") ){
                                            print_coll_group += " "+ head+"\n" ;
                                        }
                                        print_coll_group += "--------------------------------------\n";

                                        print_coll_group +=  repeatedStringRemarks + "\n";
                                        print_coll_group += "--------------------------------------\n";
                                        print_coll_group += "                      \n";

                                        print_coll_group += " Branch Code: " + mlbrcode +  "\n";
                                        print_coll_group += " Branch Name : " + mbramchname + "\n";
                                        print_coll_group += " Operation Date : " + mlongname + "\n";
                                        print_coll_group += " Transaction Date:  " + macttotballcy + "\n";
                                        print_coll_group += " Receipt Print date: " +  date + " " + prdAccId+ "\n";
                                        print_coll_group += " Account Id :  " + repeatedStringAmount + "\n";
                                        print_coll_group += " Trans Amount :  " + trefno + "\n";
                                        String valbfrdecml = "";
                                        String valaftrdecml = "";
                                        String afterdecmlparam = "";

                                        if (trefno.equals("0.00")||trefno.equals("0.0")) {
                                            print_coll_group += "Amount In words: Zero "  + "\n";
                                        }
//                                        else {
//                                            valbfrdecml = trefno.substring(0, total.indexOf('.'));
//                                            valaftrdecml = trefno.substring(total.indexOf('.') + 1);
//
//                                            if (valaftrdecml.equals("00")||valaftrdecml.equals("0")) {
//                                                afterdecmlparam = " zeeroo";
//
//                                            } else {
//                                                afterdecmlparam = NumberToWordsConverterENG.convert(Integer.parseInt(valaftrdecml));
//                                            }
//                                            print_coll_group += "Amount In words : " + NumberToWordsConverterENG.convert(Integer.parseInt(valbfrdecml)) + " and  " + afterdecmlparam + " \n";  // Amount in words
//                                        }
                                        print_coll_group += " User Name :  " + repeatedStringCustomerNumber + "\n";

                                        print_coll_group += "           *** END ***\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";

                                       // System.out.println(print_coll_group);

                                        ptr.iPrinterAddData((byte) 0x03, print_coll_group);
                                        ptr.iStartPrinting(1);

                                        /**
                                         * Added by UJK for image printing
                                         * in this we have to convert the string into bitmap
                                         * then convert it into 24bit bitmap
                                         * then make a byteArrayInputStream and then pass it to the ptr.iBmpprint().
                                         *
                                         */

//                                        Bitmap bitmap = TextGenerator.bmpDrawText(print_coll_group);
//                                        Bitmap bmpfinal = TextGenerator.bmpConvertTo_24Bit(bitmap);//	(ImageWidth.Inch_2,s2, 40, Justify.ALIGN_LEFT, bold);*/
//                                        byte[] bBmpFileData = TextGenerator.bGetBmpFileData(bmpfinal);
//                                        Log.d("bmp", "Result : abt to prn ");
//                                        ByteArrayInputStream bis = new ByteArrayInputStream(bBmpFileData);
//                                        int xx = ptr.iBmpPrint(bis);
//                                        Log.e("bmp1", "Result 1--->: " + xx);


                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                               // System.out.println("Eklse m chala gaya");
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }



                }







            }
            else if (callValue == 19){
                //System.out.println("19 k andar bhi aaya");
                //System.out.println(projectName.trim());
                 if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_WASASA)) {

                   // System.out.println("wasasa k andar aaya");
                    // Cocde for Printer
                    String print_coll_group = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //  System.out.println("OutputStream " + outSt);
                                //  System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {

                                    ptr.iFlushBuf();

                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        // print_coll_group += "  Wasasa MFI S.C  " + "\n";
                                        // print_coll_group += "  Address: Sebbeta ,Oromia" + "\n";
                                        // print_coll_group += "  Phone: +251 11 338 41 33" + "\n";

                                       // System.out.println(" chalu hua " );
                                       // System.out.println(" Trefno hai  " + trefno );

                                        for (String head : header.split("~") ){
                                            print_coll_group += " "+ head+"\n" ;
                                        }
                                        print_coll_group += "--------------------------------------\n";

                                        print_coll_group +=  "Ragaa Qarshiin adda addaa ittiin Sassaabamu" + "\n";
                                        print_coll_group +=  "             (Invoice) " + "\n";
                                        print_coll_group += "--------------------------------------\n";
                                        print_coll_group += "                      \n";

                                        print_coll_group += " Damee: " + mlbrcode +  "\n";  //Branch Name:
                                        print_coll_group += " Guyyaa: " + mbramchname + "\n"; //Date:
                                        print_coll_group += " Lakk: " + repeatedStringEntryDate + "\n";  //T.ref No

                                        if(trefno.equals("Transfer")){
                                            //Paid by

                                            print_coll_group += " Lakkoofsa Herreegaa (DR): " +  macttotballcy + "\n";//Account Number(DR)

                                            print_coll_group += " Qarshii (DR):  " +  repeatedStringAmount + "\n";
                                            print_coll_group += " Lakkoofsa Herreegaa (CR): " +  mlongname +  "\n";//Account Number(CR)
                                            print_coll_group += " Qarshii (CR): " +  repeatedStringAmount +  "\n";

                                        }else{
                                            print_coll_group += " Lakkoofsa Herreegaa : " +  prdAccId + "\n";//Account Number
                                            print_coll_group += " Maqaa Herreegaa : " +  repeatedStringCustomerNumber + "\n";//Account Name
                                            print_coll_group += " Qarshii Sassaabamee: " + repeatedStringAmount + "\n";//Amount Collected

                                            String valbfrdecml = "";
                                            String valaftrdecml = "";
                                            String afterdecmlparam = "";
                                            if (total.equals("0.00")) {
                                                print_coll_group += " Jechaan : zeeroo" + " \n";  // Amount in words
                                            } else {
                                                valbfrdecml = repeatedStringAmount.substring(0, repeatedStringAmount.indexOf('.'));
                                                valaftrdecml = repeatedStringAmount.substring(repeatedStringAmount.indexOf('.') + 1);

                                                if (valaftrdecml.equals("00")) {
                                                    afterdecmlparam = " zeeroo";

                                                } else {
                                                    afterdecmlparam = NumberToWordsConverter.convert(Integer.parseInt(valaftrdecml),true);
                                                }
                                                print_coll_group += " Jechaan : " + NumberToWordsConverter.convert(Integer.parseInt(valbfrdecml)) + " saantima " + afterdecmlparam + " \n";  // Amount in words
                                            }
                                        }


                                        print_coll_group += " Ibsa : " + repeatedStringRemarks + "\n";//User Narration:


                                        if(repeatedStringCustomerNumber.equals("Transfer")){
                                            //Paid by

                                            print_coll_group += " Nama Galmeesse : " +  repeatedStringDrCr +  "\n";//User Name

                                            print_coll_group += " Mallattoo :  " +  "___________________"+ "\n";//Signature

                                        }else{
                                            print_coll_group += " Nama Qarshii fudhee : " + repeatedStringDrCr + "\n";//User Name
                                            print_coll_group += " Mallattoo: " +  "___________________"+ "\n";//Signature
                                        }


                                        print_coll_group += "           *** END ***\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";

                                        //System.out.println(print_coll_group);

                                        ptr.iPrinterAddData((byte) 0x03, print_coll_group);
                                        ptr.iStartPrinting(1);

                                        /**
                                         * Added by UJK for image printing
                                         * in this we have to convert the string into bitmap
                                         * then convert it into 24bit bitmap
                                         * then make a byteArrayInputStream and then pass it to the ptr.iBmpprint().
                                         *
                                         */

//                                        Bitmap bitmap = TextGenerator.bmpDrawText(print_coll_group);
//                                        Bitmap bmpfinal = TextGenerator.bmpConvertTo_24Bit(bitmap);//	(ImageWidth.Inch_2,s2, 40, Justify.ALIGN_LEFT, bold);*/
//                                        byte[] bBmpFileData = TextGenerator.bGetBmpFileData(bmpfinal);
//                                        Log.d("bmp", "Result : abt to prn ");
//                                        ByteArrayInputStream bis = new ByteArrayInputStream(bBmpFileData);
//                                        int xx = ptr.iBmpPrint(bis);
//                                        Log.e("bmp1", "Result 1--->: " + xx);


                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                                //System.out.println("Eklse m chala gaya");
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }

            }  else if (callValue == 20){
                if (projectName.trim().equalsIgnoreCase(Constants.PROJECT_NAME_WASASA)) {

                    // Cocde for Printer
                    String print_coll_group = "";
                    String SeparationString = "  ";
                    try {

                        if (firstTimePrint) {
                            //  System.out.println("for second time print");
                            try {

                                try {
                                    OutputStream outSt = BluetoothComm.mosOut;
                                    InputStream inSt = BluetoothComm.misIn;

                                    if (setupInstance != null)

                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }
                                ptr.iFlushBuf();
                                // testprint = new TestPrintTask();
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
                                    Log.e("DiscoverBT SharedPref", "---> Value Selected");
                                else {
                                    //testprint.execute(0);
                                }
                            } catch (Exception n) {
                                n.printStackTrace();

                            }
                        } else {

                            if (createConn(bleAddress)) {

                                OutputStream outSt = BluetoothComm.mosOut;
                                InputStream inSt = BluetoothComm.misIn;
                                //  System.out.println("OutputStream " + outSt);
                                //  System.out.println("InputStream " + inSt);
                                //  System.out.println("setupInstance " + setupInstance);
                                try {

                                    if (setupInstance != null)
                                        ptr = new Printer(setupInstance, outSt, inSt);

                                } catch (NullPointerException npe) {
                                    npe.printStackTrace();
                                }

                                try {

                                    ptr.iFlushBuf();

                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                                        // print_coll_group += "  Wasasa MFI S.C  " + "\n";
                                        // print_coll_group += "  Address: Sebbeta ,Oromia" + "\n";
                                        // print_coll_group += "  Phone: +251 11 338 41 33" + "\n";
                                        String[] repeatedAcctIds = prdAccId.split("~"); //mergedAcctIds
                                        String[] repetedAmount = mlongname.split("~");  //mergedtotals
                                        String[] repeatedCustNo = repeatedStringRemarks.split("~");

                                        for (String head : header.split("~") ){
                                            print_coll_group += " "+ head+"\n" ;
                                        }
                                        print_coll_group += "--------------------------------------\n";

                                        print_coll_group +=  "    Cuunfaa  Qusannoon ittiin Bahe   " + "\n";
                                        print_coll_group +=  "             (Invoice) " + "\n";
                                        print_coll_group += "--------------------------------------\n";
                                        print_coll_group += "                      \n";

                                        print_coll_group += " Guyyaa : " + date +  "\n";  //operation Date:
                                        print_coll_group += "                      \n";

                                        print_coll_group += "Lakk.maamila   Lakkoofsa        Qarshii  \n";
                                        print_coll_group += "               Herreegaa         \n";
                                        print_coll_group += "--------------------------------------\n";
                                        for (int i = 0; i < repeatedAcctIds.length; i++) {
                                            int amountLength = repetedAmount[i].length();
                                            String additionalAmountSpaces = "";
                                            for (int j = 0; j <= (11 - amountLength); j++) {
                                                additionalAmountSpaces += " ";
                                            }

                                            print_coll_group += repeatedCustNo[i] + SeparationString + SeparationString + SeparationString + (repeatedAcctIds[i]) + additionalAmountSpaces + (repetedAmount[i]) + "\n";
                                            print_coll_group += "--------------------------------------\n";
                                        }
                                        print_coll_group += " Dimshaasha : " + macttotballcy + " \n"; // Total

                                            String valbfrdecml = "";
                                            String valaftrdecml = "";
                                            String afterdecmlparam = "";
                                            if (total.equals("0.00")) {
                                                print_coll_group += " Jechaan : zeeroo" + " \n";  // Amount in words
                                            } else {
                                                valbfrdecml = macttotballcy.substring(0, macttotballcy.indexOf('.'));
                                                valaftrdecml = macttotballcy.substring(macttotballcy.indexOf('.') + 1);

                                                if (valaftrdecml.equals("00")) {
                                                    afterdecmlparam = " zeeroo";

                                                } else {
                                                    afterdecmlparam = NumberToWordsConverter.convert(Integer.parseInt(valaftrdecml),true);
                                                }
                                                print_coll_group += " Jechaan : " + NumberToWordsConverter.convert(Integer.parseInt(valbfrdecml)) + " saantima " + afterdecmlparam + " \n";  // Amount in words
                                            }

                                        print_coll_group +="_____________________________________________\n";
                                            print_coll_group += " Kan Qopheessee  : " + "\n";//Nothing
                                        print_coll_group += " Maqaa: " + repeatedStringEntryDate + "\n";//User Name
                                        print_coll_group += " Mallattoo : " + "_____________" + "\n";//Signature
                                        print_coll_group += " Kan  qarshii Basii godhee : "  + "\n";//User Name
                                        print_coll_group += " Maqaa : " +  "\n";
                                        print_coll_group += " Mallattoo : " +  "\n";
                                        print_coll_group += " Kan Mirkaneessee : " + "\n";//User Name
                                        print_coll_group += " Maqaa : " +  "\n";
                                        print_coll_group += " Mallattoo : " +  "\n";



                                        print_coll_group += "           *** END ***\n";
                                        print_coll_group += "                      \n";
                                        print_coll_group += "                      \n";
                                        ptr.iPrinterAddData((byte) 0x03, print_coll_group);
                                        ptr.iStartPrinting(1);

                                        /**
                                         * Added by UJK for image printing
                                         * in this we have to convert the string into bitmap
                                         * then convert it into 24bit bitmap
                                         * then make a byteArrayInputStream and then pass it to the ptr.iBmpprint().
                                         *
                                         */

//                                        Bitmap bitmap = TextGenerator.bmpDrawText(print_coll_group);
//                                        Bitmap bmpfinal = TextGenerator.bmpConvertTo_24Bit(bitmap);//	(ImageWidth.Inch_2,s2, 40, Justify.ALIGN_LEFT, bold);*/
//                                        byte[] bBmpFileData = TextGenerator.bGetBmpFileData(bmpfinal);
//                                        Log.d("bmp", "Result : abt to prn ");
//                                        ByteArrayInputStream bis = new ByteArrayInputStream(bBmpFileData);
//                                        int xx = ptr.iBmpPrint(bis);
//                                        Log.e("bmp1", "Result 1--->: " + xx);

                                    } else {
                                        ptr.iPrinterAddData((byte) 0x03, "Printing from flutter3");
                                    }
                                } catch (NullPointerException n) {
                                    n.printStackTrace();
                                }
                            } else {
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }

            }


            prtRetVal = "SUCESS";
            return prtRetVal;
        }

        @Override
        protected void onPreExecute() {
            Log.d("In preexecute", "Printing ...");
            progressDialog(MainActivity.this, "Printing...");
            super.onPreExecute();
        }

        /*
         * This function sends message to handler to display the status messages
         * of Diagnose in the dialog box
         */

        @Override
        protected void onPostExecute(String s) {
            dlgPg.dismiss();
            result.success(s);
            super.onPostExecute(s);
        }
    }


}