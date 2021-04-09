package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;

import java.lang.reflect.Field;
import java.rmi.RemoteException;
import java.util.List;

import org.apache.tomcat.util.bcel.classfile.Constant;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CustomerAddressDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerBorrowingDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerFamilyDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerPaymentMethodDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsListEntity;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.OmniCustomerMasterService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.OmniSavingsListService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.utility.Utility;

@Service
public class OmniSavingsListServiceImpl implements OmniSavingsListService {

	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		SavingsListEntity savingsListEntityBean = (SavingsListEntity) bean;
		System.out.println("inparams");
		TMsgInParam inParams = prepareRequestToOmni(bean);
		
		System.out.println("starts");
		System.out.println(inParams);
		System.out.println("ends");
		System.out.println("Outparams");
		// do Request
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Dayta of in patrams "+inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 910910, inParams);
			System.out.println("here starts");
			System.out.println("prdaccid"+outparam.getField1());
			System.out.println("crs"+outparam.getField2());
			System.out.println(outparam.getField101());
			System.out.println(outparam.getField102());
			System.out.println(outparam.getField103());
			System.out.println(outparam.getField104());
			System.out.println("feidl201"+outparam.getField201());
			System.out.println("feidl204"+outparam.getField204());
			System.out.println("feidl203"+outparam.getField203());
			System.out.println("feidl202"+outparam.getField202());
			System.out.println("here ends");
			retBean = prepareResponseRecievedFromOmni(outparam);
			retBean = new OmniSoapResultBean();		
			retBean.setMCustRefNo(savingsListEntityBean.getMrefno());
			System.out.println("mrefno--" + retBean.getMCustRefNo());
			retBean.setCreatedBy(savingsListEntityBean.getMcreatedby());
			retBean.setTRefno(savingsListEntityBean.getTrefno());
			//retBean.setMCustNo(savingsListEntityBean.getMcustno());
			//retBean.setMprdcd(savingsListEntityBean.getMprdcd());
			retBean.setMprdacctid(savingsListEntityBean.getMprdacctid());
			retBean.setMcrs(savingsListEntityBean.getMcrs());
			retBean.setMlongname(savingsListEntityBean.getMlongname());
			if (!outparam.getField201().equals("0")) {
				System.out.println("Dayta of in patrams 1"+outparam.toString());
				retBean.setStatus(1);
				retBean.setMprdacctid("");				
				retBean.setError(outparam.getField203());
				return retBean;
			}
			System.out.println("Dayta of in patrams 2 "+outparam.toString());
			if(outparam!=null && outparam.getField1() !=null&& outparam.getField2() !=null) {
				System.out.println("outparam.getField1");
				retBean.setStatus(0);
				retBean.setMprdacctid(outparam.getField1());
				retBean.setMcrs(outparam.getField2());
				System.out.println("prdacicdddddd----" + retBean.getMprdacctid());
				
			} else {
				System.out.println("outparam.getField1 - blank");
				retBean.setStatus(1);
				retBean.setMprdacctid("");
				retBean.setError(outparam.getField203());
			}
			
			return retBean;
		} catch (RemoteException e) {

		}

		return null;
	}

	@Override
	public TMsgInParam prepareRequestToOmni(BaseEntity bean) {
		SavingsListEntity savingsListEntity = (SavingsListEntity) bean;
		TMsgInParam inParam = new TMsgInParam();
		
		inParam.setField1(String.valueOf(savingsListEntity.getMlbrcode()));
		inParam.setField2(savingsListEntity.getMcustno() + Constants.TILDA + savingsListEntity.getMprdcd() + Constants.TILDA + "0");
		inParam.setField3(savingsListEntity.getMcreatedby());
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
