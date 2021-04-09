package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.MenuMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserAccessRightsEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserAccressRightsCompositeEntity;
import com.infrasofttech.microfinance.services.MenuMasterService;


@RestController
@RequestMapping("/menuMaster")
public class MenuMasterController {
	
	@Autowired
	MenuMasterService menuMasterServiceImpl;
	
	
	@GetMapping(value = "/getAllMenusFromMaster", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return menuMasterServiceImpl.getAllMenusFromMasterData();
	}

	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody MenuMasterEntity menuMasterEntity){
		System.out.println("menuMasterEntityxxxxxxxxxxxxxxxxxxxxxxx"+menuMasterEntity);
		if(null != menuMasterEntity)
			return menuMasterServiceImpl.addList(menuMasterEntity);
		return null;
	}

//	@PostMapping(value = "/menu", produces = "application/json")
//	public String  menuByGrpCd(@RequestBody UserAccessRightsEntity userAccessRightsEntity){
//		System.out.println("menuMasterEntityxxxxxxxxxxxxxxxxxxxxxxx"+userAccessRightsEntity.getUserAccressRightsCompositeEntity().getMgrpcd());
//		if(null != userAccessRightsEntity)
//			return menuMasterServiceImpl.menuByGrpCd(userAccessRightsEntity);
//			
//		return null;
//	}

	
}