package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;

import java.rmi.RemoteException;
import org.springframework.stereotype.Service;
import com.infrasofttech.microfinance.entityBeans.master.SocialAndEnvironmentalEntity;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.OmniSocialAndEnvironmentalService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;

@Service
public class OmniSocialAndEnvironmentalServiceImpl implements OmniSocialAndEnvironmentalService {

	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		SocialAndEnvironmentalEntity socialAndEnvironmentalEntity = (SocialAndEnvironmentalEntity) bean;
		System.out.println("inparams");
		TMsgInParam inParams = prepareRequestToOmni(bean);
		System.out.println("Outparams");
		// do Request
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Dayta of in patrams "+inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 45802, inParams);
			
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
				retBean.setMRefno(socialAndEnvironmentalEntity.getMrefno());
				
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
		SocialAndEnvironmentalEntity entity = (SocialAndEnvironmentalEntity) bean;
		TMsgInParam inParam = new TMsgInParam();
	
		inParam.setField2(entity.getMleadsid());	
		inParam.setField3(String.valueOf(entity.getMbrwexclist()));
		inParam.setField4(String.valueOf(entity.getMbrwnontargetlist()));
		inParam.setField5(String.valueOf(entity.getMbrwairemission()));
		inParam.setField6(String.valueOf(entity.getMbrwwastewater()));
		inParam.setField7(String.valueOf(entity.getMbrwsolidhazardous()));
		inParam.setField8(String.valueOf(entity.getMbrwchemicalfuels()));
		inParam.setField9(String.valueOf(entity.getMbrwnoisefumes()));
		inParam.setField10(String.valueOf(entity.getMbrwresconsuption()));
		inParam.setField11(String.valueOf(entity.getMcinodesignation()));
		inParam.setField12(String.valueOf(entity.getMcinci()));
		inParam.setField13(String.valueOf(entity.getMsilar()));
		inParam.setField14(String.valueOf(entity.getMsidrofls()));
		inParam.setField15(String.valueOf(entity.getMsiils()));
		inParam.setField16(String.valueOf(entity.getMsiiip()));
		inParam.setField17(String.valueOf(entity.getMsicnc()));
		inParam.setField18(String.valueOf(entity.getMsiasc()));
		inParam.setField19(String.valueOf(entity.getMsinsi()));
		inParam.setField20(String.valueOf(entity.getMlinpp()));
		inParam.setField21(String.valueOf(entity.getMliieh()));
		inParam.setField22(String.valueOf(entity.getMliiwc()));
		inParam.setField23(String.valueOf(entity.getMliite()));
		inParam.setField24(String.valueOf(entity.getMliueo()));
		inParam.setField25(String.valueOf(entity.getMlipmw()));
		inParam.setField26(String.valueOf(entity.getMliema()));
		inParam.setField27(String.valueOf(entity.getMlicfl()));
		inParam.setField28(String.valueOf(entity.getMlipevc()));
		inParam.setField29(String.valueOf(entity.getMlireou()));
		inParam.setField30(String.valueOf(entity.getMlinli()));
		inParam.setField31(String.valueOf(entity.getMbrwcat()));
		
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
