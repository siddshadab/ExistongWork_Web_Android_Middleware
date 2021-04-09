package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;

import java.lang.reflect.Field;
import java.rmi.RemoteException;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CustomerAddressDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerAssetDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerBorrowingDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerFamilyDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerHouseholdExpenseEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerPPIDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.OmniCustomerMasterService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.servicesimpl.SystemParameterServicesImpl;
import com.infrasofttech.microfinance.utility.Utility;

@Service
public class OmniCustomerMasterServiceImpl implements OmniCustomerMasterService {

	@Autowired
	SystemParameterServicesImpl systemParameterServicesImpl;
	
	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		CustomerEntity customerEntityBean = (CustomerEntity) bean;
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		System.out.println("inparams");
		TMsgInParam inParams = new TMsgInParam();
		try {
			inParams = prepareRequestToOmni(bean);	
		}catch(Exception e) {
			
			retBean = new OmniSoapResultBean();
			retBean.setMCustRefNo(customerEntityBean.getMrefno());
			retBean.setCreatedBy(customerEntityBean.getMcreatedby());
			retBean.setTRefno(customerEntityBean.getTrefno());
			retBean.setStatus(1);
			retBean.setMCustNo(0);
			retBean.setError("Data Not Correctly Submitted");
			return retBean;
		}
		
