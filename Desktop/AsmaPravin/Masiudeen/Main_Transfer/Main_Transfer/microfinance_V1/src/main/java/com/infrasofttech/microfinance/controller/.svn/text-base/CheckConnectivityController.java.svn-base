package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.holder.CIFHolderBean;

@RestController
@RequestMapping("/serverCheck")
public class CheckConnectivityController {

	
	@GetMapping(value = "/getServerConnectivity",produces = "application/json")
	public ResponseEntity<?> CheckConnectivityToServer(){
		return new  ResponseEntity<>(HttpStatus.OK);
	}
	
}
