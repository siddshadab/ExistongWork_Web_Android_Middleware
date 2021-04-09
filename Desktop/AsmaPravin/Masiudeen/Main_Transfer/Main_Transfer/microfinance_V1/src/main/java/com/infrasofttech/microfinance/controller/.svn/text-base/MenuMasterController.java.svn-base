package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.services.MenuMasterService;


@RestController
@RequestMapping("/menuMaster")
public class MenuMasterController {
	
	@Autowired
	MenuMasterService menuMasterServiceImpl;
	
	
	@GetMapping(value = "/getAllMenusFromMaster", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return menuMasterServiceImpl.getAllMenusFromMasterData();
	}


	
	
}