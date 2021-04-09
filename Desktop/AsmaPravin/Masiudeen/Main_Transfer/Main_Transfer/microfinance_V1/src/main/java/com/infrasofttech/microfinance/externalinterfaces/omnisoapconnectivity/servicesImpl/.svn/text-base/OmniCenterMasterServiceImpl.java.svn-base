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
import com.infrasofttech.microfinance.entityBeans.master.CentersFoundationEntity;
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
public class OmniCenterMasterServiceImpl implements OmniSavingsListService {

	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		CentersFoundationEntity centersFoundationEntityBean = (CentersFoundationEntity) bean;
		System.out.println("inparams");
		TMsgInParam inParams = prepareRequestToOmni(bean);
		System.out.println("Outparams");
		// do Request
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Dayta of in patrams "+inParams.toString());
			if (centersFoundationEntityBean.getMcenterid() == 0)
			  outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 910904, inParams);
			else
				outparam = omniServiceSoapProxy.invoke(Constants.Field1, "2", 910904, inParams);
				  
			
			System.out.println("here starts");
			System.out.println("CenterID"+outparam.getField1());
			
			
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
				retBean.setMRefno(centersFoundationEntityBean.getMrefno());
				retBean.setStatus(1);			
				retBean.setError(outparam.getField203());
				return retBean;
			}
			System.out.println("Dayta of in patrams 2 "+outparam.toString());
			if(outparam!=null && outparam.getField1() !=null) {
				System.out.println("outparam.getField1");
				retBean.setStatus(0);
				retBean.setMRefno(centersFoundationEntityBean.getMrefno());
				if (centersFoundationEntityBean.getMcenterid() == 0)
					retBean.setCenterId(Integer.parseInt(outparam.getField1()));
				
				System.out.println("getCenterId----" + retBean.getCenterId());
				
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
		CentersFoundationEntity centersFoundationEntity = (CentersFoundationEntity) bean;
		TMsgInParam inParam = new TMsgInParam();
		if (centersFoundationEntity.getMcenterid() == 0)
			inParam.setField1(Constants.TILDA+centersFoundationEntity.getTrefno()+Constants.HIFEN+centersFoundationEntity.getMrefno());
		else
			inParam.setField1(String.valueOf(centersFoundationEntity.getMcenterid()+Constants.TILDA+centersFoundationEntity.getTrefno()+Constants.HIFEN+centersFoundationEntity.getMrefno()));
		inParam.setField2(Utility.unFormateDt(centersFoundationEntity.getMeffectivedt()) + "-" + String.valueOf(centersFoundationEntity.getMlbrcode()));
		inParam.setField3(centersFoundationEntity.getMcentername());
		inParam.setField4(Constants.EMPTYSTRING);
		inParam.setField5(Constants.EMPTYSTRING);
		inParam.setField6(Constants.EMPTYSTRING);
		inParam.setField7(Constants.EMPTYSTRING);
		inParam.setField8(Constants.EMPTYSTRING);
		inParam.setField9(Constants.EMPTYSTRING);
		inParam.setField10(Constants.EMPTYSTRING);
		inParam.setField11(Constants.EMPTYSTRING);
		inParam.setField12(Constants.EMPTYSTRING);
		inParam.setField13(Constants.EMPTYSTRING);
		inParam.setField14(Constants.EMPTYSTRING);
		inParam.setField15(Constants.EMPTYSTRING);
		inParam.setField16(Utility.unFormateDt(centersFoundationEntity.getMformatndt()));
		inParam.setField17(centersFoundationEntity.getMmeetingfreq());
		inParam.setField18(Constants.EMPTYSTRING);
		inParam.setField19(centersFoundationEntity.getMcrs());
		inParam.setField20(centersFoundationEntity.getMmeetinglocn());
		inParam.setField21(Constants.EMPTYSTRING);
		inParam.setField22(Constants.EMPTYSTRING);
		inParam.setField23(Constants.EMPTYSTRING);
		inParam.setField24(String.valueOf(centersFoundationEntity.getMmeetingday()));
		inParam.setField25(Constants.EMPTYSTRING);
		inParam.setField26(Utility.unFormateDt(centersFoundationEntity.getMfirstmeetngdt()));
		inParam.setField27(Utility.unFormateDt(centersFoundationEntity.getMnextmeetngdt()));
		inParam.setField28(Constants.EMPTYSTRING);
		inParam.setField29(Constants.EMPTYSTRING);
		inParam.setField30(centersFoundationEntity.getMgeolatd());
		inParam.setField31(centersFoundationEntity.getMgeologd());
		inParam.setField32(Constants.EMPTYSTRING);
		inParam.setField33(String.valueOf(centersFoundationEntity.getMrepayfrom()));
		inParam.setField34(String.valueOf(centersFoundationEntity.getMrepayto()));
		inParam.setField35(Constants.EMPTYSTRING);
		inParam.setField36(Utility.unFormateDt(centersFoundationEntity.getMeffectivedt()));
		inParam.setField37(Constants.EMPTYSTRING);
		inParam.setField38(Constants.EMPTYSTRING);
		inParam.setField39(Constants.EMPTYSTRING);
		inParam.setField40(Constants.EMPTYSTRING);
		inParam.setField41(Constants.EMPTYSTRING);
		inParam.setField42(Constants.EMPTYSTRING);
		inParam.setField43(Constants.EMPTYSTRING);
		inParam.setField44(Constants.EMPTYSTRING);
		inParam.setField45(Constants.EMPTYSTRING);
		inParam.setField46("1");
		inParam.setField47(Constants.EMPTYSTRING);
		inParam.setField48(Constants.EMPTYSTRING);
		inParam.setField49(Constants.EMPTYSTRING);
		inParam.setField50(Constants.EMPTYSTRING);
		inParam.setField51(Constants.EMPTYSTRING);
		inParam.setField52(Constants.EMPTYSTRING);
		inParam.setField53(Constants.EMPTYSTRING);
		inParam.setField54(Constants.EMPTYSTRING);
		inParam.setField55(Constants.EMPTYSTRING);
				//getMcustno() + Constants.TILDA + savingsListEntity.getMprdcd() + Constants.TILDA + "0");
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