		System.out.println("Outparams");
		// do Request
		
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Dayta of in patrams "+inParams.toString());
			if(customerEntityBean.getMcustno()>0) {
				outparam = omniServiceSoapProxy.invoke(Constants.Field1, "2", 910906, inParams);
			}else {
				outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 910906, inParams);	
			}
			
			//outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 910906, inParams);
			System.out.println("here starts");
			System.out.println(outparam.getField1());
			System.out.println(outparam.getField2());
			System.out.println(outparam.getField101());
			System.out.println(outparam.getField102());
			System.out.println(outparam.getField103());
			System.out.println(outparam.getField104());
			System.out.println(outparam.getField201());
			System.out.println(outparam.getField204());
			System.out.println(outparam.getField203() + " 203 hai yeh customer Creation time");
			System.out.println(outparam.getField202());
			System.out.println("here ends");
			retBean = prepareResponseRecievedFromOmni(outparam);
			retBean = new OmniSoapResultBean();		
			retBean.setMCustRefNo(customerEntityBean.getMrefno());
			retBean.setCreatedBy(customerEntityBean.getMcreatedby());
			retBean.setTRefno(customerEntityBean.getTrefno());
			if (!outparam.getField201().equals("0")) {
				System.out.println("Dayta of in patrams 1"+outparam.toString());
				retBean.setStatus(1);
				retBean.setMCustNo(0);				
				retBean.setError(outparam.getField203());
				return retBean;
			}
			System.out.println("Dayta of in patrams 2 "+outparam.toString());
			if(outparam!=null && outparam.getField1() !=null) {
				retBean.setStatus(0);
				try {
				retBean.setMCustNo(Integer.parseInt(outparam.getField1()));
				System.out.println("Status is  " + outparam.getField2());
				retBean.setMreceiptstatus(Integer.parseInt(outparam.getField2()));
				}catch(Exception e) {}
				
			} else {
				retBean.setStatus(1);
				retBean.setMCustNo(0);
				retBean.setError(outparam.getField203());
			}
			
			return retBean;
		} catch (RemoteException e) {
						
		}
		

		return null;
	}

	@Override
	public TMsgInParam prepareRequestToOmni(BaseEntity bean) {
		CustomerEntity customerEntityBean = (CustomerEntity) bean;
		TMsgInParam inParam = new TMsgInParam();
		System.out.println("mrefno is" +customerEntityBean.getMrefno() );
		
		//RadioCheckBoxesDataBean dataBean = new RadioCheckBoxesDataBean();
		//Utility.setRadioAndCheckBoxesData(customerEntityBean.getRadioCheckBox(), dataBean);
			//refrence nuber for omni
		if(customerEntityBean.getMcustno()>0) {
			inParam.setField1(String.valueOf(customerEntityBean.getMcustno())+"~C~1"+Constants.TILDA+customerEntityBean.getMrefno()+customerEntityBean.getTrefno()+LocalDateTime.now());
		}else {
			inParam.setField1(String.valueOf(0)+"~C~1"+Constants.TILDA+customerEntityBean.getMrefno()+customerEntityBean.getTrefno()+LocalDateTime.now());
		}
		
		inParam.setField2(String.valueOf(customerEntityBean.getMgroupcd()));
		inParam.setField3(String.valueOf(customerEntityBean.getMcenterid()));
		//TODO assigned leader to group add this field later on from front end till backend(now keeping it static )
		
		
		//CustCategory
		inParam.setField4(String.valueOf(customerEntityBean.getMcustcategory()));
		
		inParam.setField6(String.valueOf(customerEntityBean.getMprofileind()));
		//inParam.setField9(customerEntityBean.getMfathername());
		inParam.setField10(String.valueOf(customerEntityBean.getMlbrcode()));
		inParam.setField11(Constants.BLANKINT1);
		inParam.setField12(Constants.BLANKINT1);

		inParam.setField15(customerEntityBean.getMnametitle());
		
		String isOnlyLongName="";
		
		try {
		isOnlyLongName = systemParameterServicesImpl.getCodeValue("ISONLYLONGNAME");
		System.out.println(" Schxxxxxxxxxx"+ isOnlyLongName);
		}catch(Exception e){
			
		}
		
		if(isOnlyLongName.equals("1")) {
			inParam.setField16(customerEntityBean.getMlongname());
		}else {
			inParam.setField16(customerEntityBean.getMfname()+" "+customerEntityBean.getMmname()+" "+customerEntityBean.getMlname());	
		}
		
		inParam.setField17(customerEntityBean.getMfathername() + Constants.TILDA + Constants.TILDA);

		inParam.setField18(customerEntityBean.getMhusbandname() + Constants.TILDA + Constants.BLANKSTRING);
		// id type
		inParam.setField19(String.valueOf(customerEntityBean.getMpanno()));
		// id number to check by omni
		inParam.setField20(customerEntityBean.getMpannodesc());
		// Customer Nationality
		inParam.setField21("1");
		//inParam.setField22(customerEntityBean.getMgender()+ Constants.TILDA + String.valueOf("1" + Constants.TILDA + "Name"));
		inParam.setField22(customerEntityBean.getMgender());
		//inParam.setField23(String.valueOf(customerEntityBean.getMdob()));
		System.out.println("Date unformatted "+String.valueOf(customerEntityBean.getMdob()));
		inParam.setField23(Utility.unFormateDt(customerEntityBean.getMdob()));
		

		inParam.setField24(String.valueOf(customerEntityBean.getMmaritialstatus()));

		inParam.setField26(customerEntityBean.getMrelegion());
		inParam.setField28(customerEntityBean.getMqualification());
		// CasteCategory
		inParam.setField27(customerEntityBean.getMcaste());
		
		// language
		//inParam.setField30("1");
		inParam.setField30(customerEntityBean.getMlangofcust());
		
		inParam.setField31(String.valueOf(Utility.calculateAge(customerEntityBean.getMdob())));
		
		inParam.setField36(String.valueOf(customerEntityBean.getMoccupation()));//OccupType
		//inParam.setField36("2");
		inParam.setField37(customerEntityBean.getMmainoccupn() + Constants.HIFEN +customerEntityBean.getMsuboccupn());
		//secondary occupation set default to others, code 6
		//inParam.setField39("6");
		inParam.setField39(String.valueOf(customerEntityBean.getMsecoccupatn()));

		if (customerEntityBean.getMbankacno() !=null &&  !"".equals(customerEntityBean.getMbankacno()) &&  !"null".equals(customerEntityBean.getMbankacno())){
			inParam.setField41(String.valueOf(customerEntityBean.getMbankacno()));
			inParam.setField42(String.valueOf(1));
			inParam.setField43(Constants.BLANKSTRING);
			inParam.setField44(Constants.BLANKSTRING);
		} else {
			inParam.setField41(Constants.BLANKSTRING);
			inParam.setField42(Constants.BLANKSTRING);
			inParam.setField43(Constants.BLANKSTRING);
			inParam.setField44(Constants.BLANKSTRING);
		}
		if (customerEntityBean.getMbankacno() !=null &&  !"".equals(customerEntityBean.getMbankacno()) &&  !"null".equals(customerEntityBean.getMbankacno())){
		inParam.setField59(Constants.YES);
		}else {
			inParam.setField59(Constants.NO);
		}

		if (customerEntityBean.getMbankacno() !=null &&  !"".equals(customerEntityBean.getMbankacno()) &&  !"null".equals(customerEntityBean.getMbankacno())){
			inParam.setField60(String.valueOf(customerEntityBean.getMbanknamelk()));//60,BankNameLk
			inParam.setField61(customerEntityBean.getMbankbranch());//61,BankBranch
		} else {
			inParam.setField60(Constants.BLANKSTRING);
			inParam.setField61(Constants.BLANKSTRING);
		}
		inParam.setField62(String.valueOf(customerEntityBean.getMcuststatus()));
		//inParam.setField62(Constants.BLANKINT1);
        //house
		//inParam.setField66(customerEntityBean.get());
		//
		inParam.setField66(String.valueOf(customerEntityBean.getMtypeofid()));
		inParam.setField67(customerEntityBean.getMiddesc());
		inParam.setField70(Constants.TILDA + Constants.YES + Constants.TILDA + Constants.NO);
		inParam.setField73(customerEntityBean.getMcreatedby());
		inParam.setField74(customerEntityBean.getMcusttype());
		//inParam.setField74(Constants.BLANKSTRING);
		//inParam.setField74(Constants.BLANKSTRING);
		inParam.setField85(Constants.TILDA);
		
		 int mmemberno =customerEntityBean.getMmemberno(); 
		 
		 String designation = "";
		 if(customerEntityBean.getDesignation()!=null) {
			 designation= customerEntityBean.getDesignation();
		 }
		 String orgname = "";
          if(customerEntityBean.getOrgname()!=null) {
        	  orgname=  customerEntityBean.getOrgname();
		 }
		 String yearsinorg = "";
          if(customerEntityBean.getYearsinorg()!=null) {
        	  yearsinorg= customerEntityBean.getYearsinorg();
		 }
		
		inParam.setField98(mmemberno+Constants.TILDA+designation+Constants.TILDA+orgname+Constants.TILDA+yearsinorg);

		// inParam.setField88(customerRequest.getHusbandName());
		inParam.setField90(Constants.BLANKSTRING);
		inParam.setField91(Constants.BLANKSTRING);
		inParam.setField92(Constants.BLANKSTRING);
		inParam.setField93(Constants.BLANKSTRING);

		String temp = "";
		int count = 1;
		inParam.setField97(Constants.BLANKSTRING);
		//inParam.setField98(Constants.EMPTYSTRING);

		int fieldCount=99;
		Field f1=null;
		try {
			//AddressDetails
			if(customerEntityBean.getAddressDetails()!=null 
					&& customerEntityBean.getAddressDetails().size()>0){

				List<CustomerAddressDetailsEntity> addressDetailsList=(List<CustomerAddressDetailsEntity>) customerEntityBean.getAddressDetails();
				for (CustomerAddressDetailsEntity customerAddressBean :addressDetailsList) {
					temp="";

					if(customerAddressBean !=null) {
					temp=temp+customerAddressBean.getMaddrtype()+Constants.HIFEN+Constants.TILDA+//0
							customerAddressBean.getMhousetype()+Constants.HIFEN+Constants.TILDA+
							customerAddressBean.getMroofcond()+Constants.HIFEN+Constants.TILDA+//RoofCond
							customerAddressBean.getMutils()+Constants.HIFEN+Constants.TILDA+
							customerAddressBean.getMaddr1()+Constants.TILDA+//4
							customerAddressBean.getMaddr2()+Constants.TILDA+
							customerAddressBean.getMcitycd()+Constants.HIFEN+Constants.TILDA+
							customerAddressBean.getMpincd()+Constants.TILDA+
							customerAddressBean.getMstate()+Constants.HIFEN+Constants.TILDA+
							customerAddressBean.getMcountrycd()+Constants.HIFEN+Constants.TILDA+
							customerAddressBean.getMtel1()+Constants.TILDA+//10
							customerAddressBean.getMmobile()+Constants.TILDA+
							customerAddressBean.getMlandmark()+Constants.TILDA+
							customerAddressBean.getMyearstay()+Constants.TILDA+
							Constants.BLANKINT0+Constants.TILDA+
							Constants.BLANKSTRING+Constants.TILDA+//ContLeasExp					
							""+Constants.TILDA+//16 PattaName						
							Constants.BLANKINT0+Constants.TILDA+
							Constants.BLANKINT0+Constants.HIFEN+Constants.TILDA+//18
							Constants.BLANKINT0+Constants.TILDA+						
							customerAddressBean.getMtoietyn()+Constants.TILDA+
							customerAddressBean.getMnoofrooms()+Constants.TILDA+//21
							customerAddressBean.getMyearstay()+Constants.TILDA+	//SpouseYearsStay
							Constants.BLANKINT0+Constants.TILDA+    //WardNo,23
							/*add here age of marrige if spouse*/
							//customerAddressBean.getHouseNumber()+Constants.TILDA+
							customerAddressBean.getMarea()+Constants.HIFEN+Constants.TILDA+ //24
							customerAddressBean.getMdistcd()+Constants.HIFEN+Constants.TILDA+ //25
							customerAddressBean.getMvillage()+Constants.HIFEN+Constants.TILDA+ //26
							Constants.HIFEN+Constants.TILDA+//27
							Constants.HIFEN+Constants.TILDA+//28
							Constants.HIFEN+Constants.TILDA;//29
					


					f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);

					f1.setAccessible(true);
					f1.set(inParam, temp);
					
					fieldCount++;
					}
				}
				f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
				f1.setAccessible(true);
				f1.set(inParam, "|END1|");
				fieldCount++;
			}else{
				f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
				f1.setAccessible(true);
				f1.set(inParam, "|END1|");
				fieldCount++;
			}
			
			/*f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);			
			f1.setAccessible(true);
			f1.set(inParam, "|END|");
			fieldCount++;*/

			//Customer PPI Detail
			count=1;
			if(customerEntityBean.getCustomerPPIDetailsEntity()!=null 
					&& customerEntityBean.getCustomerPPIDetailsEntity().size()>0){

				List<CustomerPPIDetailsEntity> ppiList=(List<CustomerPPIDetailsEntity>) customerEntityBean.getCustomerPPIDetailsEntity();
				for (CustomerPPIDetailsEntity customerPPIDetailsEntity : ppiList) {
					temp="";	        		
					temp=temp+"3"+Constants.TILDA+//0,QnsType
							customerPPIDetailsEntity.getMitem()+Constants.TILDA+//1,QnsId
							customerPPIDetailsEntity.getMhaveyn();//2,AnsSrNo

					f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
					f1.setAccessible(true);
					f1.set(inParam, temp);
					fieldCount++;
					count++;
				}
				f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
				f1.setAccessible(true);
				f1.set(inParam, "|END|");
				fieldCount++;
			}else{
				f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
				f1.setAccessible(true);
				f1.set(inParam, "|END|");
				fieldCount++;
			}
			
			
			 count=1;
				if(customerEntityBean.getFamilyDetails()!=null 
						&& customerEntityBean.getFamilyDetails().size()>0){
					List<CustomerFamilyDetailsEntity> familyDetailsList=(List<CustomerFamilyDetailsEntity>) customerEntityBean.getFamilyDetails();
					for (CustomerFamilyDetailsEntity customerFamilyBean :familyDetailsList) {	        		temp="";
		        		
		      
						temp=temp+count+Constants.TILDA+customerFamilyBean.getMname()+Constants.TILDA+
								customerFamilyBean.getMage()+Constants.TILDA+
								customerFamilyBean.getMeducation()+Constants.HIFEN+Constants.TILDA+
								customerFamilyBean.getMrelationwithcust()+Constants.HIFEN+Constants.TILDA+
								customerFamilyBean.getMoccuptype()+Constants.HIFEN+Constants.TILDA+
								customerFamilyBean.getMincome()+Constants.TILDA+
								"2"+Constants.TILDA+//health status default active,7
								Constants.BLANKINT0+Constants.HIFEN+Constants.TILDA+//8
								Constants.BLANKINT0+Constants.TILDA+
								Constants.BLANKSTRING+Constants.TILDA+
								Constants.BLANKINT0+Constants.TILDA+//11
								Constants.BLANKSTRING+Constants.TILDA+Constants.BLANKSTRING;
						f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
						f1.setAccessible(true);
						f1.set(inParam, temp);
						fieldCount++;
						count++;
		        	}
		        	f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
					f1.setAccessible(true);
					f1.set(inParam, "|END2|");
					fieldCount++;
		        }else{
		        	f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
					f1.setAccessible(true);
					f1.set(inParam, "|END2|");
					fieldCount++;
		        }
				
				//Customer Household Expense Detail
				count=1;
				if(customerEntityBean.getCustomerHouseholdExpenseEntity()!=null 
						&& customerEntityBean.getCustomerHouseholdExpenseEntity().size()>0){

					List<CustomerHouseholdExpenseEntity> hhExpenseList=(List<CustomerHouseholdExpenseEntity>) customerEntityBean.getCustomerHouseholdExpenseEntity();
					for (CustomerHouseholdExpenseEntity customerHouseholdExpenseEntity : hhExpenseList) {
						temp="";	        		
						temp=temp+count+Constants.TILDA+customerHouseholdExpenseEntity.getMhoushldexpntype()+Constants.TILDA+
								customerHouseholdExpenseEntity.getMhoushldevaluationamt();

						f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
						f1.setAccessible(true);
						f1.set(inParam, temp);
						fieldCount++;
						count++;
					}
					f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
					f1.setAccessible(true);
					f1.set(inParam, "|END3|");
					fieldCount++;
				}else{
					f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
					f1.setAccessible(true);
					f1.set(inParam, "|END3|");
					fieldCount++;
				}
			
				/*f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);			
				f1.setAccessible(true);
				f1.set(inParam, "|END3|");
				fieldCount++;*/
			/*//Customer PPI Assessment Details
	        count=1;
	        if(customerRequest.getCustomerPPIAssessmentDetails()!=null && customerRequest.getCustomerPPIAssessmentDetails().getCustomerPPIAssessmentDetail()!=null
	        		&& customerRequest.getCustomerPPIAssessmentDetails().getCustomerPPIAssessmentDetail().size()>0){
	        	CustomerPPIAssessmentDetailsType occuDetails=customerRequest.getCustomerPPIAssessmentDetails();
	        	List<CustomerPPIAssessmentDetail> occuDetailsList=occuDetails.getCustomerPPIAssessmentDetail();
	        	for (Iterator iterator = occuDetailsList.iterator(); iterator.hasNext();) {
	        		temp="";
	        		CustomerPPIAssessmentDetail customerPPIAssessmentDetailsType = (CustomerPPIAssessmentDetail) iterator.next();
					temp=temp+count+Constants.TILDA+customerPPIAssessmentDetailsType.getType()+Constants.DASH+Constants.TILDA+
							customerPPIAssessmentDetailsType.getQuestionID()+Constants.DASH+Constants.TILDA+
							customerPPIAssessmentDetailsType.getAnswerID()+Constants.DASH+Constants.TILDA;

					f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
					f1.setAccessible(true);
					f1.set(inParam, temp);
					fieldCount++;
					count++;
	        	}
	        	f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
				f1.setAccessible(true);
				f1.set(inParam, "|END|");
				fieldCount++;
	        }else{
	        	f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
				f1.setAccessible(true);
				f1.set(inParam, "|END|");
				fieldCount++;
	        }
*/
	        
			//BOrrowing Details
			count=1;
			if(customerEntityBean.getBorrowingDetails()!=null 
					&& customerEntityBean.getBorrowingDetails().size()>0){

				List<CustomerBorrowingDetailsEntity> borrowingDetailsList=(List<CustomerBorrowingDetailsEntity>) customerEntityBean.getBorrowingDetails();
				for (CustomerBorrowingDetailsEntity customerBorrowingDetailsBean : borrowingDetailsList) {
					temp="";	        		
					temp=temp+count+Constants.TILDA+customerBorrowingDetailsBean.getMnameofborrower()+Constants.TILDA+
							customerBorrowingDetailsBean.getMloancycle()+Constants.TILDA+//2 loan cycle
							"O"+Constants.TILDA+//3 source default to others
							customerBorrowingDetailsBean.getMpurpose()+Constants.TILDA+
							customerBorrowingDetailsBean.getMamount()+Constants.TILDA+
							customerBorrowingDetailsBean.getMintrate()+Constants.TILDA+
							customerBorrowingDetailsBean.getMamount()+Constants.TILDA+//7 emi
							customerBorrowingDetailsBean.getMoutstandingamt();

					f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
					f1.setAccessible(true);
					f1.set(inParam, temp);
					fieldCount++;
					count++;
				}
				f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
				f1.setAccessible(true);
				f1.set(inParam, "|END4|");
				fieldCount++;
			}else{
				f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
				f1.setAccessible(true);
				f1.set(inParam, "|END4|");
				fieldCount++;
			}
		
			//Asset Details
			count=1;
			if(customerEntityBean.getCustomerAssetDetailsEntity()!=null 
					&& customerEntityBean.getCustomerAssetDetailsEntity().size()>0){
				
				List<CustomerAssetDetailsEntity> assetDetailsList=(List<CustomerAssetDetailsEntity>) customerEntityBean.getCustomerAssetDetailsEntity();
				for (CustomerAssetDetailsEntity customerAssetDetailsBean : assetDetailsList) {
					temp="";	
					
					//customerAssetDetailsBean.setMcustno(customerEntityBean.getMcustno());
					temp=temp+Constants.BLANKINT0+Constants.TILDA+customerAssetDetailsBean.getMitem()+
							Constants.TILDA+"1"+
							Constants.TILDA+"5000";

					f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
					f1.setAccessible(true);
					f1.set(inParam, temp);
					fieldCount++;
					count++;
				}
				f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
				f1.setAccessible(true);
				f1.set(inParam, "|END5|");		
				fieldCount++;
			}else{
				f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
				f1.setAccessible(true);
				f1.set(inParam, "|END5|");		
				fieldCount++;
			}
			/*f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);			
			f1.setAccessible(true);
			f1.set(inParam, "|END5|");
			fieldCount++;*/
			f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);			
			f1.setAccessible(true);
			f1.set(inParam, "|END6|");
			fieldCount++;
			f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);			
			f1.setAccessible(true);
			f1.set(inParam, "|END7|");
			fieldCount++;
			//Customer Bank Details
			count=1;
			/*if(customerEntityBean.getPaymentDetailsDetails()!=null 
					&& customerEntityBean.getPaymentDetailsDetails().size()>0){
				List<CustomerPaymentMethodDetailsEntity> paymentDetailsList=(List<CustomerPaymentMethodDetailsEntity>) customerEntityBean.getPaymentDetailsDetails();
				for (CustomerPaymentMethodDetailsEntity customerBorrowingDetailsBean : paymentDetailsList) {
					temp="";	        		
					temp=temp+count+Constants.TILDA+customerBorrowingDetailsBean.getPaymentMode()+Constants.HIFEN+Constants.TILDA+
							customerBorrowingDetailsBean.getBankCode()+Constants.HIFEN+customerBorrowingDetailsBean.getBankName()+Constants.TILDA+
							customerBorrowingDetailsBean.getBranchCode()+Constants.HIFEN+customerBorrowingDetailsBean.getBranchName()+Constants.TILDA+
							customerBorrowingDetailsBean.getAccountNumber()+Constants.TILDA+
							customerBorrowingDetailsBean.getAccountType()+Constants.HIFEN+Constants.TILDA+
							customerBorrowingDetailsBean.getIfscCode()+Constants.TILDA+Constants.TILDA+
							customerBorrowingDetailsBean.getAccountHolderName()+Constants.TILDA+Constants.BLANKSTRING;

					f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
					f1.setAccessible(true);
					f1.set(inParam, temp);
					fieldCount++;
					count++;
				}
				f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
				f1.setAccessible(true);
				f1.set(inParam, "|END9|");
				fieldCount++;
			}*/
			if(customerEntityBean.getMbankacno() !=null &&  !"".equals(customerEntityBean.getMbankacno()) &&  !"null".equals(customerEntityBean.getMbankacno())) {
			f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
			f1.setAccessible(true);
			f1.set(inParam, count +  Constants.TILDA+ 
					        Constants.BLANKSTRING + Constants.HIFEN+Constants.TILDA+
							customerEntityBean.getMbanknamelk()+Constants.HIFEN+Constants.BLANKSTRING +Constants.TILDA+//2 -BankName
							Constants.BLANKSTRING+Constants.HIFEN+customerEntityBean.getMbankbranch()+Constants.TILDA+// 3 - BankBranch
							customerEntityBean.getMbankacno()+Constants.TILDA+// 4- BankAccNo
							"1"+Constants.HIFEN+Constants.TILDA+// 5 AccType
							customerEntityBean.getMbankifsc()+Constants.TILDA+// 6 IFSCMICRCd
							Constants.BLANKINT0+Constants.TILDA+customerEntityBean.getMlongname());// 7 LastBalance,8 AcctHolderName
			fieldCount++;
			}
					
			f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
			f1.setAccessible(true);
			f1.set(inParam, "|END9|");
			fieldCount++;			
			
			
			f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
			f1.setAccessible(true);
			f1.set(inParam, "|END10|");
			fieldCount++;
			
			f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
			f1.setAccessible(true);
			//f1.set(inParam, "~ ~ ~");	
			f1.set(inParam, customerEntityBean.getMruralurban()+Constants.TILDA+Utility.unFormateDt(customerEntityBean.getMhusdob())
					+Constants.TILDA +(String.valueOf(Utility.calculateAge(customerEntityBean.getMdob()))));	
			fieldCount++;
			
			f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
			f1.setAccessible(true);			
			//CustomerBusinessDetailsEntity businessDetailsList= customerEntityBean.getCustomerBussDetails();
			if(customerEntityBean.getCustomerBussDetails()!=null) {
			f1.set(inParam, customerEntityBean.getCustomerBussDetails().getMcusactivitytype()+Constants.TILDA+//0
					customerEntityBean.getCustomerBussDetails().getMbusinessname()+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMbusaddress1()+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMbusaddress2()+Constants.TILDA+//3
					customerEntityBean.getCustomerBussDetails().getMbuscity()+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMbusstate()+Constants.TILDA+//5
					customerEntityBean.getCustomerBussDetails().getMbuscountry()+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMbuslandmark()+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMbuspin()+Constants.TILDA+//8
					Constants.BLANKINT0+Constants.TILDA+//BusActivity1
					Constants.BLANKSTRING+Constants.TILDA+
					Constants.BLANKINT0+Constants.TILDA+
					Constants.BLANKSTRING+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMbuslocownership()+Constants.TILDA+//13,BusLocOwnerShip
					Constants.BLANKINT0+Constants.TILDA+
					Constants.BLANKINT0+Constants.TILDA+
					Constants.BLANKINT0+Constants.TILDA+
					Constants.BLANKINT0+Constants.TILDA+//17
					customerEntityBean.getCustomerBussDetails().getMbusyrsmnths()+Constants.TILDA+//18 BusExpYrs
					Constants.BLANKINT0+Constants.TILDA+//19					
					Constants.BLANKINT0+Constants.TILDA+
					Constants.BLANKINT0+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMregisteredyn()+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMregistrationno()+Constants.TILDA+//23
					customerEntityBean.getCustomerBussDetails().getMbusothtomanageabsyn()+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMbusothmanagername()+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMbusothmanagerrel()+Constants.TILDA+
					Constants.BLANKINT0+Constants.TILDA+
					Constants.BLANKINT0+Constants.TILDA+
					Constants.BLANKINT0+Constants.TILDA+//29
					Constants.BLANKSTRING+Constants.TILDA+//30
					customerEntityBean.getCustomerBussDetails().getMbusaddress3()+Constants.TILDA+//31
					customerEntityBean.getCustomerBussDetails().getMbusaddress4()+Constants.TILDA+//32
					customerEntityBean.getCustomerBussDetails().getMbusarea()+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMbusvillage());	
			fieldCount++;
			
		
			f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
			f1.setAccessible(true);	
			f1.set(inParam, Constants.BLANKINT0+Constants.TILDA+//0
					Constants.BLANKINT0+Constants.TILDA+//1
					customerEntityBean.getCustomerBussDetails().getMmonthlyincome()+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMbusseasonalityjan()+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMbusseasonalityfeb()+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMbusseasonalitymar()+Constants.TILDA+//5
					customerEntityBean.getCustomerBussDetails().getMbusseasonalityapr()+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMbusseasonalitymay()+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMbusseasonalityjun()+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMbusseasonalityjul()+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMbusseasonalityaug()+Constants.TILDA+//10
					customerEntityBean.getCustomerBussDetails().getMbusseasonalitysep()+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMbusseasonalityoct()+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMbusseasonalitynov()+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMbusseasonalitydec()+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMbushighsales()+Constants.TILDA+//15
					customerEntityBean.getCustomerBussDetails().getMbusmediumsales()+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMbuslowsales()+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMbushighincome()+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMbusmediumincom()+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMbuslowincome()+Constants.TILDA+
					Constants.BLANKINT0+Constants.TILDA+
					customerEntityBean.getCustomerBussDetails().getMbusincludesurcalcyn());
			
			fieldCount++;
			
			}
			
			f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
			f1.setAccessible(true);
			f1.set(inParam, "|END8|");		
			fieldCount++;
		
			String addMatching = "";
			String currRes = "";
			String husePropertyStatus = "";
			String huseStructure = "";
			String huseWall = "";
			String huseRoof = "";
			String assetsMulti = "";
			String yrsmovdin = "";
			
			
			f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
			f1.setAccessible(true);
			if(customerEntityBean.getContactPointVerification()!=null) {
				
				if(customerEntityBean.getContactPointVerification().getMaddmatch()!=null) {
					addMatching =customerEntityBean.getContactPointVerification().getMaddmatch();
				}
				
				if(customerEntityBean.getContactPointVerification().getMhouseprptystatus()!=null) {
					husePropertyStatus =customerEntityBean.getContactPointVerification().getMhouseprptystatus();
				}
				
				if(customerEntityBean.getContactPointVerification().getMhousestructure()!=null) {
					huseStructure =customerEntityBean.getContactPointVerification().getMhousestructure();
				}
				
				if(customerEntityBean.getContactPointVerification().getMhousewall()!=null) {
					huseWall =customerEntityBean.getContactPointVerification().getMhousewall();
				}
				if(customerEntityBean.getContactPointVerification().getMhouseroof()!=null) {
					huseRoof =customerEntityBean.getContactPointVerification().getMhouseroof();
				}
				
				if(customerEntityBean.getContactPointVerification().getMassetvissiblecode()!=null) {
					assetsMulti =customerEntityBean.getContactPointVerification().getMassetvissiblecode();
				}
				
				if(customerEntityBean.getContactPointVerification().getMyrsmovdin()!=null) {
					yrsmovdin =customerEntityBean.getContactPointVerification().getMyrsmovdin();
				}
				
				f1.set(inParam, addMatching+Constants.TILDA+yrsmovdin
						+Constants.TILDA+husePropertyStatus
				+Constants.TILDA +huseStructure+Constants.TILDA +huseWall+Constants.TILDA +huseRoof+Constants.exclamation +assetsMulti);	
				fieldCount++;
			}
			
				f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
				f1.setAccessible(true);
				f1.set(inParam, "|END5.1|");
				fieldCount++;
			
			
		} catch (NoSuchFieldException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 

		 
		inParam.setField202("99");	
		//inParam.setField204(Constants.Field204);
		inParam.setField204(Constants.Field204);
		return inParam;

	}



	@Override
	public OmniSoapResultBean prepareResponseRecievedFromOmni(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		return null;
	}

}
