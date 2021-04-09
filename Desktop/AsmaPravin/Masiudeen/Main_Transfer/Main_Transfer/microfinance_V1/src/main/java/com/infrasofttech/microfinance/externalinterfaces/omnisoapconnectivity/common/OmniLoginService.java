package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.rmi.RemoteException;

import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;


@Component
@PropertySource("classpath:ecoMiddlewareConfig.properties")
public class OmniLoginService {
	
	@Autowired
	private Environment envr;

	
	
	public TMsgOutParam loginOmni(){
		
		
		System.out.println("aa gya login m");
		
		TMsgOutParam outparam = null;
		try {
			
			
			outparam=login();			
			StringBuilder b=new StringBuilder();
			b.append(outparam.getField2()+"^|$"+outparam.getField3()+"^|$"+outparam.getField4()+"^|$"+outparam.getField5()+"^|$"+outparam.getField6()+"^|$"+outparam.getField7()+"^|$"+outparam.getField8()+"^|$"+outparam.getField9()+"^|$"+outparam.getField10()+"^|$"+outparam.getField11()+"^|$"+outparam.getField12()+"^|$"+outparam.getField13()+"^|$"+outparam.getField15()+"^|$"+0+"^|$"+0+"^|$"+outparam.getField16()+"^|$"+outparam.getField1()+"^|$"+outparam.getField26()+"^|$"+outparam.getField27()+"^|$"+outparam.getField28()+"^|$"+outparam.getField29()+"^|$"+outparam.getField30()+"^|$"+outparam.getField31()+"^|$"+outparam.getField32()+"^|$"+outparam.getField33()+"^|$"+outparam.getField34()+"^|$"+outparam.getField35()+"^|$"+outparam.getField36()+"^|$"+outparam.getField37()+"^|$"+outparam.getField38()+"^|$"+outparam.getField39()+"^|$"+outparam.getField40()+"^|$"+outparam.getField41()+"^|$"+outparam.getField42()+"^|$"+outparam.getField43()+"^|$"+outparam.getField44()+"^|$"+outparam.getField45()+ "^|$"+outparam.getField46()+"^|$"+outparam.getField47()+"^|$"+outparam.getField48()+"^|$"+outparam.getField49()+"^|$"+outparam.getField50()+"^|$"+outparam.getField51());
			
			/*System.out.println("starts");
			System.out.println(b);
			System.out.println("ends");*/
			String field204Value = b.toString();
			  System.out.println("here starts login");
			  System.out.println(outparam.getField1());
			  System.out.println(outparam.getField2());
			  System.out.println(outparam.getField101());
			  System.out.println(outparam.getField102());
			  System.out.println(outparam.getField103());
			  System.out.println(outparam.getField104());
			  System.out.println(outparam.getField201());
			  System.out.println(outparam.getField204());
			  System.out.println(outparam.getField203());
			  System.out.println(outparam.getField202());
			  System.out.println("here ends");
			System.out.println("outparas1- "+ outparam.getField1());
			System.out.println("outparas2- "+ outparam.getField2());
			System.out.println("outparas3- "+ outparam.getField3());
			//Constants.loginTokenOmni =outparam.getField1() ;
			Constants.Field204=field204Value;
			Constants.Field1=outparam.getField1();
			Constants.Field203=outparam.getField203();
			
			return outparam;
			
		} catch (Exception e) {	
			System.out.println("Fata outparams m");
			e.printStackTrace();
		}
		return outparam;
		
	}
	
	
	public TMsgOutParam login()
	{
		
    	  TMsgOutParam outParam2 = null;
		
		
		
			  TMsgInParam inParam= new TMsgInParam();
			
			  inParam.setField1(Constants.OMNIUSER);
			  inParam.setField2(Constants.OMNIPASS);
			  //inParam.setField1(envr.getProperty("OMNIUSER"));
			  //inParam.setField2(envr.getProperty("OMNIPASS"));
			  inParam.setField3("Y");
			  inParam.setField4("N");
			  inParam.setField201("99");
			  
			  TOmniServiceSoapProxy omniServiceSoapProxy= new TOmniServiceSoapProxy();
			  try 
			  {
				  String sessionId= RandomStringUtils.random(32, 0, 20, true, true, "bj81G5RDED3DC6142kasok".toCharArray());;  //createsession();
				  System.out.println("sessionId = " + sessionId);
				  System.out.println("Invl=ke hga ab");

			outParam2 = omniServiceSoapProxy.lastCall(sessionId, "1", 82, inParam);
				 if(!outParam2.getField201().equals("0")){
							 
					return outParam2;
				}
			
				return outParam2;
			}catch (RemoteException e){
				System.out.println("Fata in params m ");
               e.printStackTrace();
			}
				return outParam2;
               
	}
	
	
	
}
