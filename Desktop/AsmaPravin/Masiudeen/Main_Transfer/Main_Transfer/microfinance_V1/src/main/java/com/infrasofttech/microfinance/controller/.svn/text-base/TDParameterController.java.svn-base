package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.servicesimpl.TDOffsetInterestSlabServicesImpl;
import com.infrasofttech.microfinance.servicesimpl.TDParameterServiceImpl;


@RestController
@RequestMapping("/TDParameterController")
public class TDParameterController {

	
	
	@Autowired 
	TDParameterServiceImpl tdParameterServiceImpl;


	@GetMapping(value = "/getAllTDParameterData/", produces = "application/json")
	public ResponseEntity<?>  getAllParameterData() {
		System.out.println("Getting the response here");
		return tdParameterServiceImpl.getAllTDParameterData();
	}
	
	
	
	
}
