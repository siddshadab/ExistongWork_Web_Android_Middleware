package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;

import java.lang.reflect.Field;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Service;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.BulkLoanPreClosureHolderBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.BulkLoanPreClosureService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;


@Service
@Transactional
public class BulkLoanPreClosureServiceImpl implements BulkLoanPreClosureService {

	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		// TODO Auto-generated method stub
		return null;
	}

	
	@Override
	public TMsgInParam prepareRequestToOmni(BaseEntity bean) {
		BulkLoanPreClosureHolderBean closureHolderBean = (BulkLoanPreClosureHolderBean) bean;
		TMsgInParam inParam = new TMsgInParam();
		
		if(closureHolderBean.getMgroupcd() != 0 ) 
			inParam.setField1(String.valueOf(closureHolderBean.getMgroupcd()));
		
		if( closureHolderBean.getMlbrcode() != 0)
			inParam.setField2(String.valueOf(closureHolderBean.getMlbrcode()));
		
		inParam.setField202("99");
		inParam.setField204(Constants.Field204);	
		return inParam;

	}

	@Override
	public OmniSoapResultBean prepareResponseRecievedFromOmni(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		return null;
	}
	
	List<BulkLoanPreClosureHolderBean> beanList;

	public List<BulkLoanPreClosureHolderBean> omniSoapServicesBulkClosureList(BulkLoanPreClosureHolderBean beanList) {
		
		TMsgInParam inParams = prepareRequestToOmni(beanList);	
	
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Data of in params " + inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "6", 910917, inParams);
			
			return prepareResponseRecievedFromOmniForBulkClosure(outparam);
	
		} catch (RemoteException e) {
				e.printStackTrace();
		}

		return null;
	}
	
	
	public List<BulkLoanPreClosureHolderBean> prepareResponseRecievedFromOmniForBulkClosure(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		List<BulkLoanPreClosureHolderBean> retBeanList = new ArrayList<BulkLoanPreClosureHolderBean>();
		
		System.out.println(" bean response here is " + bean.toString());
		BulkLoanPreClosureHolderBean closureHolderBean;
		
		for (int outParams = 1; outParams < 103; outParams++) {
			closureHolderBean = new BulkLoanPreClosureHolderBean();
			try {
				
				int outParamsLength = outParams + 1;				
				Field f1 = TMsgOutParam.class.getDeclaredField("field" + "" + outParamsLength);
				f1.setAccessible(true);
				String str1 = f1.get(bean).toString();
				if(str1.trim().equals("")) {
					break;
				}
				String[] resultStr = str1.split("~");
				System.out.println("Result String"+resultStr.length);
				
				closureHolderBean.setMgroupcd(Integer.valueOf(resultStr[0]));
				closureHolderBean.setMcustno(Integer.valueOf(resultStr[1]));
				closureHolderBean.setMcustname(resultStr[2].trim());
				closureHolderBean.setMprdacctid(resultStr[3].trim());
				closureHolderBean.setMinststartdt(resultStr[4]);
				closureHolderBean.setMexcessamt(Double.valueOf(resultStr[5]));
				closureHolderBean.setMinstlamt(Double.valueOf(resultStr[6]));
				closureHolderBean.setMamttocollect(Double.valueOf(resultStr[7]));
				closureHolderBean.setMprincipleos(Double.valueOf(resultStr[9]));
				double interestos = (Double.valueOf(resultStr[7]) - Double.valueOf(resultStr[9]));				
				closureHolderBean.setMinterestos(Double.valueOf(interestos));
				closureHolderBean.setMcollamt(Double.valueOf(resultStr[7]));
				
				retBeanList.add(closureHolderBean);
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

		return retBeanList;
	}


	@Override
	public TMsgInParam prepareRequestToOmni(List<BulkLoanPreClosureHolderBean> beanList2) {
		// TODO Auto-generated method stub
		return null;
	}

}
