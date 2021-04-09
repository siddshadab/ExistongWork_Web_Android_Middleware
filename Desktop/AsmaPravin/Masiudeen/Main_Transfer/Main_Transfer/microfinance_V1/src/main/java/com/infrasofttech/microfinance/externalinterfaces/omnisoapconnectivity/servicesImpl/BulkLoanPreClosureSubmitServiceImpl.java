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
public class BulkLoanPreClosureSubmitServiceImpl implements BulkLoanPreClosureService {

	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		// TODO Auto-generated method stub
		return null;
	}

	
	@Override
	public TMsgInParam prepareRequestToOmni(List<BulkLoanPreClosureHolderBean> beanList2) {
		
		TMsgInParam inParam = new TMsgInParam();
		int inparamsCount =0;
				
		StringBuilder temp=new StringBuilder();
		Field f1=null;
		
		if (beanList2.get(inparamsCount).getMlbrcode() != 0) {
			inParam.setField1(String.valueOf(beanList2.get(inparamsCount).getMlbrcode()));
		}
		
		for( inparamsCount =0;inparamsCount<beanList2.size();inparamsCount++) {		
			String remark = "";
			if (beanList2.get(inparamsCount).getMremarks() == null) {
				remark = "";
			}			
			
			temp =new StringBuilder();
			temp.append(beanList2.get(inparamsCount).getMprdacctid()).append("~").append(beanList2.get(inparamsCount).getMamttocollect()).append("~");
			temp.append(beanList2.get(inparamsCount).getMcollamt()).append("~").append(beanList2.get(inparamsCount).getMinterestos()).append("~");
			temp.append(remark).append("~").append(beanList2.get(inparamsCount).getMcreatedby());
			
			try {
				int parmsCount =inparamsCount+2;
				f1= TMsgInParam.class.getDeclaredField("field" + ""+parmsCount);
				f1.setAccessible(true);
				f1.set(inParam, temp.toString());				
				parmsCount++;
			} catch (NoSuchFieldException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SecurityException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalArgumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 

		}
		try {
			System.out.println("inparamsCount--"+inparamsCount);
			int endcount = inparamsCount+2;
			System.out.println("endcount--"+endcount);
			f1= TMsgInParam.class.getDeclaredField("field" + ""+endcount);
			f1.setAccessible(true);
			f1.set(inParam, "|END|");
		} catch (NoSuchFieldException | SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}			

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

	public List<BulkLoanPreClosureHolderBean> omniSoapServicesPostLoanClosureVoucher(List<BulkLoanPreClosureHolderBean> beanList) {
		
		TMsgInParam inParams = prepareRequestToOmni(beanList);	
		
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Data of in params " + inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 910917, inParams);
			
			return prepareResponseRecievedFromOmniLoanClosureDetail(outparam);
	
		} catch (RemoteException e) {
				e.printStackTrace();
		}

		return null;
	}
	
	
	public List<BulkLoanPreClosureHolderBean> prepareResponseRecievedFromOmniLoanClosureDetail1(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		List<BulkLoanPreClosureHolderBean> retBeanList = new ArrayList<BulkLoanPreClosureHolderBean>();
		
		System.out.println(" bean response here is " + bean.toString());
		BulkLoanPreClosureHolderBean cifLoanClosureHolderBean;
		cifLoanClosureHolderBean = new BulkLoanPreClosureHolderBean();	
		
		try
		{
			if(bean!=null && bean.getField203() !=null) {
				cifLoanClosureHolderBean.setMomnimsg(bean.getField203());
			}			
			retBeanList.add(cifLoanClosureHolderBean);			
			return retBeanList;
		}
		catch (SecurityException e){
		}
		return null;
	}
	
	public List<BulkLoanPreClosureHolderBean> prepareResponseRecievedFromOmniLoanClosureDetail(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		List<BulkLoanPreClosureHolderBean> retBeanList = new ArrayList<BulkLoanPreClosureHolderBean>();
		
		System.out.println(" bean response here is " + bean.toString());
		BulkLoanPreClosureHolderBean closureHolderBean;
		closureHolderBean = new BulkLoanPreClosureHolderBean();
		for (int outParams = 0; outParams < 103; outParams++) {
			
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
				
				closureHolderBean.setMlbrcode(Integer.valueOf(resultStr[0]));
				closureHolderBean.setMprdacctid(resultStr[1].trim());
				closureHolderBean.setMentrydt(resultStr[2].trim());
				closureHolderBean.setMbatchcd(resultStr[3]);
				closureHolderBean.setMsetno(Integer.valueOf(resultStr[4]));
				closureHolderBean.setMcurcd(resultStr[5]);
				closureHolderBean.setMclosureamtpaid(Double.valueOf(resultStr[6]));
				
				
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
		
		if(bean!=null && bean.getField203() !=null) {
			closureHolderBean.setMomnimsg(bean.getField203());
		}			
		retBeanList.add(closureHolderBean);

		return retBeanList;
	}




	@Override
	public TMsgInParam prepareRequestToOmni(BaseEntity bean) {
		// TODO Auto-generated method stub
		return null;
	}
	
}
