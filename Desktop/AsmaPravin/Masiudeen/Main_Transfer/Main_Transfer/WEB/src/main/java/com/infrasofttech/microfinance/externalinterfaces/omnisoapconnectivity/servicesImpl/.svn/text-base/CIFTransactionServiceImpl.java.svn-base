package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;

import java.lang.reflect.Field;
import java.rmi.RemoteException;
import java.time.LocalDateTime;
import java.time.Month;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFTransactionHolderBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.CIFService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;


@Service
@Transactional
public class CIFTransactionServiceImpl implements CIFService {

	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		// TODO Auto-generated method stub
		return null;
	}

	
	@Override
	public TMsgInParam prepareRequestToOmni(BaseEntity bean) {
		//CIFHolderBean cifHolderBean = (CIFHolderBean) bean;
		CIFTransactionHolderBean cifTranHolderBean = (CIFTransactionHolderBean) bean;
		
		TMsgInParam inParam = new TMsgInParam();
		
		//String prdCd = (String.valueOf(cifTranHolderBean.getMprdacctid().substring(0, 8)));
		
		if( cifTranHolderBean.getMprdacctid() != null)     // wsPOSAccountNo
			inParam.setField1(String.valueOf(cifTranHolderBean.getMprdacctid()));
		
		if(cifTranHolderBean.getMamt() != 0 )   //wsPOSTxnAmt
			inParam.setField2(String.valueOf(cifTranHolderBean.getMamt()));
		
		inParam.setField3(""); // wsPOSTxnNo
		
		inParam.setField4(""); // wsPOSReceipNo
		
		inParam.setField5("N"); // wsPOSFlag
		
		inParam.setField6(""); // wsPOSTxnDate
		
		if( cifTranHolderBean.getMcreatedby() != null)
			inParam.setField7(String.valueOf(cifTranHolderBean.getMcreatedby())); // wsPOSFieldOfficer
		
		inParam.setField8(""); // wsPOSTerminalID
		
		inParam.setField9("N"); // IsTxnPost
		
		if(cifTranHolderBean.getMlbrcode() != 0 ) 
			inParam.setField10(String.valueOf(cifTranHolderBean.getMlbrcode()));
		
		inParam.setField11("Y"); // IsEco
		
		if(cifTranHolderBean.getMremark() != null)
			inParam.setField12(String.valueOf(cifTranHolderBean.getMremark()));
		
		if(cifTranHolderBean.getMisbiometricdeclareflagyn() != null)
			inParam.setField13(String.valueOf(cifTranHolderBean.getMisbiometricdeclareflagyn()));
		//Y meanse User has overwritten Biometric Authentication
		
//		if( cifTranHolderBean.getMnarration() != null || cifTranHolderBean.getMremark() != null)
//			inParam.setField12(String.valueOf(cifTranHolderBean.getMnarration()+cifTranHolderBean.getMremark()));
		
		inParam.setField202("99");
		inParam.setField204(Constants.Field204);	
		return inParam;

	}

	@Override
	public OmniSoapResultBean prepareResponseRecievedFromOmni(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		return null;
	}
	
	List<CIFTransactionHolderBean> beanList;

	public List<CIFTransactionHolderBean> omniSoapServicesCifTransactionDetailList(CIFTransactionHolderBean beanList) {
		
		TMsgInParam inParams = prepareRequestToOmni(beanList);	
	
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Data of in params " + inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 55555, inParams);
			
			
			
			return prepareResponseRecievedFromOmniForCifTranstnDetail(outparam);
			//return null;
	
		} catch (RemoteException e) {
				e.printStackTrace();
		}

		return null;
	}
	
	public List<CIFTransactionHolderBean> omniSoapServicesCifWithdrawalDetailList(CIFTransactionHolderBean beanList) {
		
		TMsgInParam inParams = prepareRequestToOmni(beanList);	
	
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Data of in params " + inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 910916, inParams);
			
			
			
			return prepareResponseRecievedFromOmniForCifTranstnDetail(outparam);
			//return null;
	
		} catch (RemoteException e) {
				e.printStackTrace();
		}

		return null;
	}
	
	
	
	public List<CIFTransactionHolderBean> prepareResponseRecievedFromOmniForCifTranstnDetail(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		List<CIFTransactionHolderBean> retBeanList = new ArrayList<CIFTransactionHolderBean>();
		
		System.out.println(" bean response here is " + bean.toString());
		CIFTransactionHolderBean cifTranstnHolderBean;
		cifTranstnHolderBean = new CIFTransactionHolderBean();	
		
		try
		{
			if(bean!=null && bean.getField1() !=null) {
				cifTranstnHolderBean.setMomnitxnrefno(bean.getField1());
			}
			if(bean!=null && bean.getField203() !=null) {
				cifTranstnHolderBean.setMerror(bean.getField203());
			}
				
			retBeanList.add(cifTranstnHolderBean);			
			return retBeanList;
		}
		catch (SecurityException e){
		}
		return null;
	}

}
