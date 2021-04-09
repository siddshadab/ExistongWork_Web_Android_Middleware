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
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFTransactionHolderBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.CIFService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.servicesimpl.CustomerServiceImpl;


@Service
@Transactional
public class CIFCustAuthServiceImpl implements CIFService {
	
	@Autowired
	CustomerServiceImpl customerServiceImpl;

	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		// TODO Auto-generated method stub
		return null;
	}

	
	@Override
	public TMsgInParam prepareRequestToOmni(BaseEntity bean) {
		CIFHolderBean cifHolderBean = (CIFHolderBean) bean;
		TMsgInParam inParam = new TMsgInParam();
		
		if(cifHolderBean.getMcustno() != 0 ) 
			inParam.setField1(String.valueOf(cifHolderBean.getMcustno()));
		
		if( cifHolderBean.getMusrcode() != null)
			inParam.setField2(String.valueOf(cifHolderBean.getMusrcode()));
		
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

	public List<CIFHolderBean> omniSoapServicesCifCustAuth(CIFHolderBean beanList) {
		
		TMsgInParam inParams = prepareRequestToOmni(beanList);	
	
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Data of in params " + inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "5", 910913, inParams);
			
			
			
			return prepareResponseRecievedFromOmniForCifCustAuth(outparam);
	
		} catch (RemoteException e) {
				e.printStackTrace();
		}

		return null;
	}
	
	
	public List<CIFHolderBean> prepareResponseRecievedFromOmniForCifCustAuth(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		List<CIFHolderBean> retBeanList = new ArrayList<CIFHolderBean>();
		
		System.out.println(" bean response here is " + bean.toString());
		CIFHolderBean cifHolderBean;
		cifHolderBean = new CIFHolderBean();	
		
		try
		{
			if(bean.getField1().isEmpty() == false) {
				cifHolderBean.setMcustno(Integer.valueOf(bean.getField1()));
			}
			if(bean.getField3().isEmpty() == false) {
				cifHolderBean.setMcuststatus(Integer.valueOf(bean.getField3()));
			}
			if(bean!=null && bean.getField203() !=null) {
				cifHolderBean.setMerror(bean.getField203());
			}
			
			if (cifHolderBean.getMcustno() != 0) {
				System.out.println("custno" + cifHolderBean.getMcustno());
				System.out.println("custstatus" + cifHolderBean.getMcuststatus());
				customerServiceImpl.updateCustStatusInCustomerDetails(cifHolderBean.getMcustno(), cifHolderBean.getMcuststatus());

			}
				
			retBeanList.add(cifHolderBean);			
			return retBeanList;
		}
		catch (SecurityException e){
		}
		return null;
	}

}
