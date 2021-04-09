package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Service;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFHolderBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.CIFLoanClosureService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;


@Service
@Transactional
public class CIFSavingAccClosureServiceImpl implements CIFLoanClosureService {

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

	public List<CIFHolderBean> omniSoapServicesCifSavingClosureDetailList(CIFHolderBean beanList) {
		
		TMsgInParam inParams = prepareRequestToOmni(beanList);	
	
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Data of in params " + inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "6", 910922, inParams);
			
			
			
			return prepareResponseRecievedFromOmniForLoanDetail(outparam);
	
		} catch (RemoteException e) {
				e.printStackTrace();
		}

		return null;
	}
	
	
	public List<CIFHolderBean> prepareResponseRecievedFromOmniForLoanDetail(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		List<CIFHolderBean> retBeanList = new ArrayList<CIFHolderBean>();
		
		System.out.println(" bean response here is " + bean.toString());
		CIFHolderBean cifHolderBean;
		cifHolderBean = new CIFHolderBean();	
		
		try
		{
			System.out.println("field1 --" + bean.getField1() + "xxxx");
			System.out.println("tttt--"+ bean.getField1().isEmpty());
			//if(bean!=null && bean.getField1() !=null || bean.getField1() != "null") {
			if(bean.getField1().isEmpty() == false) {
				String[] resultStr1 = bean.getField1().split("~");
				cifHolderBean.setMacctstat(Integer.valueOf(resultStr1[0]));
				cifHolderBean.setMacctstatdesc(resultStr1[1]);
			}
			
			if(bean.getField3().isEmpty() == false) {
				cifHolderBean.setMopendate(bean.getField3()); }
			
			if(bean.getField4().isEmpty() == false) {
				String[] resultStr = bean.getField4().split("~");
				cifHolderBean.setMshadowclearbal(Double.valueOf(resultStr[0]));
				cifHolderBean.setMshadowtotalbal(Double.valueOf(resultStr[1]));
				cifHolderBean.setMactualclearbal(Double.valueOf(resultStr[2]));
				cifHolderBean.setMactualtotalbal(Double.valueOf(resultStr[3]));
				cifHolderBean.setMlcybal(Double.valueOf(resultStr[4]));
				cifHolderBean.setMtotallien(Double.valueOf(resultStr[5]));
			}
			
			if(bean.getField6().isEmpty() == false) {
				String[] resultStr6 = bean.getField6().split("~");
				cifHolderBean.setMintapplied(Double.valueOf(resultStr6[2]));
			}
			
			
			if(bean!=null && bean.getField203() !=null ) {
				cifHolderBean.setMerror(bean.getField203());
			}
				
			retBeanList.add(cifHolderBean);			
			return retBeanList;
		}
		catch (SecurityException e){
		}
		return null;
	}
	
}
