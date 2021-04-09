package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;

import java.rmi.RemoteException;

import org.apache.tomcat.util.bcel.classfile.Constant;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanCashFlowEntity;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.TDClosureHolder;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.OmniCustomerLoanCashFlowService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;

@Service
public class OmniCustomerLoanCashFlowServiceImpl implements OmniCustomerLoanCashFlowService {

	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		// TODO Auto-generated method stub
		CustomerLoanCashFlowEntity customerCashFlow = (CustomerLoanCashFlowEntity) bean;
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		System.out.println("inparams");
		TMsgInParam inParams = new TMsgInParam();
		try {
			inParams = prepareRequestToOmni(bean);	
		}catch(Exception e) {
			
			retBean = new OmniSoapResultBean();
			retBean.setMCustRefNo(customerCashFlow.getMrefno());
			retBean.setCreatedBy(customerCashFlow.getMcreatedby());
			retBean.setTRefno(customerCashFlow.getTrefno());
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
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 45806, inParams);
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
			retBean = new OmniSoapResultBean();		
			retBean.setMCustRefNo(customerCashFlow.getMrefno());
			retBean.setCreatedBy(customerCashFlow.getMcreatedby());
			retBean.setMRefno(customerCashFlow.getMrefno());
			retBean.setTRefno(customerCashFlow.getTrefno());
			if (!outparam.getField201().equals("0")) {
				System.out.println("Dayta of in patrams 1"+outparam.toString());
				retBean.setStatus(1);				
				retBean.setError(outparam.getField203());
				return retBean;
			}
			System.out.println("Dayta of in patrams 2 "+outparam.toString());
			if(outparam!=null && outparam.getField1() !=null) {
				retBean.setStatus(0);
				retBean.setError(outparam.getField203());
			} else {
				retBean.setStatus(1);
				retBean.setMCustNo(0);
				retBean.setError(outparam.getField203());
			}
			
			return retBean;
		} catch (RemoteException e) {
			
			retBean = new OmniSoapResultBean();	
			retBean.setMRefno(customerCashFlow.getMrefno());
			retBean.setMCustRefNo(customerCashFlow.getMrefno());
			retBean.setCreatedBy(customerCashFlow.getMcreatedby());
			retBean.setStatus(1);
			retBean.setMCustNo(0);				
			retBean.setError("No Response");
			return retBean;
			
		}
		

		

	}

	@Override
	public TMsgInParam prepareRequestToOmni(BaseEntity bean) {
		CustomerLoanCashFlowEntity customerLoanCashFlowEntity = (CustomerLoanCashFlowEntity) bean;
		TMsgInParam inParam = new TMsgInParam();
		
		
		inParam.setField1(String.valueOf(Constants.space));
		inParam.setField2(String.valueOf(customerLoanCashFlowEntity.getMleadsid()));
		//inParam.setField2("20058006000938850000000100000012");
		inParam.setField3(String.valueOf(customerLoanCashFlowEntity.getMfimainbsinc()));
		inParam.setField4(String.valueOf(customerLoanCashFlowEntity.getMfisubbusinc()));
		inParam.setField5(String.valueOf(customerLoanCashFlowEntity.getMfirentalinc()));
		inParam.setField6(String.valueOf(customerLoanCashFlowEntity.getMfiotherinc()));
		inParam.setField7(String.valueOf(customerLoanCashFlowEntity.getMbepurequipments()));
		inParam.setField8(String.valueOf(customerLoanCashFlowEntity.getMbepetrolcost()));
		inParam.setField9(String.valueOf(customerLoanCashFlowEntity.getMbewages()));
		inParam.setField10(String.valueOf(customerLoanCashFlowEntity.getMberent()));
		inParam.setField11(String.valueOf(customerLoanCashFlowEntity.getMbeeemi()));
		inParam.setField12(String.valueOf(customerLoanCashFlowEntity.getMfefoodexp()));
		inParam.setField13(String.valueOf(customerLoanCashFlowEntity.getMfemobileexp()));
		inParam.setField14(String.valueOf(customerLoanCashFlowEntity.getMfemedicalexp()));
		inParam.setField15(String.valueOf(customerLoanCashFlowEntity.getMfeschoolfees()));
		inParam.setField16(String.valueOf(customerLoanCashFlowEntity.getMfecollegefees()));
		inParam.setField17(String.valueOf(customerLoanCashFlowEntity.getMfemiscellaneous()));
		inParam.setField18(String.valueOf(customerLoanCashFlowEntity.getMfeelectricity()));
		inParam.setField19(String.valueOf(customerLoanCashFlowEntity.getMfesocialcharity()));
		inParam.setField20(String.valueOf(customerLoanCashFlowEntity.getMsurpluscash()));
		
	
		
		inParam.setField202("99");
		inParam.setField204(Constants.Field204);	
		return inParam;
	}

	@Override
	public OmniSoapResultBean prepareResponseRecievedFromOmni(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		return null;
	}

}
