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
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFHolderBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.CIFRepayScheduleService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.CIFService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;


@Service
@Transactional
public class CIFRepayScheduleServiceImpl implements CIFRepayScheduleService {

	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		// TODO Auto-generated method stub
		return null;
	}

	
	@Override
	public TMsgInParam prepareRequestToOmni(BaseEntity bean) {
		CIFHolderBean cifHolderBean = (CIFHolderBean) bean;
		TMsgInParam inParam = new TMsgInParam();
		
		System.out.println("prdaccid--" + cifHolderBean.getMprdacctid());
//		if(cifHolderBean.getMprdacctid() != null)  // wsContractID
//		{
//			String mprdcd  = cifHolderBean.getMprdacctid().substring(0, 8);
//			String mcustno = cifHolderBean.getMprdacctid().substring(9, 16);
//			String acctid  = cifHolderBean.getMprdacctid().substring(17, 24);			
//			String mprcdacctid = mcustno+"~"+mprdcd+"~"+acctid+"~";
//			System.out.println("contractid--" + mprcdacctid);
//			inParam.setField3(mprcdacctid);
//		}
		
		if( cifHolderBean.getMleadsid() != null)     // wsLEADid
			inParam.setField20(String.valueOf(cifHolderBean.getMleadsid()));			
		
		inParam.setField202("99");
		inParam.setField204(Constants.Field204);	
		return inParam;

	}

	@Override
	public OmniSoapResultBean prepareResponseRecievedFromOmni(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		return null;
	}
	
	List<CIFHolderBean> beanList;

	public List<CIFHolderBean> omniSoapServicesCifDetailList(CIFHolderBean beanList) {
		
		TMsgInParam inParams = prepareRequestToOmni(beanList);	
	
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Data of in params " + inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "6", 45196, inParams);
			
			
			
			return prepareResponseRecievedFromOmniForCifDetail(outparam);
	
		} catch (RemoteException e) {
				e.printStackTrace();
		}

		return null;
	}
	
	
	public List<CIFHolderBean> prepareResponseRecievedFromOmniForCifDetail(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		List<CIFHolderBean> retBeanList = new ArrayList<CIFHolderBean>();
		
		System.out.println(" bean response here is " + bean.toString());
		CIFHolderBean cifHolderBean;
		
		System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxx");
		System.out.println(beanList);
		for (int outParams = 0; outParams < 103; outParams++) {
			cifHolderBean = new CIFHolderBean();
			try {

				
				int outParamsLength = outParams + 1;
				//System.out.println("field f1 = "+TMsgOutParam.class.getDeclaredField("field" + "" + outParamsLength));
				Field f1 = TMsgOutParam.class.getDeclaredField("field" + "" + outParamsLength);
				f1.setAccessible(true);
				String str1 = f1.get(bean).toString();
				if(str1.trim().equals("")) {
					break;
				}
				String[] resultStr = str1.split("~");
				System.out.println("Result String"+resultStr.length);

				
				cifHolderBean.setMsrno(Integer.valueOf(outParamsLength));
				cifHolderBean.setMwsenddate(resultStr[1]);
				cifHolderBean.setMwseffcontractamt(Double.valueOf(resultStr[2]));
				cifHolderBean.setMwsintamount(Double.valueOf(resultStr[3]));
				cifHolderBean.setMwsidealbal(Double.valueOf(resultStr[4]));
				cifHolderBean.setMwsopenbal(Double.valueOf(resultStr[5]));
				
				retBeanList.add(cifHolderBean);
				System.out.println("retBeanList--"+retBeanList);
				
			} catch (NoSuchFieldException | SecurityException e) {
				// TODO Auto-generated catch block
				System.out.print("exception here");
				e.printStackTrace();
			} catch (IllegalArgumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		// etc.

		return retBeanList;
	}

}
