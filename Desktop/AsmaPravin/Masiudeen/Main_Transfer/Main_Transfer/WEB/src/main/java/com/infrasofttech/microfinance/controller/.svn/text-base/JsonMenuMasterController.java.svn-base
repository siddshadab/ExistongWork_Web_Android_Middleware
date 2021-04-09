package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.holder.JsonMenuMasterHolder;
import com.infrasofttech.microfinance.services.JsonMasterService;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/jsonMenu")
public class JsonMenuMasterController {

	
	@Autowired
	JsonMasterService  jsonMenuService;
	
	@PostMapping(value="/menuByGrpCd", produces="application/json")
	public ResponseEntity<?> menuByGrpCd(@RequestBody JsonMenuMasterHolder jsonMenu){
		return jsonMenuService.getMenuList(jsonMenu);
	}
}
