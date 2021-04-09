package com.infrasofttech.microfinance.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.StatesEntity;
import com.infrasofttech.microfinance.services.StatesServices;



@RestController
@RequestMapping("/states")
public class StatesController {

	
	@Autowired 
	StatesServices states;

	/*
	 * @PostMapping("/addStates/{countryId}/") public ResponseEntity<?>
	 * createComment(@PathVariable (value = "countryId") Long countryId,
	 * 
	 * @Valid @RequestBody StatesEntity entity) {
	 * 
	 * return states.addStates(entity,countryId);
	 * 
	 * 
	 * }
	 */
	
	@GetMapping(value = "/getlistOfData", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return states.getStates();
	}
	
	
}
