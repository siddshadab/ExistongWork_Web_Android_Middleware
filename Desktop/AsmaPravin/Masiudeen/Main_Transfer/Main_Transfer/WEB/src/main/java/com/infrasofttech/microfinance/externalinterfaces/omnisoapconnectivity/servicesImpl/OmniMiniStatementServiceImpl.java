package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;
import java.lang.reflect.Field;
import com.infrasofttech.microfinance.utility.Utility;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Service;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.MiniStatementHolderBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.MiniStatementService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;

@Service
public class OmniMiniStatementServiceImpl implements MiniStatementService {

	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {

		return null;
	}

	
	@Override
	public TMsgInParam prepareRequestToOmni(BaseEntity bean) {
		MiniStatementHolderBean miniStatementHolderBean = (MiniStatementHolderBean) bean;
		TMsgInParam inParam = new TMsgInParam();
		
		inParam.setField1(String.valueOf(miniStatementHolderBean.getMprdacctid()));
		inParam.setField2(String.valueOf(miniStatementHolderBean.getMlbrcode()));
		inParam.setField202("99");
		inParam.setField204(Constants.Field204);	
		return inParam;

	}



	@Override
	public OmniSoapResultBean prepareResponseRecievedFromOmni(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		return null;
	}

	
	
	
	
	
	List<MiniStatementHolderBean> beanList;

	public List<MiniStatementHolderBean> omniSoapServicesMiniStatementList(MiniStatementHolderBean beanList) {
		
		TMsgInParam inParams = prepareRequestToOmni(beanList);
	
	
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Dayta of in patrams " + inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 910914, inParams);
			
			return prepareResponseRecievedFromOmniForMiniStatement(outparam);
	
		} catch (RemoteException e) {
			//return prepareResponseRecievedFromOmniForMiniStatement(outparam);
				e.printStackTrace();
		}

		return null;
	}
	
	public List<MiniStatementHolderBean> prepareResponseRecievedFromOmniForMiniStatement(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		List<MiniStatementHolderBean> retBeanList = new ArrayList<MiniStatementHolderBean>();
	
		
		
		System.out.println(" bean response here is " + bean.toString());
		MiniStatementHolderBean miniStatementHolderBean;
		//System.out.println("field f1 = "+TMsgOutParam.class.getDeclaredField("field" + "" + 1));
		//Field f2 = bean.class.getDeclaredField("field2");
		//f2.setAccessible(true);
		//System.out.println("f1");
		/*
		 * //remove this lalter MiniStatementHolderBean mi = new
		 * MiniStatementHolderBean(); mi.setMdrcr("Aagya "); mi.setMlcytrnamt(1000.0);
		 * retBeanList.add(mi); return retBeanList; //till here
		 */
		System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxx");
		System.out.println(beanList);
		for (int outParams = 0; outParams < 103; outParams++) {
			 miniStatementHolderBean = new MiniStatementHolderBean();
			try {

				
				int outParamsLength = outParams + 1;
				//System.out.println("field f1 = "+TMsgOutParam.class.getDeclaredField("field" + "" + outParamsLength));
				Field f1 = TMsgOutParam.class.getDeclaredField("field" + "" + outParamsLength);
				f1.setAccessible(true);
				String str1 = f1.get(bean).toString();
				if(str1.trim().equals("")) {
					break;
				}
				String[] arrOfStr = str1.split("~");
				System.out.println("jhgkjhkj"+arrOfStr.length);

				/*
				 * for (int arrOfStringSingles = 0; arrOfStringSingles <= arrOfStr.length;
				 * arrOfStringSingles++) { miniStatementHolderBean.setMdrcr(arrOfStr[2]);
				 * System.out.print("mlctramt "+ Double.valueOf(arrOfStr[4]));
				 * //miniStatementHolderBean.setMentrydate(LocalDateTime.valueOf(arrOfStr[3]));
				 * miniStatementHolderBean.setMlcytrnamt(Double.valueOf(arrOfStr[4]));
				 * System.out.print("miniStatementHolderBean"+miniStatementHolderBean);
				 * 
				 * // System.out.println(a); }
				 */
				miniStatementHolderBean.setMprdacctid(arrOfStr[0]);
				miniStatementHolderBean.setMlbrcode(Integer.valueOf(arrOfStr[1]));
				miniStatementHolderBean.setMbramchname(arrOfStr[2]);
				miniStatementHolderBean.setMdrcr(arrOfStr[3]);
				//miniStatementHolderBean.setMentrydate(arrOfStr[3]);
				//System.out.print("setMentrydate "+ (arrOfStr[3]));
				

				miniStatementHolderBean.setMentrydate(arrOfStr[4]);

				//miniStatementHolderBean.setMentrydate(Utility.unFormateDt.valueOf(arrOfStr[3]));
				//miniStatementHolderBean.setMentrydate(LocalDateTime.valueOf(arrOfStr[3]));
				miniStatementHolderBean.setMlcytrnamt(Double.valueOf(arrOfStr[5]));
				System.out.print("mlctramt "+ Double.valueOf(arrOfStr[5]));
				miniStatementHolderBean.setMacttotballcy(Double.valueOf(arrOfStr[6]));
				miniStatementHolderBean.setMtotallienfcy(Double.valueOf(arrOfStr[7]));
				miniStatementHolderBean.setMlongname(arrOfStr[8]);
				miniStatementHolderBean.setMparticulars(arrOfStr[9]);


				System.out.print("miniStatementHolderBean"+miniStatementHolderBean);		

				
				
				retBeanList.add(miniStatementHolderBean);
				
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
