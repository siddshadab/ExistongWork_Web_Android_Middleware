package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.JsonMenuEntity;
import com.infrasofttech.microfinance.entityBeans.master.MenuMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserAccessRightsEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserAccressRightsCompositeEntity;

public interface MenuMasterService {

	
	
	public ResponseEntity<?> getAllMenusFromMasterData();
	
	public ResponseEntity<?> addList(MenuMasterEntity menuMasterEntity);
	
	//public String menuByGrpCd(UserAccessRightsEntity userAccessRightsEntity);
	
		
	
	
}
