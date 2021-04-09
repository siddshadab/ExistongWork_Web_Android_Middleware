package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.TOmniServiceSoap;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.OmniLoginService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;

public class TOmniServiceSoapProxy implements TOmniServiceSoap {
  private String _endpoint = null;
  private TOmniServiceSoap tOmniServiceSoap = null;
  
//  @Autowired
//	OmniLoginService omniLoginService;
  
  public TOmniServiceSoapProxy() {
    _initTOmniServiceSoapProxy();
  }
  
  public TOmniServiceSoapProxy(String endpoint) {
    _endpoint = endpoint;
    _initTOmniServiceSoapProxy();
  }
  
  private void _initTOmniServiceSoapProxy() {
    try {
      tOmniServiceSoap = (new TOmniServiceLocator()).getTOmniServiceSoap();
      if (tOmniServiceSoap != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)tOmniServiceSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)tOmniServiceSoap)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (tOmniServiceSoap != null)
      ((javax.xml.rpc.Stub)tOmniServiceSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public TOmniServiceSoap getTOmniServiceSoap() {
    if (tOmniServiceSoap == null)
      _initTOmniServiceSoapProxy();
    return tOmniServiceSoap;
  }
  
  public java.lang.String helloWorld() throws java.rmi.RemoteException{
    if (tOmniServiceSoap == null)
      _initTOmniServiceSoapProxy();
    return tOmniServiceSoap.helloWorld();
  }
  
  public TMsgOutParam lastCall(java.lang.String aToken, java.lang.String aSerName, int aMethod, TMsgInParam msgInParam) throws java.rmi.RemoteException{
	    if (tOmniServiceSoap == null)
	      _initTOmniServiceSoapProxy();
	    
	    
	    
	    
			/*
			 * // System.out.println("Here Starts tomni"); //
			 * System.out.println(tOmniServiceSoap); //
			 * System.out.println("Here Ends tomni");
			 */  
	    TMsgOutParam tmsgoutParams= null;
	    System.out.println("Now invoking  from correct one");
	    
	    try {
	    	tmsgoutParams = tOmniServiceSoap.invoke(aToken, aSerName, aMethod, msgInParam);
	    }catch(Exception e) {
	    	
	    	
	    }

	    return  tmsgoutParams;
	  }
  
  
  
  public TMsgOutParam invoke(java.lang.String aToken, java.lang.String aSerName, int aMethod, TMsgInParam msgInParam) throws java.rmi.RemoteException{
    if (tOmniServiceSoap == null)
      _initTOmniServiceSoapProxy();
    
    
    
    
		/*
		 * // System.out.println("Here Starts tomni"); //
		 * System.out.println(tOmniServiceSoap); //
		 * System.out.println("Here Ends tomni");
		 */  
    TMsgOutParam tmsgoutParams= null;
    
    try {
    	tmsgoutParams = tOmniServiceSoap.invoke(aToken, aSerName, aMethod, msgInParam);
    }catch(Exception e) {
    	
    	
    }
    //System.out.println("anadar value hai "+ tmsgoutParams);
    if((tmsgoutParams==null)||(tmsgoutParams!=null && tmsgoutParams.getField203()!=null&& 
    		(tmsgoutParams.getField203().toLowerCase().startsWith(com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants.SESSIONERROR) ||
    				tmsgoutParams.getField203().toLowerCase().startsWith(com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants.SESSIONERRORTHREE.toLowerCase()	)
    				||
    				tmsgoutParams.getField203().toLowerCase().startsWith(Constants.OPERATIONDATEMISMATCHERROR)
    				)
    				
    				
    				)) {
    	com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants.Field204  ="";
    	//OmniLoginService login = new OmniLoginService();
    	System.out.println("Trying to Login again");
    	try {
    		OmniLoginService omniLoginService = new OmniLoginService();
    	omniLoginService.loginOmni();
    	}catch(Exception e ) {
    		e.printStackTrace();
    	}
    	//System.out.println("Sending again inaparams "+ msgInParam);
		tmsgoutParams = lastCall(Constants.Field1, aSerName, aMethod, msgInParam);
    }
    return  tmsgoutParams;
  }
  
  
  
  public TMsgOutParam invoke(java.lang.String aToken, java.lang.String aSerName, int aMethod, TMsgInParam msgInParam,boolean  repeatedLogin) throws java.rmi.RemoteException{
	    if (tOmniServiceSoap == null)
	      _initTOmniServiceSoapProxy();
	    
	    
	    
			/*
			 * // System.out.println("Here Starts tomni"); //
			 * System.out.println(tOmniServiceSoap); //
			 * System.out.println("Here Ends tomni");
			 */  
	    TMsgOutParam tmsgoutParams = null;
	    try {
	    	tmsgoutParams = tOmniServiceSoap.invoke(aToken, aSerName, aMethod, msgInParam);	
	    }catch(Exception e) {
	    	//System.out.println("Exception se Response hai " + tmsgoutParams);
	    	
	    }
	    
			 //System.out.println("Yhan se Response hai " + tmsgoutParams);
	    //System.out.println("anadar value hai "+ tmsgoutParams);
	    if((tmsgoutParams==null)||(tmsgoutParams!=null && tmsgoutParams.getField203()!=null&& 
	    		(tmsgoutParams.getField203().toLowerCase().startsWith(com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants.SESSIONERROR) ||
	    				tmsgoutParams.getField203().toLowerCase().startsWith(com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants.SESSIONERRORTHREE.toLowerCase()
	    						)||
	    				tmsgoutParams.getField203().toLowerCase().startsWith(Constants.OPERATIONDATEMISMATCHERROR)
	    				)
	    				
	    				
	    				)) {
	    	com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants.Field204  ="";
	    	//OmniLoginService login = new OmniLoginService();
	    	System.out.println("Trying to Login again");
	    	try {
	    		OmniLoginService omniLoginService = new OmniLoginService();
	    	omniLoginService.loginOmni();
	    	}catch(Exception e ) {
	    		e.printStackTrace();
	    	}
	    	//System.out.println("Sending again inaparams "+ msgInParam);
			tmsgoutParams = tOmniServiceSoap.invoke(Constants.Field1, aSerName, aMethod, msgInParam);
	    }
	    return  tmsgoutParams;
	  }
  
  
  
  
  public java.lang.String ajaxInvoke(java.lang.String aToken, java.lang.String aSerName, java.lang.String aSessionVars, int aMethod, java.lang.String inFieldData) throws java.rmi.RemoteException{
    if (tOmniServiceSoap == null)
      _initTOmniServiceSoapProxy();
    return tOmniServiceSoap.ajaxInvoke(aToken, aSerName, aSessionVars, aMethod, inFieldData);
  }
  
  public java.lang.String reportsInvoke(java.lang.String aToken, java.lang.String aSerName, java.lang.String aSessionVars, int aMethod, java.lang.String inFieldData) throws java.rmi.RemoteException{
    if (tOmniServiceSoap == null)
      _initTOmniServiceSoapProxy();
    return tOmniServiceSoap.reportsInvoke(aToken, aSerName, aSessionVars, aMethod, inFieldData);
  }
  
  public java.lang.String SMSInvoke(java.lang.String aToken, java.lang.String aSerName, java.lang.String aSessionVars, int aMethod, java.lang.String inFieldData) throws java.rmi.RemoteException{
    if (tOmniServiceSoap == null)
      _initTOmniServiceSoapProxy();
    return tOmniServiceSoap.SMSInvoke(aToken, aSerName, aSessionVars, aMethod, inFieldData);
  }
  
  
}