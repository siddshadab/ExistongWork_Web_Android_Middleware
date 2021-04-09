package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.SystemParameterEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.SystemParameterHolder;
import com.infrasofttech.microfinance.services.SystemParameterServices;
import com.infrasofttech.microfinance.servicesimpl.SystemParameterServicesImpl;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/systemParam")
public class SystemParameterController {
	
	
	
	@Autowired 
	SystemParameterServicesImpl systemParameterServicesImpl;
	
	@Autowired
	SystemParameterServices systemParameterServices;



	
/*	@GetMapping(value = "/get/{countryName}", produces = "application/json")
	public ResponseEntity<?> getCountries(@PathVariable String countryName){	
		return countries.getCountries(countryName);
	}*/
	
	@GetMapping(value = "/getAllSystemParameter", produces = "application/json")
	public ResponseEntity<?>  getAllSystemParameterData() {
		return systemParameterServicesImpl.getAllSystemParameterData();
	}
	
	
	@PostMapping(value="/add" , produces= "application/json")
	ResponseEntity<?> addList(@RequestBody SystemParameterEntity systemParameterEntity){
		System.out.println("systemParamaterEntityxxxxxxxxxxxxxxxxxxxxx"+systemParameterEntity);
		if(null != systemParameterEntity)
			return systemParameterServices.addList(systemParameterEntity);
		return null;
	}
	
	@PostMapping(value="/addSys" , produces= "application/json")
	ResponseEntity<?> addSysParameter(@RequestBody SystemParameterHolder systemParameterHolder){
		System.out.println("systemParamaterHolderxxxxxxxxxxxxxxxxxxxxx"+systemParameterHolder);
		if(null != systemParameterHolder)
			return systemParameterServices.addSysParameter(systemParameterHolder);
		return null;
	}
	
	@PostMapping(value="/editSys" , produces= "application/json")
	ResponseEntity<?> editSysParameter(@RequestBody SystemParameterHolder systemParameterHolder){
		System.out.println("systemParamaterHolderxxxxxxxxxxxxxxxxxxxxx"+systemParameterHolder);
		if(null != systemParameterHolder)
			return systemParameterServices.editSysParameter(systemParameterHolder);
		return null;
	}
	
	@PostMapping(value="/deleteSys" , produces= "application/json")
	ResponseEntity<?> deleteSysParameter(@RequestBody SystemParameterHolder systemParameterHolder){
		System.out.println("systemParamaterHolderxxxxxxxxxxxxxxxxxxxxx"+systemParameterHolder);
		if(null != systemParameterHolder)
			return systemParameterServices.deleteSysParameter(systemParameterHolder.getCode());
		return null;
	}
	
	@PostMapping(value="/findByMcodeMlbrcd" , produces= "application/json")
	public ResponseEntity<?>  findByMcodeMlbrcd(@RequestBody SystemParameterHolder systemParameterHolder){
		if(systemParameterHolder != null) {
			return systemParameterServices.findByMcodeMlbrcd(systemParameterHolder);
			
		}
		return null;
	}
}
