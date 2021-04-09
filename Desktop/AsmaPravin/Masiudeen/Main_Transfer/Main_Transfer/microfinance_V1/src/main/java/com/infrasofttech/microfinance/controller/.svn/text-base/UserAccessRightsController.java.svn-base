package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.UserAccessRightsEntity;
import com.infrasofttech.microfinance.services.UserAccessRightsService;


@RestController
@RequestMapping("/userAccessRights")
public class UserAccessRightsController {
	
	@Autowired
	UserAccessRightsService userAccessRightsService;
	
	

	
	@PostMapping(value = "/getUserAccessRightsByUSerCode", produces = "application/json")
	public ResponseEntity<?>  getDataByAgentUserName(@RequestBody UserAccessRightsEntity userAccessRightsEntity){
		if(null != userAccessRightsEntity) {
			return userAccessRightsService.getDataUserByMUserCode(userAccessRightsEntity.getUserAccressRightsCompositeEntity().getusrcode(),userAccessRightsEntity.getUserAccressRightsCompositeEntity().getMgrpcd());
		}
		return null;
	}

}
