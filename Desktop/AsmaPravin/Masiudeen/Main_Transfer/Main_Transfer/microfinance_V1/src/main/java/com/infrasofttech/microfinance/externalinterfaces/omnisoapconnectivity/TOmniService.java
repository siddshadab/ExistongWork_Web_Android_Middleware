package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity;



public interface TOmniService extends javax.xml.rpc.Service {
    public java.lang.String getTOmniServiceSoapAddress();

    public TOmniServiceSoap getTOmniServiceSoap() throws javax.xml.rpc.ServiceException;

    public TOmniServiceSoap getTOmniServiceSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
    public java.lang.String getTOmniServiceSoap12Address();

    public TOmniServiceSoap getTOmniServiceSoap12() throws javax.xml.rpc.ServiceException;

    public TOmniServiceSoap getTOmniServiceSoap12(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
}
