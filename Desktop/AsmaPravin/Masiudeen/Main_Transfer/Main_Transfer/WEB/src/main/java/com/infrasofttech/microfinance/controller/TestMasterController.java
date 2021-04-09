package com.infrasofttech.microfinance.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.TestMasterEntity;
import com.infrasofttech.microfinance.repository.TestMasterRepo;
import com.infrasofttech.microfinance.services.TestMasterService;
import com.infrasofttech.microfinance.servicesimpl.TestMasterServiceImpl;

@RestController
@RequestMapping("/TestMasterController")
public class TestMasterController {

	@Autowired
	TestMasterService testMasterService;
	
	@Autowired
	TestMasterServiceImpl impl;
	
	@Autowired
	TestMasterRepo repo;


	
//	@PostMapping(value ="/get", produces="application/json")	
//	public String getTestMaster(@RequestBody TestMasterEntity testMasterEntity) {
//		if(testMasterEntity !=null)
//			return testMasterService.getTestMaster(testMasterEntity);		
//		
//		return null;
//	}
	
	@GetMapping(value ="/get", produces="application/json")
	public List<TestMasterEntity> getAllList() {
		return repo.findAll();
	}
	
	@GetMapping(value ="/getAll", produces="application/json")
	public String getAllTestMaster() {	
			return testMasterService.getTestMaster();
	}
	
	@PostMapping(value ="/json", produces="application/json")
	public String getTestMaster(@RequestBody TestMasterEntity testMasterEntity) {
		if(testMasterEntity !=null) {
			
			System.out.println(testMasterEntity.getCategoryid());
			return testMasterService.getAllTitle(testMasterEntity);
		}
														
		return null;		
	}
	
	
	@GetMapping(value ="/menuAll", produces="application/json")
	public String getMenu() {
		
			return testMasterService.menuByGrpCd();
		}

	
}
