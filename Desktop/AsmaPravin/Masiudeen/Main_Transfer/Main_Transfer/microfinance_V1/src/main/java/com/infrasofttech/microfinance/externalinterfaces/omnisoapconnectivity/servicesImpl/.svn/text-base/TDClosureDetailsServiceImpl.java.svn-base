package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;

import java.lang.reflect.Field;
import java.rmi.RemoteException;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.InternalBankTransferHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.TDClosureHolder;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.TDClosureServices;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.utility.Utility;



@Service
@Transactional
public class TDClosureDetailsServiceImpl implements TDClosureServices{

	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public TMsgInParam prepareRequestToOmni(BaseEntity bean) {
		TDClosureHolder tdClosureHolder = (TDClosureHolder) bean;
		TMsgInParam inParam = new TMsgInParam();
		
		
			inParam.setField1(String.valueOf(tdClosureHolder.getMlbrcode()));
			inParam.setField2(String.valueOf(tdClosureHolder.getMprdacctid()));
			//inParam.setField2("20058006000938850000000100000012");
			inParam.setField5(String.valueOf(tdClosureHolder.getMcreatedby()));
		inParam.setField202("99");
		inParam.setField204(Constants.Field204);	
		return inParam;
		
	}

	@Override
	public OmniSoapResultBean prepareResponseRecievedFromOmni(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	public void getTDClosureDetails(TDClosureHolder bean) {
		TMsgInParam inParams = null ;	
		
		TMsgOutParam outparam = null;
		
		
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		
		  try {
		

			inParams = prepareRequestToOmni(bean);
			System.out.println(inParams);
			
				outparam = omniServiceSoapProxy.invoke(Constants.Field1, "6", 910919, inParams);
			
			
			System.out.println("fetch Term Deposit Closure  here starts");
			System.out.println(outparam.getField1());
			System.out.println(outparam.getField2());
			System.out.println(outparam.getField101());
			System.out.println(outparam.getField203() +"203 hai yeh loan lead id generation");
			System.out.println(outparam.getField202());	
			System.out.println("Internal transaction here ends");
			System.out.println(outparam);
			if(outparam!=null && outparam.getField201().trim().equals("0")){
				bean.setMerrormessage("SuccessFull call");
				bean.setMstatus(1);
				
				bean.setMmatintamt(Double.valueOf(outparam.getField1()));
				bean.setMmatdt(Utility.changeToDt(outparam.getField2()));
				bean.setMmatamt(Double.valueOf(outparam.getField3()));
				bean.setMintrate(Double.valueOf(outparam.getField4()));
				bean.setMtds(Double.valueOf(outparam.getField5())); 
				
				
				
				
				
				bean.setMclosintamt(Double.valueOf(outparam.getField6()));
				bean.setMclosdt(Utility.changeToDt(outparam.getField7()));
				bean.setMclosmatamt(Double.valueOf(outparam.getField8()));
				bean.setMclosintrate(Double.valueOf(outparam.getField9()));
				bean.setMclostds(Double.valueOf(outparam.getField10()));
				bean.setMbranchoperdt(Utility.changeToDt(outparam.getField11()));
				
				
				bean.setMmainbal(Double.valueOf(outparam.getField10()));
				
				//bean.setMbranchoperdt(outparam.getField11());
				String savingAccList = "";
				for(int outparamCount =12;outparamCount<223;outparamCount++) {
					
					
					Field f1 = TMsgOutParam.class.getDeclaredField("field" + "" + outparamCount);
					f1.setAccessible(true);
					String str1 = f1.get(outparam).toString();
					if(str1==null||str1.trim().equals("END")||str1.trim().equals("")) {
						break;
					}
					
					
					Field f2 = TMsgOutParam.class.getDeclaredField("field" + "" + outparamCount+1);
					f2.setAccessible(true);
					String aheadString =  f2.get(outparam).toString();
					
					if(aheadString==null||aheadString.trim().equals("END")||aheadString.trim().equals("")) {
						savingAccList = savingAccList +str1;
					}else {
						savingAccList = savingAccList +str1+"~";	
					}
					
					
					
				}
				bean.setMselectedsavingacc(savingAccList);
				
			
				
			}
			else if(outparam!=null && !outparam.getField201().trim().equals("1")) {
				bean.setMerrormessage(outparam.getField203());
				bean.setMstatus(0);
				
				
			} else {
				bean.setMerrormessage("No Response from server");
				bean.setMstatus(0);
				
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
			}catch(RemoteException e) {
				e.printStackTrace();
			}
		
		
	}

}
