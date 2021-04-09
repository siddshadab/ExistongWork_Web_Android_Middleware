package com.infrasofttech.microfinance.omni.service.impl;/**
 * @author neelesh.ahirwar
 */

import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;



@Service
public class GroupService {
	
public  void groupService(){
		
	Map<String, TMsgOutParam> mapOutParams = new HashMap<String,TMsgOutParam>();
		try {
			
			
			mapOutParams=groupServiceRequiest();	
			for(TMsgOutParam outparam : mapOutParams.values()) {
				
		
			StringBuilder b=new StringBuilder();
			b.append(outparam.getField2()+"^|$"+outparam.getField3()+"^|$"+outparam.getField4()+"^|$"+outparam.getField5()+"^|$"+outparam.getField6()+"^|$"+outparam.getField7()+"^|$"+outparam.getField8()+"^|$"+outparam.getField9()+"^|$"+outparam.getField10()+"^|$"+outparam.getField11()+"^|$"+outparam.getField12()+"^|$"+outparam.getField13()+"^|$"+outparam.getField15()+"^|$"+0+"^|$"+0+"^|$"+outparam.getField16()+"^|$"+outparam.getField1()+"^|$"+outparam.getField26()+"^|$"+outparam.getField27()+"^|$"+outparam.getField28()+"^|$"+outparam.getField29()+"^|$"+outparam.getField30()+"^|$"+outparam.getField31()+"^|$"+outparam.getField32()+"^|$"+outparam.getField33()+"^|$"+outparam.getField34()+"^|$"+outparam.getField35()+"^|$"+outparam.getField36()+"^|$"+outparam.getField37()+"^|$"+outparam.getField38()+"^|$"+outparam.getField39()+"^|$"+outparam.getField40()+"^|$"+outparam.getField41()+"^|$"+outparam.getField42()+"^|$"+outparam.getField43()+"^|$"+outparam.getField44()+"^|$"+outparam.getField45()+ "^|$"+outparam.getField46()+"^|$"+outparam.getField47()+"^|$"+outparam.getField48()+"^|$"+outparam.getField49()+"^|$"+outparam.getField50()+"^|$"+outparam.getField51());
			
			String field204Value = b.toString();
			System.out.println("outparamsObj "+outparam);
			System.out.println("outparas1- "+ outparam.getField1());
			System.out.println("outparas2- "+ outparam.getField2());
			System.out.println("outparas3- "+ outparam.getField3());
			System.out.println("outparas7- "+ outparam.getField7());
			System.out.println("outparas8- "+ outparam.getField8());
			System.out.println("outparas9- "+ outparam.getField9());
			System.out.println("outparas15- "+ outparam.getField15());
	/*		//Constants.loginTokenOmni =outparam.getField1() ;
			Constants.Field204=field204Value;
			Constants.Field1=outparam.getField1();
			Constants.Field203=outparam.getField203();*/
			}
			
			
		} catch (Exception e) {			
			
		}
		
		
	}
	
	
	public Map<String,TMsgOutParam> groupServiceRequiest()
	{
		Map<String, TMsgOutParam> mapOutParams = new HashMap<String,TMsgOutParam>();
         	
    	  
    	  TMsgOutParam outParam2 = null;
		
		  TMsgInParam inParam= new TMsgInParam();
		
		  inParam.setField1("D001006~pick2");
		  
		  inParam.setField3("Y");
		  inParam.setField4("0");
		  inParam.setField5("0");
		  inParam.setField7("N");
		  inParam.setField201("99");
		  inParam.setField202("99");
		  inParam.setField204(Constants.Field204);
		  
		  TOmniServiceSoapProxy omniServiceSoapProxy= new TOmniServiceSoapProxy();
		  try 
		  {
			/*  String sessionId= RandomStringUtils.random(32, 0, 20, true, true, "bj81G5RDED3DC6142kasok".toCharArray());;  //createsession();
			  System.out.println("sessionId = " + sessionId);*/
			  for(int i = 0;i<Constants.maxBranchesNumber;i++) {
				  inParam.setField2(i+"!");
				  outParam2 = omniServiceSoapProxy.invoke(Constants.Field1, "0", 91, inParam);
				  mapOutParams.put(i+"",outParam2 );
			  }
			 
			/* if(!outParam2.getField201().equals("0")){
						 
				return mapOutParams;
			}*/
		
			return mapOutParams;
		}catch (RemoteException e){
		   
		}
		return mapOutParams;
               
	}
	
	

}
