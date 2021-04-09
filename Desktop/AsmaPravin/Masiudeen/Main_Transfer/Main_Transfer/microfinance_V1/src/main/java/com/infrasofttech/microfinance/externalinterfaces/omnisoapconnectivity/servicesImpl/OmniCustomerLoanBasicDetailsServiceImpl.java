package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;

import java.rmi.RemoteException;
import java.time.LocalDateTime;

import org.apache.tomcat.util.bcel.classfile.Constant;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.OmniCustomerLoanBasicDetailsService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.utility.Utility;

@Service
public class OmniCustomerLoanBasicDetailsServiceImpl implements OmniCustomerLoanBasicDetailsService {

	CustomerLoanEntity customerLoanEntity = new CustomerLoanEntity();
	//CustomerEntity customerEntity = new CustomerEntity();
	int customerNumber;
	LocalDateTime lastOpenDate;
	
	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
/*		CustomerLoanEntity customerLoanEntityBean = (CustomerLoanEntity) bean;
		System.out.println("inparams");
		TMsgInParam inParams = prepareRequestToOmni(bean);
		
		System.out.println("Outparams");
		//do Request 
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy= new TOmniServiceSoapProxy();
		try 
		{

			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 910907, inParams);
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
			retBean=prepareResponseRecievedFromOmni(outparam);
			System.out.println(outparam);
			 retBean = new OmniSoapResultBean();
			// retBean.setCustomerNumberOfTab(customerEntityBean.getCompositeCustomerId().getCustomerNumberOfTab());
			// retBean.setCustomerNumberOfCore(outparam.getField203());
			if(!outparam.getField201().equals("0")){
			
				return retBean;
			}

			return retBean;
		}catch (RemoteException e){

		}*/
		System.out.println("wrong method call");
		return null;
	}
	
	
	
	public OmniSoapResultBean omniSoapServiceswithLoanAndCustomer(int customerNo,LocalDateTime lastOpenDate,BaseEntity customerLoan ) {
		//customerEntity = (CustomerEntity)customer;
		this.customerNumber = customerNo;
		this.lastOpenDate = lastOpenDate;
		customerLoanEntity = (CustomerLoanEntity)customerLoan;
		TMsgInParam inParams = new TMsgInParam();
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		
		System.out.println("inparams");
		
		try {
		inParams = prepareRequestToOmni(customerLoan);
		System.out.println(inParams);
		}catch(Exception e) {
			
			retBean = new OmniSoapResultBean();
			retBean.setMCustRefNo(customerLoanEntity.getMrefno());
			retBean.setCreatedBy(customerLoanEntity.getMcreatedby());
			retBean.setTRefno(customerLoanEntity.getTrefno());
			retBean.setStatus(1);
			retBean.setMCustNo(0);
			retBean.setError("Data Not Correctly Submitted");
			return retBean;
		}
		
		
		
		System.out.println("Outparams");
		
		
		//do Request 
		
		TOmniServiceSoapProxy omniServiceSoapProxy= new TOmniServiceSoapProxy();
		
		try 
		{

			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 910920, inParams,true);
			System.out.println("For Loan here starts");
			System.out.println(outparam.getField1());
			System.out.println(outparam.getField2());
			System.out.println(outparam.getField101());
			System.out.println(outparam.getField102());
			System.out.println(outparam.getField103());
			System.out.println(outparam.getField104());
			System.out.println(outparam.getField201());
			System.out.println(outparam.getField204());
			System.out.println(outparam.getField202() +"202 hai yeh loan lead id generation\"");
			System.out.println(outparam.getField203() +"203 hai yeh loan lead id generation");
			System.out.println(outparam.getField202());	
			System.out.println("For Loan here ends");
			retBean=prepareResponseRecievedFromOmni(outparam);
			System.out.println(outparam);
			 retBean = new OmniSoapResultBean();
			retBean.setMLoanRefNo(customerLoanEntity.getMrefno());
			if(!outparam.getField201().equals("0")){
				retBean.setStatus(1);
				retBean.setLoanLeadIdOfCore("");
				retBean.setMleadsid("");
				retBean.setError(outparam.getField203());
				return retBean;
			}
			if(outparam!=null && outparam.getField1() !=null) {
				retBean.setMCustNo(customerNumber);
				//retBean.setTRefno(customerEntity.getTrefno());
				retBean.setMLoanRefNo(customerLoanEntity.getMrefno());
				retBean.setLoanLeadIdOfCore(outparam.getField1());
				retBean.setMleadsid(outparam.getField1());
				retBean.setStatus(0);
			} else {
				retBean.setStatus(1);
				retBean.setLoanLeadIdOfCore("");
				retBean.setMleadsid("");
				retBean.setError(outparam.getField203());
			}
			return retBean;
	
		}catch (RemoteException e){

		}
		return null;
		
	}

	@Override
	public TMsgInParam prepareRequestToOmni(BaseEntity bean) {
		CustomerLoanEntity customerLoanEntityBean = (CustomerLoanEntity) bean;
		TMsgInParam inParam = new TMsgInParam();
		
				
		System.out.println("xxxxxx trying in params");
		if(this.lastOpenDate==null) {
		inParam.setField1(Utility.unFormateDt(customerLoanEntityBean.getMcreateddt()));//appplied date
		}
		else {
			inParam.setField1(Utility.unFormateDt(this.lastOpenDate));
		}
		
			
		
		inParam.setField2(String.valueOf(customerNumber));
		if(customerLoanEntityBean.getMappliedasind().equalsIgnoreCase("0"))
			inParam.setField3(Constants.YES);
		else
		    inParam.setField3(Constants.NO);
		inParam.setField4(String.valueOf(customerLoanEntityBean.getMprdcd()));
		
		if(customerLoanEntityBean.getMleadsid()==null||
				customerLoanEntityBean.getMleadsid().trim().equals("")||
				customerLoanEntityBean.getMleadsid().trim().equals("null")
				) {
			
			inParam.setField5(" "+"~"+customerLoanEntityBean.getMrefno()+customerLoanEntityBean.getTrefno()+LocalDateTime.now());
			
		}else {
			inParam.setField5(customerLoanEntityBean.getMleadsid()+"~"+customerLoanEntityBean.getMrefno()+customerLoanEntityBean.getTrefno()+LocalDateTime.now());
			/*inParam.setField5(String.valueOf(customerLoanEntityBean.getMleadsid()+"~"+
					customerLoanEntityBean.getMrefno()
					));*/
		}
		
			
			inParam.setField6(String.valueOf(customerLoanEntityBean.getMappldloanamt()));	
			inParam.setField7(String.valueOf(customerLoanEntityBean.getMfrequency()));
			inParam.setField8(Utility.unFormateDt(customerLoanEntityBean.getMloandisbdt()));
			inParam.setField9(String.valueOf(customerLoanEntityBean.getMPeriod()));
			inParam.setField10(String.valueOf(Constants.EMPTYSTRING));
			inParam.setField11(String.valueOf(customerLoanEntityBean.getMpurposeofloan()));
			inParam.setField12(String.valueOf(Constants.EMPTYSTRING));
			inParam.setField13(String.valueOf(Constants.EMPTYSTRING));
			inParam.setField14(String.valueOf(Constants.EMPTYSTRING));
			String checkBiometric = Constants.NO;
			String checkResAddChng = Constants.NO;
			String checkRepaySpouse = Constants.NO;
			if(customerLoanEntityBean.getMcheckbiometric()==1)checkBiometric = Constants.YES; 
			if(customerLoanEntityBean.getMcheckresaddchng()==1)checkResAddChng = Constants.YES; 
			if(customerLoanEntityBean.getMcheckspouserepay()==1)checkRepaySpouse = Constants.YES;
			inParam.setField15(String.valueOf(checkBiometric+"~"+checkResAddChng+"~"+checkRepaySpouse));
			inParam.setField16(String.valueOf(customerLoanEntityBean.getMspouserelname()));
			
			
			if(customerLoanEntityBean.getMinststrtdt()!=null&&customerLoanEntityBean.getMappliedasind().equalsIgnoreCase("0")) {
				inParam.setField17(Utility.unFormateDt(customerLoanEntityBean.getMinststrtdt()));
				
			}
			else {
				
				inParam.setField17(String.valueOf(0));
				
			}
			inParam.setField18(String.valueOf(customerLoanEntityBean.getMleadstatus()));
			if(customerLoanEntityBean.getMrouteto()!=null&&!"".equals(customerLoanEntityBean.getMrouteto())) {
				inParam.setField19(String.valueOf(customerLoanEntityBean.getMrouteto()));
				
			}
			else {
				
				inParam.setField19(String.valueOf(Constants.EMPTYSTRING));
				
			}
			inParam.setField20(String.valueOf(""));
			inParam.setField21(String.valueOf(Constants.NO));//herirarchyloop Y OR N
			inParam.setField22(String.valueOf(customerLoanEntityBean.getMappldloanamt()));
			inParam.setField23(String.valueOf(customerLoanEntityBean.getMPeriod()));
			inParam.setField24(String.valueOf(customerLoanEntityBean.getMfrequency()));
			inParam.setField25(String.valueOf(customerLoanEntityBean.getMcreatedby()));
			inParam.setField26(String.valueOf(customerLoanEntityBean.getMlbrcode()));
			
			inParam.setField31(String.valueOf(customerLoanEntityBean.getMsubpurposeofloan()));
			
			
			
			
		//}
		
		
		
		
		
		
		
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
