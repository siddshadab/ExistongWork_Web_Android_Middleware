package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Service;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CustAuthHolderBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.CIFLoanClosureService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;


@Service
@Transactional
public class CustAuthViewServiceImpl implements CIFLoanClosureService {

	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		// TODO Auto-generated method stub
		return null;
	}

	
	@Override
	public TMsgInParam prepareRequestToOmni(BaseEntity bean) {
		CustAuthHolderBean custAuthHolderBean = (CustAuthHolderBean) bean;
		TMsgInParam inParam = new TMsgInParam();
		
		if( custAuthHolderBean.getMcustno() != 0)
			inParam.setField1(String.valueOf(custAuthHolderBean.getMcustno()));
		
		if( custAuthHolderBean.getMnid() != null)
			inParam.setField2(String.valueOf(custAuthHolderBean.getMnid()));
		
		inParam.setField202("99");
		inParam.setField204(Constants.Field204);	
		return inParam;

	}

	@Override
	public OmniSoapResultBean prepareResponseRecievedFromOmni(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		return null;
	}
	
	List<CustAuthHolderBean> beanList;

	public List<CustAuthHolderBean> omniSoapServicesCustAuthDetailList(CustAuthHolderBean beanList) {
		
		TMsgInParam inParams = prepareRequestToOmni(beanList);	
	
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Data of in params " + inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "6", 910913, inParams);	
			
			return prepareResponseRecievedFromOmniForAuthDetail(outparam);
	
		} catch (RemoteException e) {
				e.printStackTrace();
		}

		return null;
	}
	
	
	public List<CustAuthHolderBean> prepareResponseRecievedFromOmniForAuthDetail(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		List<CustAuthHolderBean> retBeanList = new ArrayList<CustAuthHolderBean>();
		
		System.out.println(" bean response here is " + bean.toString());
		CustAuthHolderBean custAuthHolderBean;
		custAuthHolderBean = new CustAuthHolderBean();	
		
		try
		{
			if(bean.getField1().isEmpty() == false) {
				custAuthHolderBean.setMcustno(Integer.valueOf(bean.getField1())); }
			if(bean.getField2().isEmpty() == false) {
				custAuthHolderBean.setMlbrcode(Integer.valueOf(bean.getField2())); }
			if(bean.getField3().isEmpty() == false) {
				custAuthHolderBean.setMlongname(bean.getField3()); }
			if(bean.getField4().isEmpty() == false) {
				custAuthHolderBean.setMpannodesc(bean.getField4()); }
			if(bean.getField5().isEmpty() == false) {
				custAuthHolderBean.setMcuststatus(Integer.valueOf(bean.getField5())); }
			if(bean.getField6().isEmpty() == false) {
				custAuthHolderBean.setMsexcode(bean.getField6()); }
			if(bean.getField7().isEmpty() == false) {
				custAuthHolderBean.setMdob(bean.getField7()); }
			if(bean.getField8().isEmpty() == false) {
				custAuthHolderBean.setMadd1(bean.getField8()); }
			if(bean.getField9().isEmpty() == false) {
				custAuthHolderBean.setMadd2(bean.getField9()); }
			if(bean.getField10().isEmpty() == false) {
				custAuthHolderBean.setMadd3(bean.getField10()); }
			if(bean.getField11().isEmpty() == false) {
				custAuthHolderBean.setMcountrycd(bean.getField11()); }
			if(bean.getField12().isEmpty() == false) {
				custAuthHolderBean.setMcitycd(bean.getField12()); }
			if(bean.getField13().isEmpty() == false) {
				custAuthHolderBean.setMstate(bean.getField13()); }
			if(bean.getField14().isEmpty() == false) {
				custAuthHolderBean.setMdistcd(Integer.valueOf(bean.getField14())); }
			if(bean.getField15().isEmpty() == false) {
				custAuthHolderBean.setMarea(Integer.valueOf(bean.getField15())); }

			if(bean!=null && bean.getField203() !=null ) {
				custAuthHolderBean.setMerror(bean.getField203());
			}
				
			retBeanList.add(custAuthHolderBean);			
			return retBeanList;
		}
		catch (SecurityException e){
		}
		return null;
	}
	
}
