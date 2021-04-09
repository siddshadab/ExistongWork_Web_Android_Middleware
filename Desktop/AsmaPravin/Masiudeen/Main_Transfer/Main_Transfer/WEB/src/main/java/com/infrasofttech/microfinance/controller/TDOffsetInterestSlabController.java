package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.CountriesEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.TDOffsetInterstSlabHolder;
import com.infrasofttech.microfinance.repository.LookupMasterRepository;
import com.infrasofttech.microfinance.services.TDOffsetInterestSlabServices;
import com.infrasofttech.microfinance.servicesimpl.CountriesServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.InterestSlabServicesImpl;
import com.infrasofttech.microfinance.servicesimpl.LookupMasterServicesImpl;
import com.infrasofttech.microfinance.servicesimpl.TDOffsetInterestSlabServicesImpl;


@RestController
@RequestMapping("/TDOffsetInterestSlabController")
public class TDOffsetInterestSlabController {
	
	
	
	@Autowired 
	TDOffsetInterestSlabServicesImpl tdOffsetInterestSlabServicesImpl;

	@Autowired
	TDOffsetInterestSlabServices tdOffsetInterestService;
	
	@GetMapping(value = "/getAllTDOffsetInterestSlab/", produces = "application/json")
	public ResponseEntity<?>  getAllTDOffsetInterestSlabData() {
		return tdOffsetInterestSlabServicesImpl.getAllTDOffsetInterestSlabData();
	}
	
	@PostMapping(value ="/add", produces="application/json")
	public ResponseEntity<?> addTDOffsetInterest(@RequestBody TDOffsetInterstSlabHolder TDOffsetInterestHld){
		System.out.println("TDOffsetInterestHldxxxxxxx"+TDOffsetInterestHld);
		if(TDOffsetInterestHld!=null) {
			tdOffsetInterestService.addTDOffsetInterest(TDOffsetInterestHld);
			return null;
		}
		return null;
	}
	
	@PostMapping(value ="/edit", produces="application/json")
	public ResponseEntity<?> updateTDOffsetInterest(@RequestBody TDOffsetInterstSlabHolder TDOffsetInterestHld){
		System.out.println("TDOffsetInterestHldxxxxxxx"+TDOffsetInterestHld);
		if(TDOffsetInterestHld!=null) {
			tdOffsetInterestService.updateTDOffsetInterest(TDOffsetInterestHld);
			return null;
		}
		return null;
	}
	
	@PostMapping(value ="/delete", produces="application/json")
	public ResponseEntity<?> deleteTDOffsetInterest(@RequestBody TDOffsetInterstSlabHolder TDOffsetInterestHld){
		System.out.println("TDOffsetInterestHldxxxxxxx"+TDOffsetInterestHld);
		if(TDOffsetInterestHld!=null) {
			tdOffsetInterestService.deleteTDOffsetInterest(TDOffsetInterestHld);
			return null;
		}
		return null;
	}

}
