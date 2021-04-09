package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.CGT1Entity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.Cgt1HolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.CustomerHolderBean;
import com.infrasofttech.microfinance.servicesimpl.CGT1ServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.ProductServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.TransactionModeServiceImpl;

@RestController
@RequestMapping("/CGT1Data")
public class CGT1Controller {
	
	@Autowired
	CGT1ServiceImpl CGT1Service;
	
	
	@GetMapping(value = "/getlistOfCGT1", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return CGT1Service.getAllCGT1Data();
	}
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<CGT1Entity> cgt1){
		if(null != cgt1)
			return CGT1Service.addList(cgt1);
		return null;
	}
	
	@PostMapping(value = "/addCgt1ByHolder", produces = "application/json")
	public ResponseEntity<?>  addCgt1ListByHolder(@RequestBody List<Cgt1HolderBean> cgt1list){
				return CGT1Service.addCgt1ListByHolder(cgt1list);
		
	}


}
