package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.DataSourceMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.MenuMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserMasterEntity;
import com.infrasofttech.microfinance.services.DataSourceMasterService;



@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/DataSourceResult")
public class DataSourceMasterController {

	@Autowired
	DataSourceMasterService dataSourceService;
	
	
	//@PostMapping(value = "/add", produces = "application/json")
	@PostMapping(value = "/getQueryResult", produces = "application/json")
	public ResponseEntity<?>  dataSourceCall(@RequestBody DataSourceMasterEntity dataSourceMasterEntity){
		System.out.println("dataSourceMasterEntityxxxxxxxxxxxxxxxxxxxxxxx"+dataSourceMasterEntity);
		if(null != dataSourceMasterEntity)
			return dataSourceService.dataSourceBySysId(dataSourceMasterEntity);
		return null;
	}
	
	
	@RequestMapping(value = "/getlistofdata")
	@GetMapping(value = "/getlistofdata", produces = "application/json")
	public ResponseEntity<?> getAllList(@RequestBody DataSourceMasterEntity receavedData){
		return dataSourceService.getAllData(receavedData);
	} 
	
}
