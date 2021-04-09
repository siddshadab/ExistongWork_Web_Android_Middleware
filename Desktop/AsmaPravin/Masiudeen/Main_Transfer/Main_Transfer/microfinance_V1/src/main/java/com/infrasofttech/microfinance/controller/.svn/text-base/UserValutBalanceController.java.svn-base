package com.infrasofttech.microfinance.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.UserVaultBalanceEntity;
import com.infrasofttech.microfinance.services.UserVaultBalanceServices;


@RestController
@RequestMapping("/UserValutBalance")
public class UserValutBalanceController {
	
	@Autowired
	UserVaultBalanceServices userVaultBalanceServices;
	
	

	
	@PostMapping(value = "/getUserValutBalanceByUSerCode", produces = "application/json")
	public ResponseEntity<?>  getDataByAgentUserName(@RequestBody UserVaultBalanceEntity userVaultBalanceEntity){
		if(null != userVaultBalanceEntity) {
			return userVaultBalanceServices.findByMusrcode(userVaultBalanceEntity.getUserVaultBalanceCompositetEntity().getmusercode());
		}
		return null;
	}

}
