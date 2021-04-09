package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.CheckListCGT1Entity;
import com.infrasofttech.microfinance.servicesimpl.CheckListCGT1ServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.TransactionModeServiceImpl;

@RestController
@RequestMapping("/CheckListCGT1Data")
public class CheckListCGT1Controller {
	
	@Autowired
	CheckListCGT1ServiceImpl CheckListService;
	
	
	@GetMapping(value = "/getlistOfCheckList", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return CheckListService.getAllCheckListCGT1Data();
	}
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<CheckListCGT1Entity> checkList){
		if(null != checkList)
			return CheckListService.addList(checkList);
		return null;
	}


}
