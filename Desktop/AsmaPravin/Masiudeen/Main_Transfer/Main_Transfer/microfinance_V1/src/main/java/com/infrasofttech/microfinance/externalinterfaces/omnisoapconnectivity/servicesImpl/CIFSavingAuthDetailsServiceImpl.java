package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;

import java.lang.reflect.Field;
import java.rmi.RemoteException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFSavingAuthHolder;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.CIFSavingAuthService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.utility.Utility;


@Service
@Transactional
public class CIFSavingAuthDetailsServiceImpl implements CIFSavingAuthService {

	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean)  {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public TMsgInParam prepareRequestToOmni(BaseEntity bean) {
		CIFSavingAuthHolder cifHolderBean = (CIFSavingAuthHolder) bean;
		TMsgInParam inParam = new TMsgInParam();
		
			inParam.setField1(String.valueOf(cifHolderBean.getMlbrcode()));
		
			inParam.setField2(String.valueOf(cifHolderBean.getMusercode()));
		
		inParam.setField202("99");
		inParam.setField204(Constants.Field204);	
		return inParam;
	}

	@Override
	public OmniSoapResultBean prepareResponseRecievedFromOmni(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	public List<CIFSavingAuthHolder> omniSoapSavingAuthDetails(CIFSavingAuthHolder bean) {
		
		TMsgInParam inParams = prepareRequestToOmni(bean);	
	
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Data of in params " + inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "6", 910916, inParams);
			
			
			
			return prepareResponseRecievedFromOmniForCifDetail(outparam);
//			CIFSavingAuthHolder savWithObj ;
//			List<CIFSavingAuthHolder> retList = new ArrayList<CIFSavingAuthHolder>();
//			for(int i = 1;i<10;i++) {
//				savWithObj = new CIFSavingAuthHolder();
//				 savWithObj.setMcreatedby("FM3734");
//	              savWithObj.setMcustname("Shantanu Khare");
//	              savWithObj.setMsubmitamt(1266124.22); 
//	              savWithObj.setMcreateddt(LocalDateTime.now());
//	              savWithObj.setMsavingacctno("00000001000000010000000100000001");
//	              savWithObj.setMwithdrawalamt(4677.89); 
//	              savWithObj.setMremarks("Acha hai kar do");
//	              savWithObj.setMtotallienfcy(15545.56);
//	              savWithObj.setMentrydate(LocalDateTime.now());
//	              savWithObj.setMtxndate(LocalDateTime.now()); 
//	              savWithObj.setMusercode("Hello"); 
//	              savWithObj.setMbatchcd("En452"); 
//	              savWithObj.setMsetno(456);
//	              savWithObj.setMissynctocoresys(0);
//	              retList.add(savWithObj);
//			}
//			return retList;
	
		} catch (Exception e) {
				e.printStackTrace();
		}

		return null;
	}

	
	public List<CIFSavingAuthHolder> prepareResponseRecievedFromOmniForCifDetail(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		List<CIFSavingAuthHolder> retBeanList = new ArrayList<CIFSavingAuthHolder>();
		
		System.out.println(" bean response here is " + bean.toString());
		CIFSavingAuthHolder cifSavingAuthHolderBean;
		
		if(!bean.getField201().equals("0")){
			cifSavingAuthHolderBean = new CIFSavingAuthHolder();
			cifSavingAuthHolderBean.setMissynctocoresys(0);
			cifSavingAuthHolderBean.setMerrormessage(bean.getField203());
			retBeanList.add(cifSavingAuthHolderBean);
			return retBeanList;
		}
		else if(bean.getField201().equals("0")&&bean.getField1().equals("")) {
			cifSavingAuthHolderBean = new CIFSavingAuthHolder();
			cifSavingAuthHolderBean.setMissynctocoresys(0);
			cifSavingAuthHolderBean.setMerrormessage("No Record to authorize");
			retBeanList.add(cifSavingAuthHolderBean);
			return retBeanList;
			
		}
		if(bean!=null && bean.getField1() !=null) {

		
		//System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxx");
		//System.out.println(beanList);
		for (int outParams = 0; outParams < 103; outParams++) {
			cifSavingAuthHolderBean = new CIFSavingAuthHolder();
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
				cifSavingAuthHolderBean.setMtxndate(Utility.changeToDt(resultStr[0]));
				cifSavingAuthHolderBean.setMsavingacctno(resultStr[1]);
				cifSavingAuthHolderBean.setMacttotbalfcy(Double.valueOf(resultStr[3]));
				cifSavingAuthHolderBean.setMtotallienfcy(Double.valueOf(resultStr[4]));
				cifSavingAuthHolderBean.setMwithdrawalamt(Double.valueOf(resultStr[5]));
				cifSavingAuthHolderBean.setMremarks(resultStr[6]);
				cifSavingAuthHolderBean.setMcreatedby(resultStr[7]);
				cifSavingAuthHolderBean.setMentrydate(Utility.changeToDt(resultStr[8]));
				cifSavingAuthHolderBean.setMbatchcd(resultStr[9]);
				cifSavingAuthHolderBean.setMsetno(Integer.valueOf(resultStr[10]));
				cifSavingAuthHolderBean.setMcustname(resultStr[11]);
				cifSavingAuthHolderBean.setMissynctocoresys(1);
				
				
				retBeanList.add(cifSavingAuthHolderBean);
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
		} else {
			cifSavingAuthHolderBean = new CIFSavingAuthHolder();
			cifSavingAuthHolderBean.setMissynctocoresys(0);
			cifSavingAuthHolderBean.setMerrormessage("Something Wrong");
			retBeanList.add(cifSavingAuthHolderBean);
		}
		// etc.

		return retBeanList;
	}
}
