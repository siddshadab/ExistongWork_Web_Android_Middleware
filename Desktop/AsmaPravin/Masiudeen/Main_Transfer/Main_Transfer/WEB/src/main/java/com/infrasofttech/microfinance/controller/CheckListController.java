package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.CheckListEntity;
import com.infrasofttech.microfinance.servicesimpl.CheckListServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.TransactionModeServiceImpl;

@RestController
@RequestMapping("/CheckListData")
public class CheckListController {
	
	@Autowired
	CheckListServiceImpl CheckListService;
	
	
	@GetMapping(value = "/getlistOfCheckList", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return CheckListService.getAllCheckListData();
	}
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<CheckListEntity> checkList){
		if(null != checkList)
			return CheckListService.addList(checkList);
		return null;
	}


}
