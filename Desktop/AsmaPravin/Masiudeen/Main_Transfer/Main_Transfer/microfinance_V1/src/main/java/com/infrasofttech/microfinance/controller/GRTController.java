package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.GRTEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.Cgt2HolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.GrtHolderBean;
import com.infrasofttech.microfinance.servicesimpl.GRTServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.TransactionModeServiceImpl;

@RestController
@RequestMapping("/GRTData")
public class GRTController {
	
	@Autowired
	GRTServiceImpl GRTService;
	
	
	@GetMapping(value = "/getlistOfCGT2", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return GRTService.getAllGRTData();
	}
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<GRTEntity> grt){
		if(null != grt)
			return GRTService.addList(grt);
		return null;
	}
	
	@PostMapping(value = "/addGrtByHolder", produces = "application/json")
	public ResponseEntity<?>  addGrtListByHolder(@RequestBody List<GrtHolderBean> grtlist){
				return GRTService.addGrtListByHolder(grtlist);
		
	}


}
