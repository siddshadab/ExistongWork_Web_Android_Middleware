package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;


import java.lang.reflect.Field;
import java.rmi.RemoteException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.infrasofttech.microfinance.entityBeans.master.DisbursmentListEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFLoanClosureHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFSavingAuthHolder;
import com.infrasofttech.microfinance.entityBeans.master.holder.GrtAdditionalDetailsHolder;
import com.infrasofttech.microfinance.entityBeans.master.holder.LoanSimulatorHolder;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.utility.Utility;

@Service
@Transactional
public class LoanSimulatorServiceImpl {

	
public List<LoanSimulatorHolder> getLoanSimulatorDetails( LoanSimulatorHolder loanSimObj2) {
		
		TMsgInParam inParams = new TMsgInParam();
		
//		List<LoanSimulatorHolder> retBeanList2 = new ArrayList<LoanSimulatorHolder>();
//		LoanSimulatorHolder loanObj = new LoanSimulatorHolder();
//		loanObj.setSrno(1);
//		loanObj.setIdealbaldate(LocalDateTime.now());
//		loanObj.setInterest(12.0);
//		loanObj.setMissynctocoresys(1);
//		loanObj.setMerrormessage("");
//		loanObj.setOpeningbalance(42.0);
//		loanObj.setOutstandingprinciple(15.0);
//		loanObj.setPrinciple(52.0);
//		
//		for(int i = 0; i<10;i++) {
//			retBeanList2.add(loanObj);
//		}
//		return retBeanList2;
		
		
		//inParams.setField1(String.valueOf("1"));
		//inParams.setField1(String.valueOf(grtAddtionalDetailsHolder.getMleadsid()));
		inParams.setField1(loanSimObj2.getLeadsid());
		inParams.setField202("99");
		inParams.setField204(Constants.Field204);
		
	
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Data of in params " + inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "6", 910923, inParams);
			
			System.out.println(outparam);
			if(outparam!=null&&outparam.getField201()!=null) {
				if("0".equals(outparam.getField201().trim())) {
					
					return prepareResponseRecievedFromOmni(outparam);
					
				}
				else {
					List<LoanSimulatorHolder> retBeanList = new ArrayList<LoanSimulatorHolder>();
					LoanSimulatorHolder loanSimObj  = new LoanSimulatorHolder();
					loanSimObj.setMissynctocoresys(2);
					loanSimObj.setMerrormessage(outparam.getField203());
					retBeanList.add(loanSimObj);
					return retBeanList;
					
				}
				
				
			}else {
				return null;
			}
			
			
			
			
		} catch (RemoteException e) {
				e.printStackTrace();
		}

		return null;
	}
	
	
	public List<LoanSimulatorHolder> prepareResponseRecievedFromOmni(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		List<LoanSimulatorHolder> retBeanList = new ArrayList<LoanSimulatorHolder>();
		
		//System.out.println(" bean response here is " + bean.toString());
		LoanSimulatorHolder loanSimObj ;
		try {
			if(bean!=null && bean.getField1() !=null) {

				
				//System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxx");
				//System.out.println(beanList);
				for (int outParams = 0; outParams < 103; outParams++) {
					loanSimObj = new LoanSimulatorHolder();
					try {

						
						int outParamsLength = outParams + 1;
						//System.out.println("field f1 = "+TMsgOutParam.class.getDeclaredField("field" + "" + outParamsLength));
						Field f1 = TMsgOutParam.class.getDeclaredField("field" + "" + outParamsLength);
						f1.setAccessible(true);
						String str1 = f1.get(bean).toString();
						if(str1.trim().equals("")||str1==null) {
							break;
						}
						String[] resultStr = str1.split("~");
						System.out.println("Result String"+resultStr.length);
						loanSimObj.setSrno(Integer.valueOf(resultStr[0]));
						loanSimObj.setIdealbaldate(Utility.changeToDt(resultStr[1]));
						loanSimObj.setPrinciple(Double.valueOf(resultStr[2]));
						loanSimObj.setInterest(Double.valueOf(resultStr[3]));
						loanSimObj.setBalance(Double.valueOf(resultStr[4]));
						loanSimObj.setMissynctocoresys(1); 
					
						
						retBeanList.add(loanSimObj);
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
					loanSimObj = new LoanSimulatorHolder();
					loanSimObj.setMissynctocoresys(0);
					loanSimObj.setMerrormessage("Something Wrong");
					retBeanList.add(loanSimObj);
				}
			
			
			
		}catch(Exception e) {
			System.out.println("error in CIF DisbursmentServiceImpl cath");
			loanSimObj = new LoanSimulatorHolder();
			loanSimObj.setMissynctocoresys(2);
			loanSimObj.setMerrormessage("Account Not Found");
		}
			
		
		 return retBeanList;
	}
}
