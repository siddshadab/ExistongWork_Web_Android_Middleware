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
import com.infrasofttech.microfinance.servicesimpl.SystemParameterServicesImpl;


@Service
@Transactional
public class CIFTransactionServiceImpl implements CIFService {

	@Autowired
	SystemParameterServicesImpl systemParameterServiceIpl;
	
	
	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		// TODO Auto-generated method stub
		return null;
	}

	
	@Override
	public TMsgInParam prepareRequestToOmni(BaseEntity bean) {
		//CIFHolderBean cifHolderBean = (CIFHolderBean) bean;
		String parametercheck = systemParameterServiceIpl.getCodeValue(Constants.ISBIOREQFORAUTH);
		String isPosQueing = systemParameterServiceIpl.getCodeValue(Constants.ISPOSQUEING);
		
		
		System.out.println("parameter check ki value hai "+ parametercheck);
		
		
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
			//inParam.setField7(String.valueOf("FM160373"));
		
		inParam.setField8(""); // wsPOSTerminalID
		
		inParam.setField9("N"); // IsTxnPost
		
		if(cifTranHolderBean.getMlbrcode() != 0 ) 
			inParam.setField10(String.valueOf(cifTranHolderBean.getMlbrcode()));
		
		inParam.setField11("Y"); // IsEco
		
		if(cifTranHolderBean.getMremark() != null)
			inParam.setField12(String.valueOf(cifTranHolderBean.getMremark()));
		
		//inParam.setField13("Y"); // IsOnlineTxn
		
		if(isPosQueing!=null&& isPosQueing.equals(Constants.YES)) {
			inParam.setField13(Constants.NO); //for online queing
		}
		else {
			inParam.setField13(Constants.YES); //for non online queing
		}
		
		
		
		if(parametercheck.equals(Constants.BLANKINT1)) {
			if(cifTranHolderBean.getMisbiometricdeclareflagyn() != null)
				inParam.setField14(String.valueOf(cifTranHolderBean.getMisbiometricdeclareflagyn())); // used in W910916.pas
			//Y meanse User has overwritten Biometric Authentication
			System.out.println("mroute to hai " +cifTranHolderBean.getMrouteto());
			if(cifTranHolderBean.getMrouteto()!=null&&cifTranHolderBean.getMisbiometricdeclareflagyn().equals(Constants.YES)) {
				inParam.setField15(String.valueOf(cifTranHolderBean.getMrouteto()));
			}
			
		}
		else {
			if(cifTranHolderBean.getMisbiometricdeclareflagyn() != null)
				inParam.setField14(String.valueOf(cifTranHolderBean.getMisbiometricdeclareflagyn())); 
			
		}
		
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
			if(bean!=null) {
				
				if( bean.getField1() !=null&&! ("").equals(bean.getField1())) {
					cifTranstnHolderBean.setMomnitxnrefno(bean.getField1());
				}
				System.out.println("yrh chala");
				
				if( bean.getField2() !=null&& !("").equals(bean.getField2())) {
					cifTranstnHolderBean.setMloanoutbal(Double.valueOf(bean.getField2()));
				}
				System.out.println("yrh chala");
				
				if( bean.getField3() !=null&& !("").equals(bean.getField3())) {
					cifTranstnHolderBean.setMloanrepayprin(Double.valueOf(bean.getField3()));
				}
				System.out.println("yrh chala");
				if( bean.getField4() !=null&& !("").equals(bean.getField4())) {
					cifTranstnHolderBean.setMloanrepayint(Double.valueOf(bean.getField4()));
				}
				System.out.println("yrh chala");
				if( bean.getField5() !=null&& !("").equals(bean.getField5())) {
					cifTranstnHolderBean.setMothrchrgpen(Double.valueOf(bean.getField5()));
				}
				System.out.println("yrh chala");
				if( bean.getField6() !=null&& !("").equals(bean.getField6())) {
					cifTranstnHolderBean.setMexcessamt(Double.valueOf(bean.getField6()));
				}
				System.out.println("yrh chala");
				
				
				if( bean.getField7() !=null&& !("").equals(bean.getField7())) {
					cifTranstnHolderBean.setMoverdueintcoll(Double.valueOf(bean.getField7()));
				}
				System.out.println("yrh chala");
				
				if( bean.getField8() !=null&& !("").equals(bean.getField8())) {
					cifTranstnHolderBean.setMentrydate(bean.getField8());
				}
				
				if( bean.getField9() !=null&&! ("").equals(bean.getField9())) {
					cifTranstnHolderBean.setMbatchcd(bean.getField9());
				}
				
				if( bean.getField10() !=null&& !("").equals(bean.getField10())) {
					cifTranstnHolderBean.setMsetno(Integer.valueOf(bean.getField10()));
				}
				
				if( bean.getField11() !=null&& !("").equals(bean.getField11())) {
					cifTranstnHolderBean.setMscrollno(Integer.valueOf(bean.getField11()));
				}
				
				if( bean.getField12() !=null&&! ("").equals(bean.getField12())) {
					cifTranstnHolderBean.setMcurcd(bean.getField12());
				}
				
				if(bean.getField203() !=null&& !("").equals(bean.getField203())) {
					cifTranstnHolderBean.setMerror(bean.getField203());
				}
				System.out.println("Sab chala");
			}
			
				
			retBeanList.add(cifTranstnHolderBean);	
			System.out.println("Returning Liat hai " + retBeanList);
			return retBeanList;
		}
		catch (SecurityException e){
			System.out.println("cxxxxxxxxxxYhan par fat gya hai");
		}
		catch(Exception e) {
			
			System.out.println("Sab fat gya ");
		}
		return null;
	}

}
