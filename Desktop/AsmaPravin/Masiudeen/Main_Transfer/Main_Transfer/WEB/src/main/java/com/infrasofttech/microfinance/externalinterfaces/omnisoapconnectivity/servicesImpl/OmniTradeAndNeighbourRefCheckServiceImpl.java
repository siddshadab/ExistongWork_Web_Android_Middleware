package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;

import java.rmi.RemoteException;
import org.springframework.stereotype.Service;
import com.infrasofttech.microfinance.entityBeans.master.TradeAndNeighbourRefCheckEntity;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.OmniTradeAndNeighbourRefCheckService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;

@Service
public class OmniTradeAndNeighbourRefCheckServiceImpl implements OmniTradeAndNeighbourRefCheckService {

	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		TradeAndNeighbourRefCheckEntity tradeAndNeighbourRefCheckEntity = (TradeAndNeighbourRefCheckEntity) bean;
		System.out.println("inparams");
		TMsgInParam inParams = prepareRequestToOmni(bean);
		System.out.println("Outparams");
		// do Request
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Dayta of in patrams "+inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 45803, inParams);
			
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
				retBean.setMRefno(tradeAndNeighbourRefCheckEntity.getMrefno());
				
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
		TradeAndNeighbourRefCheckEntity entity = (TradeAndNeighbourRefCheckEntity) bean;
		TMsgInParam inParam = new TMsgInParam();
	
		inParam.setField2(entity.getMleadsid());	
		inParam.setField3(entity.getMsupname());
		inParam.setField4(entity.getMsupaddress());
		inParam.setField5(String.valueOf(entity.getMsupcontact()));
		inParam.setField6(entity.getMsupcredit());
		inParam.setField7(entity.getMsuponcredit());
		inParam.setField8(String.valueOf(entity.getMclientdelay()));
		inParam.setField9(entity.getMdefpayment());
		inParam.setField10(entity.getMproductsup());
		inParam.setField11(String.valueOf(entity.getMsalcycles()));
		inParam.setField12(entity.getMvalsalcycles());
		inParam.setField13(entity.getMloanlender());
		inParam.setField14(entity.getMfacility());
		inParam.setField15(String.valueOf(entity.getMturnover()));
		inParam.setField16(entity.getMremarks());
		inParam.setField17(entity.getMbuyersname());
		inParam.setField18(entity.getMbuyersaddress());
		inParam.setField19(entity.getMcontactno());
		inParam.setField20(String.valueOf(entity.getMbuyingperiod()));
		inParam.setField21(entity.getMcreditbuying());
		inParam.setField22(entity.getMdays());
		inParam.setField23(entity.getMproducts());
		inParam.setField24(entity.getMmonthlypur());
		inParam.setField25(String.valueOf(entity.getMquality()));
		inParam.setField26(entity.getMreliableper());
		inParam.setField27(entity.getMcusremarks());
		inParam.setField28(entity.getMneigname());
		inParam.setField29(entity.getMneigadd());
		inParam.setField30(String.valueOf(entity.getMknownclient()));
		inParam.setField31(String.valueOf(entity.getMimprovement()));
		inParam.setField32(entity.getMrelperson());
		
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
