package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl;

import org.springframework.beans.factory.annotation.Autowired;

import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.TOmniServiceSoap;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.OmniLoginService;

public class TOmniServiceSoapProxy implements TOmniServiceSoap {
  private String _endpoint = null;
  private TOmniServiceSoap tOmniServiceSoap = null;
  
  @Autowired
	OmniLoginService omniLoginService;
  
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
  
  public TMsgOutParam invoke(java.lang.String aToken, java.lang.String aSerName, int aMethod, TMsgInParam msgInParam) throws java.rmi.RemoteException{
    if (tOmniServiceSoap == null)
      _initTOmniServiceSoapProxy();
    
    
    
    System.out.println("Here Starts tomni");
    System.out.println(tOmniServiceSoap);
    System.out.println("Here Ends tomni");
    
    TMsgOutParam tmsgoutParams = tOmniServiceSoap.invoke(aToken, aSerName, aMethod, msgInParam);
    if(tmsgoutParams!=null && tmsgoutParams.getField203()!=null&& tmsgoutParams.getField203().startsWith("Session Token Not matching") || tmsgoutParams.getField203().startsWith("User Not Found From Web Session")) {
    	com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants.Field204  ="";
    	//OmniLoginService login = new OmniLoginService();
    	omniLoginService.loginOmni();
		tmsgoutParams = tOmniServiceSoap.invoke(aToken, aSerName, aMethod, msgInParam);
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