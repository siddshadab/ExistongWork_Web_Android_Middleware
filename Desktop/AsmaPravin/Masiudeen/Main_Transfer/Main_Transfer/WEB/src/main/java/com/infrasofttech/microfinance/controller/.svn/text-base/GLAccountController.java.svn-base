package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.infrasofttech.microfinance.entityBeans.master.GLAccountEntity;
import com.infrasofttech.microfinance.services.GLAccountService;


@RestController
@RequestMapping("/glAccount")
public class GLAccountController {
	
	@Autowired 
	GLAccountService glAccountService;
	
	@PostMapping(value = "/getDataByMlbrcode", produces = "application/json")
	public ResponseEntity<?>  getDataByMlbrcode(@RequestBody GLAccountEntity glaccount){
		if(null != glaccount) {
			return glAccountService.getDataByMlbrcode(glaccount.getMlbrcode());
		}
		return null;
	}
	
}
