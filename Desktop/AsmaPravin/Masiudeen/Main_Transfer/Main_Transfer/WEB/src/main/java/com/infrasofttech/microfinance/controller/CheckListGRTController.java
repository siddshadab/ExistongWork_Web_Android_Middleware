package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.CheckListGRTEntity;
import com.infrasofttech.microfinance.servicesimpl.CheckListGRTServiceImpl;

@RestController
@RequestMapping("/CheckListGRTData")
public class CheckListGRTController {
	
	@Autowired
	CheckListGRTServiceImpl CheckListService;
	
	
	@GetMapping(value = "/getlistOfCheckList", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return CheckListService.getAllCheckListGRTData();
	}
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<CheckListGRTEntity> checkList){
		if(null != checkList)
			return CheckListService.addList(checkList);
		return null;
	}


}
