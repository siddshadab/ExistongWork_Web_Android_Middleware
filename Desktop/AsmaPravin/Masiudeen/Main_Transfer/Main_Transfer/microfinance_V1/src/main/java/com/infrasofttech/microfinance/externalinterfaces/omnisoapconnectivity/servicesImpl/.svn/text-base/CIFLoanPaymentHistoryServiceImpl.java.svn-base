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
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFLoanPaymentHistoryHolderBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.CIFRepayScheduleService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.CIFService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.utility.Utility;


@Service
@Transactional
public class CIFLoanPaymentHistoryServiceImpl implements CIFRepayScheduleService {

	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		// TODO Auto-generated method stub
		return null;
	}

	
	@Override
	public TMsgInParam prepareRequestToOmni(BaseEntity bean) {
		CIFLoanPaymentHistoryHolderBean cifLoanPaymentHistoryHolderBean = (CIFLoanPaymentHistoryHolderBean) bean;
		TMsgInParam inParam = new TMsgInParam();
		
		System.out.println("prdaccid--" + cifLoanPaymentHistoryHolderBean.getMprdacctid());
		if(cifLoanPaymentHistoryHolderBean.getMprdacctid() != null)  // PrdAccId
		{
			String mprdcd  = cifLoanPaymentHistoryHolderBean.getMprdacctid().substring(0, 8);
			String mcustno = cifLoanPaymentHistoryHolderBean.getMprdacctid().substring(9, 16);
			String acctid  = cifLoanPaymentHistoryHolderBean.getMprdacctid().substring(17, 24);			
			String mprcdacctid = mcustno+"~"+mprdcd+"~"+acctid+"~";
			System.out.println("contractid--" + mprcdacctid);
			inParam.setField2(mprcdacctid);
		}
		
		if( cifLoanPaymentHistoryHolderBean.getMlbrcode() != 0)
			inParam.setField5(String.valueOf(cifLoanPaymentHistoryHolderBean.getMlbrcode()));
	
		inParam.setField202("99");
		inParam.setField204(Constants.Field204);	
		return inParam;

	}

	@Override
	public OmniSoapResultBean prepareResponseRecievedFromOmni(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		return null;
	}
	
	List<CIFLoanPaymentHistoryHolderBean> beanList;

	public List<CIFLoanPaymentHistoryHolderBean> omniSoapServicesPaymentDetailHistory(CIFLoanPaymentHistoryHolderBean beanList) {
		
		TMsgInParam inParams = prepareRequestToOmni(beanList);	
	
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Data of in params " + inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "6", 30225, inParams);
			
			return prepareResponseRecievedFromOmniForCifLoanPaymentHistory(outparam);
	
		} catch (RemoteException e) {
				e.printStackTrace();
		}

		return null;
	}
	
	
	public List<CIFLoanPaymentHistoryHolderBean> prepareResponseRecievedFromOmniForCifLoanPaymentHistory(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		List<CIFLoanPaymentHistoryHolderBean> retBeanList = new ArrayList<CIFLoanPaymentHistoryHolderBean>();
		
		System.out.println(" bean response here is " + bean.toString());
		CIFLoanPaymentHistoryHolderBean cifLoanPaymentHistoryHolderBean;
		
		System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxx");
		System.out.println(beanList);
		for (int outParams = 0; outParams < 103; outParams++) {
			cifLoanPaymentHistoryHolderBean = new CIFLoanPaymentHistoryHolderBean();
			try {

				
				int outParamsLength = outParams + 1;
				Field f1 = TMsgOutParam.class.getDeclaredField("field" + "" + outParamsLength);
				f1.setAccessible(true);
				String str1 = f1.get(bean).toString();
				
				if(!str1.trim().equals("")) {
				
					String[] resultStr = Utility.split(str1,'|');
				
					cifLoanPaymentHistoryHolderBean.setMdtOfPayment(resultStr[0]);//1
					cifLoanPaymentHistoryHolderBean.setMtype(resultStr[1]);//4
					cifLoanPaymentHistoryHolderBean.setMinstAmt(Double.valueOf(resultStr[2]));//5
					cifLoanPaymentHistoryHolderBean.setMamtOfTrans(Double.valueOf(resultStr[3]));//6
					cifLoanPaymentHistoryHolderBean.setMprincRecvd(Double.valueOf(resultStr[4]));//7
					cifLoanPaymentHistoryHolderBean.setMintRecvd(Double.valueOf(resultStr[5]));//8
					cifLoanPaymentHistoryHolderBean.setMpenalIntRecvd(Double.valueOf(resultStr[6]));//10
					cifLoanPaymentHistoryHolderBean.setMchrgsRecvd(Double.valueOf(resultStr[7]));//11
					cifLoanPaymentHistoryHolderBean.setMwriteOffAmt(Double.valueOf(resultStr[8]));//12
					cifLoanPaymentHistoryHolderBean.setMwriteOffAmtRecvd(Double.valueOf(resultStr[9]));//13
					cifLoanPaymentHistoryHolderBean.setMcommissRecvd(Double.valueOf(resultStr[10]));//14
					cifLoanPaymentHistoryHolderBean.setMprincOutstand(Double.valueOf(resultStr[11]));//15
					cifLoanPaymentHistoryHolderBean.setMnarration(resultStr[12]);//16
					cifLoanPaymentHistoryHolderBean.setMdtIdealrePayment(resultStr[13]);//2
					cifLoanPaymentHistoryHolderBean.setMdiffInDay(resultStr[14]);
					cifLoanPaymentHistoryHolderBean.setMinstNumber(resultStr[16]);//3
					
					retBeanList.add(cifLoanPaymentHistoryHolderBean);
					System.out.println("retBeanList--"+retBeanList);
				
				}
				
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

		return retBeanList;
	}

}
