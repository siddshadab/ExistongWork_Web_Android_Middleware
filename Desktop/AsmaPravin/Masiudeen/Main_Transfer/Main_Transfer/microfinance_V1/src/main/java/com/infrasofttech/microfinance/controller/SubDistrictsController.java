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

import com.infrasofttech.microfinance.entityBeans.DistrictsEntity;
import com.infrasofttech.microfinance.entityBeans.StatesEntity;
import com.infrasofttech.microfinance.entityBeans.SubDistrictsEntity;
import com.infrasofttech.microfinance.repository.DistrictsRepository;
import com.infrasofttech.microfinance.services.DistrictsServices;
import com.infrasofttech.microfinance.services.StatesServices;
import com.infrasofttech.microfinance.services.SubDistrictsServices;


@RestController
@RequestMapping("/subdistricts")
public class SubDistrictsController {

	
	@Autowired 
	SubDistrictsServices subdist;

	/*
	 * @PostMapping("/addSubDistricts/{districtsID}/") public ResponseEntity<?>
	 * createComment(@PathVariable (value = "districtsID") Long districtId,
	 * 
	 * @Valid @RequestBody SubDistrictsEntity entity) { return
	 * subdist.addSubDistricts(entity,districtId);
	 * 
	 * 
	 * }
	 */
	
	@GetMapping(value = "/getlistOfData", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return subdist.getSubDistricts();
	}

}
