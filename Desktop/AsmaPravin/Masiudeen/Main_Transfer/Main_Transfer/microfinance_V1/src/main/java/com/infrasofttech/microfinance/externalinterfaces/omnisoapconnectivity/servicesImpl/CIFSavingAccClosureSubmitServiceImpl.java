package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Service;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFLoanClosureHolderBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.CIFLoanClosureService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.CIFService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;


@Service
@Transactional
public class CIFSavingAccClosureSubmitServiceImpl implements CIFLoanClosureService {

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
		if(cifHolderBean.getMprdacctid() != null)  // PrdAccId
		{
			String mprdcd  = cifHolderBean.getMprdacctid().substring(0, 8);
			String mcustno = cifHolderBean.getMprdacctid().substring(9, 16);
			String acctid  = cifHolderBean.getMprdacctid().substring(17, 24);			
			String mprcdacctid = mcustno+"~"+mprdcd+"~"+acctid+"~";
			System.out.println("contractid--" + mprcdacctid);
			inParam.setField1(mprcdacctid);
		}
		
		if( cifHolderBean.getMlbrcode() != 0)
			inParam.setField2(String.valueOf(cifHolderBean.getMlbrcode()));
		inParam.setField3(String.valueOf(cifHolderBean.getMcreatedby()));
		
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

	public List<CIFHolderBean> omniSoapServicesCifPostSavingAcctClosureVoucher(CIFHolderBean beanList) {
		
		TMsgInParam inParams = prepareRequestToOmni(beanList);	
	
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			
			System.out.println("Data of in params " + inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 910922, inParams);
			
			return prepareResponseRecievedFromOmniForSavingAcctClose(outparam);
	
		} catch (RemoteException e) {
				e.printStackTrace();
		}

		return null;
	}
	
	
	public List<CIFHolderBean> prepareResponseRecievedFromOmniForSavingAcctClose(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		List<CIFHolderBean> retBeanList = new ArrayList<CIFHolderBean>();
		
		System.out.println(" bean response here is " + bean.toString());
		CIFHolderBean cifHolderBean;
		cifHolderBean = new CIFHolderBean();	
		
		try
		{
			if( bean.getField2() !=null&& !("").equals(bean.getField2())) {
				cifHolderBean.setMval(bean.getField2());
			}
			if( bean.getField10() !=null&& !("").equals(bean.getField10())) {
				cifHolderBean.setMentrydate(bean.getField10());
			}
			if(bean!=null && bean.getField203() !=null) {
				cifHolderBean.setMomnimsg(bean.getField203());
			}			
				
			retBeanList.add(cifHolderBean);			
			return retBeanList;
		}
		catch (SecurityException e){
		}
		return null;
	}
	
}
