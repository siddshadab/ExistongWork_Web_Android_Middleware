package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;

import java.rmi.RemoteException;
import org.springframework.stereotype.Service;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanCPVBusinessRecordEntity;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.OmniCustomerLoanCPVBusinessRecordService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.utility.Utility;

@Service
public class OmniCustomerLoanCPVBusinessRecordServiceImpl implements OmniCustomerLoanCPVBusinessRecordService {

	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		CustomerLoanCPVBusinessRecordEntity customerLoanCPVBusinessRecordEntity = (CustomerLoanCPVBusinessRecordEntity) bean;
		System.out.println("inparams");
		TMsgInParam inParams = prepareRequestToOmni(bean);
		System.out.println("Outparams");
		// do Request
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Dayta of in patrams "+inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 45801, inParams);
			
			System.out.println("here starts");
			
			System.out.println("feidl201"+outparam.getField201());
			System.out.println("feidl204"+outparam.getField204());
			System.out.println("feidl203"+outparam.getField203());
			System.out.println("feidl202"+outparam.getField202());
			System.out.println("here ends");
			retBean = prepareResponseRecievedFromOmni(outparam);
			retBean = new OmniSoapResultBean();		
			
			System.out.println("mrefno--" + retBean.getMRefno());
			
			if (!outparam.getField201().equals("0")) {
				System.out.println("Dayta of in patrams 1"+outparam.toString());
				retBean.setStatus(1);			
				retBean.setError(outparam.getField203());
				return retBean;
			}
			System.out.println("Dayta of in patrams 2 "+outparam.toString());
			if(outparam!=null && outparam.getField1() !=null) {
				System.out.println("outparam.getField1");
				retBean.setStatus(0);
				retBean.setMRefno(customerLoanCPVBusinessRecordEntity.getMrefno());
				
			} else {
				System.out.println("outparam.getField1 - blank");
				retBean.setStatus(1);
				retBean.setError(outparam.getField203());
			}
			
			return retBean;
		} catch (RemoteException e) {

		}

		return null;
	}

	@Override
	public TMsgInParam prepareRequestToOmni(BaseEntity bean) {
		CustomerLoanCPVBusinessRecordEntity entity = (CustomerLoanCPVBusinessRecordEntity) bean;
		TMsgInParam inParam = new TMsgInParam();
	
		inParam.setField2(entity.getMleadsid());	
		inParam.setField3(entity.getMhblocated());
		inParam.setField4(entity.getMbusinessname());
		inParam.setField5(entity.getMbusinessaddress());
		inParam.setField6(entity.getMaddresschanged());
		inParam.setField7(Utility.unFormateDt(entity.getMstartedym()));
		inParam.setField8(String.valueOf(entity.getMpropertystatus()));
		inParam.setField9(String.valueOf(entity.getMshopcondition()));
		inParam.setField10(entity.getMbuslocation());
		inParam.setField11(entity.getMnoofcustomers());
		inParam.setField12(String.valueOf(entity.getMcuslocation()));
		inParam.setField13(String.valueOf(entity.getMcusdealing()));
		inParam.setField14(entity.getMcreditsales());
		inParam.setField15(entity.getMperiodsale());
		inParam.setField16(String.valueOf(entity.getMapplicantsrole()));
		inParam.setField17(entity.getMbuspartner());
		inParam.setField18(String.valueOf(entity.getMkeyperson()));
		inParam.setField19(String.valueOf(entity.getMcusbehaviour()));
		inParam.setField20(entity.getMtransrecord());
		inParam.setField21(String.valueOf(entity.getMrecpurandsal()));
		inParam.setField22(String.valueOf(entity.getMbooksupdated()));
		inParam.setField23(String.valueOf(entity.getMivlandrecord()));
		inParam.setField24(String.valueOf(entity.getMivsalesregister()));
		inParam.setField25(String.valueOf(entity.getMivcreditregister()));
		inParam.setField26(String.valueOf(entity.getMivinventoryregister()));
		inParam.setField27(String.valueOf(entity.getMivsalaryslip()));
		inParam.setField28(String.valueOf(entity.getMivpassbook()));
		inParam.setField29(String.valueOf(entity.getMbuscategories()));
		
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
