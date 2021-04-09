package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.UserAccessRightsEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.MenuAndAccessRightsHolderBean;

public interface UserAccessRightsService {
	public ResponseEntity<?> getDataUserByMUserCode(String musrcode,int mgrpcd);
	
	//public List<UserAccessRightsEntity> getDataUserByMUserCodeFroChartsMaster(String musrcode,int mgrpcd) ;
	public List<MenuAndAccessRightsHolderBean> getChartsIdOnMenuAndAccessJoin(String musrcode,int mgrpcd);
}
