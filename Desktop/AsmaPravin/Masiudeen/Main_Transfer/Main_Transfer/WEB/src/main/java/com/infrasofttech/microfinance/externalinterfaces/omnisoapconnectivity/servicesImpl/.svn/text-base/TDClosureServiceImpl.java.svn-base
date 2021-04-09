package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;

import java.rmi.RemoteException;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.InternalBankTransferHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.TDClosureHolder;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.TDClosureServices;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.utility.Utility;

@Service
@Transactional
public class TDClosureServiceImpl implements TDClosureServices {

	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public TMsgInParam prepareRequestToOmni(BaseEntity bean) {
		TDClosureHolder tdClosureHolder = (TDClosureHolder) bean;
		TMsgInParam inParam = new TMsgInParam();
		
		
		inParam.setField1(String.valueOf(tdClosureHolder.getMlbrcode()));
		inParam.setField2(String.valueOf(tdClosureHolder.getMprdacctid()));
		//inParam.setField2("20058006000938850000000100000012");
		inParam.setField3(String.valueOf(tdClosureHolder.getMcshorsav()));
		if(tdClosureHolder.getMcshorsav()==1) {
			inParam.setField4(String.valueOf(tdClosureHolder.getMselectedsavingacc()));
			//inParam.setField4("10011000000000010000000100000000");
		}
		//inParam.setField5(String.valueOf(tdClosureHolder.getMmatamt()));
		inParam.setField202("99");
		inParam.setField204(Constants.Field204);	
		return inParam;
		
	}

	@Override
	public OmniSoapResultBean prepareResponseRecievedFromOmni(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	
	public void omniRequestCloseTD(TDClosureHolder bean) {
		TMsgInParam inParams = null ;	
		
		TMsgOutParam outparam = null;
		
		
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try 
		{

			inParams = prepareRequestToOmni(bean);
			System.out.println(inParams);
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 910919, inParams);
			
			
			
			System.out.println("fetch Term Deposit Closure  here starts");
			System.out.println(outparam.getField1());
			System.out.println(outparam.getField2());
			System.out.println(outparam.getField101());
			System.out.println(outparam.getField203() +"203 hai yeh loan lead id generation");
			System.out.println(outparam.getField202());	
			System.out.println("Internal transaction here ends");
			System.out.println(outparam);
			if(outparam!=null && outparam.getField201().trim().equals("0")){
				bean.setMerrormessage("SuccessFull call");
				bean.setMstatus(1);
				bean.setMaccountopenningdt(outparam.getField2());
				bean.setMmatdt(Utility.changeToDt(outparam.getField3()));
				bean.setMintrate(Double.valueOf(outparam.getField4()));
				bean.setMdepositamt(Double.valueOf(outparam.getField5()));
				bean.setMmainbal(Double.valueOf(outparam.getField6()));
				bean.setMintprovided(Double.valueOf(outparam.getField6()));
				
			}
			else if(outparam!=null && !outparam.getField201().trim().equals("1")) {
				bean.setMerrormessage(outparam.getField203());
				bean.setMstatus(0);
				
				
			} else {
				bean.setMerrormessage("No Response from server");
				bean.setMstatus(0);
				
			}
	
		}catch (RemoteException e){
			
			bean.setMerrormessage("Something Went wrong");
			bean.setMstatus(0);
		

		
	}
		
		
	}

}
