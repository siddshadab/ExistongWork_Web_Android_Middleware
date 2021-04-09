package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.CheckListCGT2Entity;
import com.infrasofttech.microfinance.servicesimpl.CheckListCGT2ServiceImpl;

@RestController
@RequestMapping("/CheckListCGT2Data")
public class CheckListCGT2Controller {
	
	@Autowired
	CheckListCGT2ServiceImpl CheckListService;
	
	
	@GetMapping(value = "/getlistOfCheckList", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return CheckListService.getAllCheckListCGT2Data();
	}
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<CheckListCGT2Entity> checkList){
		if(null != checkList)
			return CheckListService.addList(checkList);
		return null;
	}


}
