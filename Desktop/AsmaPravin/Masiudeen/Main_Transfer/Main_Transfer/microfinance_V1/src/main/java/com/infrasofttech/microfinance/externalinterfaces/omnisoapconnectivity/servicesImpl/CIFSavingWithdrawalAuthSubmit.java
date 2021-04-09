package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;

import java.rmi.RemoteException;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFSavingAuthHolder;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.CIFSavingAuthService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.utility.Utility;


@Service
@Transactional
public class CIFSavingWithdrawalAuthSubmit implements CIFSavingAuthService {

	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {

		CIFSavingAuthHolder cifSavingAuthHolder = (CIFSavingAuthHolder) bean;
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		System.out.println("inparams");
		TMsgInParam inParams = new TMsgInParam();
		try {
			inParams = prepareRequestToOmni(bean);	
		}catch(Exception e) {
			
			retBean = new OmniSoapResultBean();
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
			
				outparam = omniServiceSoapProxy.invoke(Constants.Field1, "5", 45241, inParams,true);
			
			if (outparam!=null&&outparam.getField201().equals("0")) {
				System.out.println("Dayta of in patrams 1"+outparam.toString());
				retBean = new OmniSoapResultBean();
				retBean.setStatus(1);			
				retBean.setError(outparam.getField203());
				return retBean;
			}
			System.out.println("Dayta of in patrams 2 "+outparam.toString());
			if(outparam!=null && outparam.getField1() !=null) {
				retBean = new OmniSoapResultBean();
				retBean.setStatus(0);
				retBean.setError(outparam.getField203());		
				return retBean;
				
				
			} else {
				retBean = new OmniSoapResultBean();
				retBean.setStatus(0);
				
				retBean.setError("No Response");
				return retBean;
			}
			
			//return retBean;
		} catch (RemoteException e) {
			System.out.println("Yhan se return null");
			e.printStackTrace();
			retBean = new OmniSoapResultBean();
			retBean.setStatus(0);
			
			retBean.setError("No Response");
			return retBean;
						
		}
		

		

	}

	@Override
	public TMsgInParam prepareRequestToOmni(BaseEntity bean) {
		CIFSavingAuthHolder cifHolderBean = (CIFSavingAuthHolder) bean;
		TMsgInParam inParam = new TMsgInParam();
		
		StringBuilder temp = new StringBuilder();
		String mentryDate = Utility.unFormateDt(cifHolderBean.getMentrydate()); 
		temp.append(cifHolderBean.getMbatchcd()).append(Constants.TILDA).append(mentryDate).append(Constants.TILDA)
		.append(mentryDate).append(Constants.TILDA).append(Constants.space).append(Constants.TILDA).append("A").append(Constants.TILDA)
		.append(Constants.space).append(Constants.TILDA).append(Constants.space).append(cifHolderBean.getMsetno()).append(Constants.TILDA).append(Constants.space).append(Constants.TILDA).append(Constants.YES)
		.append(Constants.TILDA).append(cifHolderBean.getMusercode());
		
		inParam.setField1(temp.toString());
			//inParam.setField1(String.valueOf(cifHolderBean.getMusercode()));
		//BatchCode~EntryDate~EntryDate ~ ~ A ~ ~ 8~~Y~RouteToUserCode
		
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
