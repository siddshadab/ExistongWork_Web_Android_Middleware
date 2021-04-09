package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.CGT2Entity;
import com.infrasofttech.microfinance.entityBeans.master.holder.Cgt2HolderBean;
import com.infrasofttech.microfinance.servicesimpl.CGT2ServiceImpl;

@RestController
@RequestMapping("/CGT2Data")
public class CGT2Controller {
	
	@Autowired
	CGT2ServiceImpl CGT2Service;
	
	
	@GetMapping(value = "/getlistOfCGT2", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return CGT2Service.getAllCGT2Data();
	}
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<CGT2Entity> cgt2){
		if(null != cgt2)
			return CGT2Service.addList(cgt2);
		return null;
	}
	
	@PostMapping(value = "/addCgt2ByHolder", produces = "application/json")
	public ResponseEntity<?>  addCgt2ListByHolder(@RequestBody List<Cgt2HolderBean> cgt2list){
				return CGT2Service.addCgt2ListByHolder(cgt2list);
		
	}


}
