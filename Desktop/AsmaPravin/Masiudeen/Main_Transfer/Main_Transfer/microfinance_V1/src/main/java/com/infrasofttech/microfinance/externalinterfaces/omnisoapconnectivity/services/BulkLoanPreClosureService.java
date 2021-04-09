package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services;

import java.util.List;

import com.infrasofttech.microfinance.entityBeans.master.holder.BulkLoanPreClosureHolderBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.base.OmniServices;

public interface BulkLoanPreClosureService extends OmniServices{

	TMsgInParam prepareRequestToOmni(List<BulkLoanPreClosureHolderBean> beanList2);	
	

}
