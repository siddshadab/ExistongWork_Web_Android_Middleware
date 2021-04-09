package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;

import java.rmi.RemoteException;
import java.time.LocalDateTime;
import java.util.Date;

import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.OmniCustomerLoanMasterService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.utility.Utility;

@Service
public class OmniCustomerLoanMasterServiceImpl implements OmniCustomerLoanMasterService {

	String loanNumberOfCore="";
	
	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		/*CustomerLoanEntity customerLoanEntityBean = (CustomerLoanEntity) bean;
		System.out.println("inparams");
		TMsgInParam inParams = prepareRequestToOmni(bean);
		System.out.println("inparams" + inParams.toString());
		System.out.println("Outparams");
		
		//do Request 
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy= new TOmniServiceSoapProxy();
		try 
		{

			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 910903, inParams);
			System.out.println("here starts");
			System.out.println(outparam.getField1());
			System.out.println(outparam.getField2());
			System.out.println(outparam.getField101());
			System.out.println(outparam.getField102());
			System.out.println(outparam.getField103());
			System.out.println(outparam.getField104());
			System.out.println(outparam.getField201());
			System.out.println(outparam.getField204());
			System.out.println(outparam.getField203() +"203 hai yeh");
			System.out.println(outparam.getField202());
			System.out.println("here ends");
			if(outparam.getField201()=="0"&&outparam.getField203()=="Successful Create") {
			
			}
			retBean=prepareResponseRecievedFromOmni(outparam);
			System.out.println(outparam);
			 retBean = new OmniSoapResultBean();
			// retBean.setCustomerNumberOfTab(customerEntityBean.getCompositeCustomerId().getCustomerNumberOfTab());
			// retBean.setCustomerNumberOfCore(outparam.getField203());
			if(!outparam.getField201().equals("0")){
			
				return retBean;
			}
			if(outparam!=null && outparam.getField1() !=null) {				
				retBean.setUsrCode(customerLoanEntityBean.getCompositeLoanId().getUsrCode());
				retBean.setLoanNumberOfTab(customerLoanEntityBean.getCompositeLoanId().getLoanNumberOfTab());
				retBean.setLoanAccountNumberOfCore(outparam.getField1());
			} else {
				retBean.setLoanAccountNumberOfCore("");
			}
			return retBean;
		}catch (RemoteException e){

		}
*/
		return null;
	}

	@Override
	public TMsgInParam prepareRequestToOmni(BaseEntity bean) {
		CustomerLoanEntity customerLoanEntityBean = (CustomerLoanEntity) bean;
		TMsgInParam inParam = new TMsgInParam();
		//RadioCheckBoxesDataBean dataBean = new RadioCheckBoxesDataBean();
		//Utility.setRadioAndCheckBoxesData(customerEntityBean.getRadioCheckBox(),dataBean);
		
		
		//inParam.setField1(loanNumberOfCore.equals("")|| loanNumberOfCore==null?"0":loanNumberOfCore+"~");
		inParam.setField1(loanNumberOfCore);
		//inParam.setField1(String.valueOf(0)+"~C~1"+Constants.TILDA+customerLoanEntityBean.getCompositeLoanId().getCustomerNumberOfTab()+customerLoanEntityBean.getCompositeLoanId().getUsrCode()+customerLoanEntityBean.getCompositeLoanId().getLoanNumberOfTab());
		//inParam.setField1("1111010000013543");
		inParam.setField2(String.valueOf(customerLoanEntityBean.getMprdcd()));
		inParam.setField3(String.valueOf(customerLoanEntityBean.getMappldloanamt()));
		inParam.setField4(Constants.BLANKINT1);
		inParam.setField5(String.valueOf(customerLoanEntityBean.getMfrequency()));
		LocalDateTime d= customerLoanEntityBean.getMloandisbdt();
		//Date d= customerLoanEntityBean.getMloandisbdt();
		System.out.println(d);
		if(d.getDayOfMonth()<10 && d.getMonthValue()<10){
			inParam.setField6(String.valueOf(d.getYear()+"0"+d.getMonthValue()+"0"+d.getDayOfMonth()));
		}else if(d.getDayOfMonth()<10) {
			inParam.setField6(String.valueOf(d.getYear()+""+d.getMonthValue()+"0"+d.getDayOfMonth()));
		}else if(d.getMonthValue()<10){
			inParam.setField6(String.valueOf(d.getYear()+"0"+d.getMonthValue()+""+d.getDayOfMonth()));
		}else {
			inParam.setField6(String.valueOf(d.getYear()+""+d.getMonth()+""+d.getMonth()));
		}
		inParam.setField7(String.valueOf(customerLoanEntityBean.getMPeriod()));
		//inParam.setField8(String.valueOf(customerLoanEntityBean.getEndDate()));
		//.setField9(String.valueOf(customerLoanEntityBean.getRoi()));
		//inParam.setField10(String.valueOf(customerLoanEntityBean.getInstallmentAmount()));
		//inParam.setField11(String.valueOf(customerLoanEntityBean.getDisbursmentDate()));
		//
		inParam.setField12(String.valueOf(customerLoanEntityBean.getMapprvdloanamt()));
		inParam.setField15(Constants.YES);
		inParam.setField16(customerLoanEntityBean.getMpurposeofloan()+"-PersonalLoan");
		
		
		inParam.setField30(Constants.NOTAPPROVED);
		inParam.setField31(String.valueOf(customerLoanEntityBean.getMsubpurposeofloan()));
		inParam.setField32(String.valueOf(customerLoanEntityBean.getMmodeofdisb()));
		inParam.setField39(Constants.NO);
		inParam.setField51(Constants.NO);
		inParam.setField60(Constants.NO);
		inParam.setField61(Constants.NO);
		inParam.setField62(Constants.NO);
		inParam.setField63(Constants.NO);
		inParam.setField64(Constants.NO);
		inParam.setField65(Constants.NO);
		
		
		
		
		
		
		
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

	public OmniSoapResultBean omniSoapServicesLoanAndCustomer(BaseEntity bean, String loanNumberOfCore) {
		this.loanNumberOfCore = loanNumberOfCore; 
		CustomerLoanEntity customerLoanEntityBean = (CustomerLoanEntity) bean;
		System.out.println("inparams");
		TMsgInParam inParams = prepareRequestToOmni(bean);
		//do Request 
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy= new TOmniServiceSoapProxy();
		try 
		{

			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 910903, inParams);			
			System.out.println("loan DEtails outparam here starts");
			System.out.println(outparam);
			System.out.println(outparam.getField1());
			System.out.println(outparam.getField2());
			System.out.println(outparam.getField101());
			System.out.println(outparam.getField102());
			System.out.println(outparam.getField103());
			System.out.println(outparam.getField104());
			System.out.println(outparam.getField201());
			System.out.println(outparam.getField204());
			System.out.println(outparam.getField203() +"203 hai yeh final laoncall");
			System.out.println(outparam.getField202());
			System.out.println("loan DEtails here ends");
			retBean=prepareResponseRecievedFromOmni(outparam);
			
			 retBean = new OmniSoapResultBean();
			// retBean.setCustomerNumberOfTab(customerEntityBean.getCompositeCustomerId().getCustomerNumberOfTab());
			// retBean.setCustomerNumberOfCore(outparam.getField203());
			if(!outparam.getField201().equals("0")){
				retBean.setMLoanRefNo(customerLoanEntityBean.getMrefno());
				retBean.setStatus(1);
				retBean.setLoanAccountNumberOfCore("");
				retBean.setMleadsid("");
				retBean.setError(outparam.getField203());
				if(retBean.getError()!=null&&retBean.getError().length()>=250) {
						String tempError = retBean.getError().substring(0, 245);
						retBean.setError(tempError); 		
				}
				return retBean;
			}	
			if(outparam!=null && outparam.getField1() !=null) {				
				retBean.setCreatedBy(customerLoanEntityBean.getMcreatedby());
				retBean.setTRefno(customerLoanEntityBean.getTrefno());
				retBean.setMLoanRefNo(customerLoanEntityBean.getMrefno());
				retBean.setLoanAccountNumberOfCore(outparam.getField2());
				retBean.setMleadsid(outparam.getField1());
				retBean.setStatus(0);
			} else {
				retBean.setStatus(1);
				retBean.setMleadsid("");
				
				retBean.setError(outparam.getField203());
				if(retBean.getError()!=null&&retBean.getError().length()>=250) {
					String tempError = retBean.getError().substring(0, 245);
					retBean.setError(tempError); 		
			}
			}
			return retBean;
		}catch (RemoteException e){

		}

		return null;
	}

	

}
