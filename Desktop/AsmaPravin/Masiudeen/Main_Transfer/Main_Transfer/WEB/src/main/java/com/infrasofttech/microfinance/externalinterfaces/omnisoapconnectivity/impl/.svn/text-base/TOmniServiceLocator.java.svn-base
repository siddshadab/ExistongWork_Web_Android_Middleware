package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl;

import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.TOmniService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.TOmniServiceSoap;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;

public class TOmniServiceLocator extends org.apache.axis.client.Service implements TOmniService {

    public TOmniServiceLocator() {
    }


    public TOmniServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public TOmniServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for TOmniServiceSoap
    private java.lang.String TOmniServiceSoap_address = Constants.ENDPOINT;

    public java.lang.String getTOmniServiceSoapAddress() {
        return TOmniServiceSoap_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String TOmniServiceSoapWSDDServiceName = "TOmniServiceSoap";

    public java.lang.String getTOmniServiceSoapWSDDServiceName() {
        return TOmniServiceSoapWSDDServiceName;
    }

    public void setTOmniServiceSoapWSDDServiceName(java.lang.String name) {
        TOmniServiceSoapWSDDServiceName = name;
    }

    public TOmniServiceSoap getTOmniServiceSoap() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(TOmniServiceSoap_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getTOmniServiceSoap(endpoint);
    }

    public TOmniServiceSoap getTOmniServiceSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            TOmniServiceSoapStub _stub = new TOmniServiceSoapStub(portAddress, this);
            _stub.setPortName(getTOmniServiceSoapWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setTOmniServiceSoapEndpointAddress(java.lang.String address) {
        TOmniServiceSoap_address = address;
    }


    // Use to get a proxy class for TOmniServiceSoap12
    private java.lang.String TOmniServiceSoap12_address = Constants.ENDPOINT;

    public java.lang.String getTOmniServiceSoap12Address() {
        return TOmniServiceSoap12_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String TOmniServiceSoap12WSDDServiceName = "TOmniServiceSoap12";

    public java.lang.String getTOmniServiceSoap12WSDDServiceName() {
        return TOmniServiceSoap12WSDDServiceName;
    }

    public void setTOmniServiceSoap12WSDDServiceName(java.lang.String name) {
        TOmniServiceSoap12WSDDServiceName = name;
    }

    public TOmniServiceSoap getTOmniServiceSoap12() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(TOmniServiceSoap12_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getTOmniServiceSoap12(endpoint);
    }

    public TOmniServiceSoap getTOmniServiceSoap12(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            TOmniServiceSoap12Stub _stub = new TOmniServiceSoap12Stub(portAddress, this);
            _stub.setPortName(getTOmniServiceSoap12WSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setTOmniServiceSoap12EndpointAddress(java.lang.String address) {
        TOmniServiceSoap12_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     * This service has multiple ports for a given interface;
     * the proxy implementation returned may be indeterminate.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (TOmniServiceSoap.class.isAssignableFrom(serviceEndpointInterface)) {
                TOmniServiceSoapStub _stub = new TOmniServiceSoapStub(new java.net.URL(TOmniServiceSoap_address), this);
                _stub.setPortName(getTOmniServiceSoapWSDDServiceName());
                return _stub;
            }
            if (TOmniServiceSoap.class.isAssignableFrom(serviceEndpointInterface)) {
                TOmniServiceSoap12Stub _stub = new TOmniServiceSoap12Stub(new java.net.URL(TOmniServiceSoap12_address), this);
                _stub.setPortName(getTOmniServiceSoap12WSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("TOmniServiceSoap".equals(inputPortName)) {
            return getTOmniServiceSoap();
        }
        else if ("TOmniServiceSoap12".equals(inputPortName)) {
            return getTOmniServiceSoap12();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://omni.infrasofttech.com/", "TOmniService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://omni.infrasofttech.com/", "TOmniServiceSoap"));
            ports.add(new javax.xml.namespace.QName("http://omni.infrasofttech.com/", "TOmniServiceSoap12"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("TOmniServiceSoap".equals(portName)) {
            setTOmniServiceSoapEndpointAddress(address);
        }
        else 
if ("TOmniServiceSoap12".equals(portName)) {
            setTOmniServiceSoap12EndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
