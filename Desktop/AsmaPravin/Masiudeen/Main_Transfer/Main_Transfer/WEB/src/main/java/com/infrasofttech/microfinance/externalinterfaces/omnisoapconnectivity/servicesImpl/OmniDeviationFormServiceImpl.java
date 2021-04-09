package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;

import java.rmi.RemoteException;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.DeviationFormEntity;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.OmniDeviationFormService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;

@Service
public class OmniDeviationFormServiceImpl implements OmniDeviationFormService {

	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		DeviationFormEntity deviationFormEntity = (DeviationFormEntity) bean;
		System.out.println("inparams");
		TMsgInParam inParams = prepareRequestToOmni(bean);
		System.out.println("Outparams");
		// do Request
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Dayta of in patrams "+inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 45805, inParams);
			
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
				retBean.setMRefno(deviationFormEntity.getMrefno());
				
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
		DeviationFormEntity entity = (DeviationFormEntity) bean;
		TMsgInParam inParam = new TMsgInParam();
	
		inParam.setField2(entity.getMleadsid());	
		inParam.setField3(entity.getMdevloanapp());
		inParam.setField4(String.valueOf(entity.getMdrnrc()));
		inParam.setField5(String.valueOf(entity.getMdrmni()));
		inParam.setField6(String.valueOf(entity.getMdrdbr()));
		inParam.setField7(String.valueOf(entity.getMdrmfi()));
		inParam.setField8(String.valueOf(entity.getMdrbl()));
		inParam.setField9(entity.getMdevapproval());		
		
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
