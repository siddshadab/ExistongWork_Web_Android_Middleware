package com.infrasofttech.microfinance.services;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.holder.JsonMenuMasterHolder;

public interface JsonMasterService {

	//public void getAllJsonMenu();
	
	public ResponseEntity<?> getMenuList(JsonMenuMasterHolder jsonMenu);
}
