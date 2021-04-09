package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.infrasofttech.microfinance.entityBeans.master.DisbursmentListEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFLoanClosureHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.GrtAdditionalDetailsHolder;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.utility.Utility;

@Service
@Transactional
public class GrtAdditionalDetailsServiceImpl {

	
public GrtAdditionalDetailsHolder getGrtAdditionalDetails(GrtAdditionalDetailsHolder grtAddtionalDetailsHolder) {
		
		TMsgInParam inParams = new TMsgInParam();
		
		inParams.setField1(String.valueOf("1"));
		inParams.setField2(String.valueOf(grtAddtionalDetailsHolder.getMleadsid()));
		//inParams.setField2("0009090000000149");
		inParams.setField202("99");
		inParams.setField204(Constants.Field204);
		
	
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Data of in params " + inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "6", 45809, inParams);
			
			System.out.println(outparam);
			if(outparam!=null&&outparam.getField201()!=null) {
				if("0".equals(outparam.getField201().trim())) {
					
					return prepareResponseRecievedFromOmni(outparam);
					
				}
				else {
					GrtAdditionalDetailsHolder grtAddtDetailsHolder = new GrtAdditionalDetailsHolder();
					grtAddtDetailsHolder.setMissynctocoresys(2);
					grtAddtDetailsHolder.setMerrormessage(outparam.getField102());
					return grtAddtDetailsHolder;
					
				}
				
				
			}else {
				return null;
			}
			
			
			
			//return prepareResponseRecievedFromOmniForCifCustAuth(outparam);
	
		} catch (RemoteException e) {
				e.printStackTrace();
		}

		return null;
	}
	
	
	public GrtAdditionalDetailsHolder prepareResponseRecievedFromOmni(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		List<GrtAdditionalDetailsHolder> retBeanList = new ArrayList<GrtAdditionalDetailsHolder>();
		
		//System.out.println(" bean response here is " + bean.toString());
		GrtAdditionalDetailsHolder grtAddDetHolder = new GrtAdditionalDetailsHolder();
		try {
			grtAddDetHolder.setMleadsid(bean.getField1());
			grtAddDetHolder.setMinststrtdt(Utility.changeToDt(bean.getField2()));
			grtAddDetHolder.setMinstEndDate(Utility.changeToDt(bean.getField3()));
			
			grtAddDetHolder.setMcusrrentsavingbal(Double.valueOf(bean.getField4()));
			grtAddDetHolder.setMleinamount(Double.valueOf(bean.getField5()));
			
			grtAddDetHolder.setMsdamount(Double.valueOf(bean.getField6()));
			grtAddDetHolder.setMissynctocoresys(1);
			
				 
				
			  
			
			
			
		}catch(Exception e) {
			System.out.println("error in CIF DisbursmentServiceImpl cath");
			grtAddDetHolder = new GrtAdditionalDetailsHolder();
			grtAddDetHolder.setMissynctocoresys(2);
			grtAddDetHolder.setMerrormessage("Account Not Found");
		}
			
		
		 return grtAddDetHolder;
	}
}
