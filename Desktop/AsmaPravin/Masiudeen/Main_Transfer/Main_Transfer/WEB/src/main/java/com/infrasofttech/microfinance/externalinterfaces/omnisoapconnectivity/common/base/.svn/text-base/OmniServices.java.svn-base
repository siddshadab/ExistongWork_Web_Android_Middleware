package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.base;

import java.io.Serializable;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapRequesteBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;

public interface OmniServices extends Serializable{

	public OmniSoapResultBean omniSoapServices(BaseEntity bean);
	public TMsgInParam prepareRequestToOmni(BaseEntity bean);
	public OmniSoapResultBean prepareResponseRecievedFromOmni(TMsgOutParam bean);
	
}
