package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;

import java.rmi.RemoteException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.InternalBankTransferHolderBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.InternalBankTransferServices;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
@Service
public class InternalBankTransferServiceImpl implements InternalBankTransferServices {

	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public TMsgInParam prepareRequestToOmni(BaseEntity bean) {
		// TODO Auto-generated method stub
		
		InternalBankTransferHolderBean internalBankTransferBean = (InternalBankTransferHolderBean) bean;
		TMsgInParam inParam = new TMsgInParam();
		
		
			inParam.setField1(String.valueOf(internalBankTransferBean.getMlbrcode()));
			inParam.setField2(String.valueOf(internalBankTransferBean.getMcashtr()));
			if(internalBankTransferBean.getMcashtr()==1) {
				inParam.setField3(String.valueOf(internalBankTransferBean.getMcrdr()));
				inParam.setField4(String.valueOf(internalBankTransferBean.getMaccid()));
				
			}else {
				inParam.setField3(String.valueOf(internalBankTransferBean.getMdraccid()));
				inParam.setField4(String.valueOf(internalBankTransferBean.getMcraccid()));
			}
			inParam.setField5(String.valueOf(internalBankTransferBean.getMamt()));
			inParam.setField6(String.valueOf(internalBankTransferBean.getMnarration()));
			inParam.setField7(String.valueOf(internalBankTransferBean.getMremark()));
			inParam.setField8(String.valueOf(internalBankTransferBean.getMcreatedby()));

			
			
		
		inParam.setField202("99");
		inParam.setField204(Constants.Field204);	
		return inParam;
		
	
	}

	@Override
	public OmniSoapResultBean prepareResponseRecievedFromOmni(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		return null;
	}

	
	
	
public InternalBankTransferHolderBean omniSoapServicesInternalBankTransfer(InternalBankTransferHolderBean bean) {
		
		TMsgInParam inParams = null ;	
	
		TMsgOutParam outparam = null;
		
		
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try 
		{

			inParams = prepareRequestToOmni(bean);
			System.out.println(inParams);
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 910918, inParams);
			System.out.println("Internal Transaction  here starts");
			System.out.println(outparam.getField1());
			System.out.println(outparam.getField2());
			System.out.println(outparam.getField101());
			System.out.println(outparam.getField203() +"203 hai yeh loan lead id generation");
			System.out.println(outparam.getField202());	
			System.out.println("Internal transaction here ends");
			System.out.println(outparam);
			if(outparam!=null && outparam.getField201().trim().equals("0")){
				bean.setMerrormessage(outparam.getField203());
				bean.setMstatus(1);
				bean.setMsetNo(outparam.getField1());
				return bean;
			}
			if(outparam!=null && !outparam.getField201().trim().equals("1")) {
				bean.setMerrormessage(outparam.getField203());
				bean.setMstatus(0);
				bean.setMsetNo(outparam.getField1());
				return bean;
				
			} else {
				bean.setMerrormessage("No Response from server");
				bean.setMsetNo(outparam.getField1());
				bean.setMstatus(0);
				return bean;
			}
	
		}catch (RemoteException e){
			
			bean.setMerrormessage("Something Went wrong");
			bean.setMstatus(0);
			bean.setMsetNo("0");
		

		return bean;
	}
}
}

	

