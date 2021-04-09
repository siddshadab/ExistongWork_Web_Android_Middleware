package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.StatesEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.AddressMasterHolder;
import com.infrasofttech.microfinance.services.StatesServices;


@CrossOrigin(origins = "*", allowedHeaders = "*")
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
	
	@PostMapping(value="/getListofState", produces="application/json")
	public ResponseEntity<?> getAllStates(@RequestBody StatesEntity statesEntity){
		if(statesEntity !=null) {
			return states.getAllStates(statesEntity);
		}
		return null;
	}
	
	
	
	@PostMapping(value ="/addStates",produces="application/json")
	public ResponseEntity<?> addStates(@RequestBody StatesEntity statesEntity){
		if(null!= statesEntity) {
			return states.addStates(statesEntity);
		}
		return null;
	}
	
	@PostMapping(value ="/editStates",produces="application/json")
	public ResponseEntity<?> editStates(@RequestBody StatesEntity statesEntity){
		if(null!= statesEntity) {
			return states.editStates(statesEntity);
		}
		return null;
	}
	
	@PostMapping(value ="/deleteStates",produces="application/json")
	public ResponseEntity<?> deleteStates(@RequestBody AddressMasterHolder addressHolder){
		if(null!= addressHolder) {
			return states.deleteStates(addressHolder);
		}
		return null;
	}
	
//	@PostMapping(value="/bulkDelete",produces="application/json")
//	public ResponseEntity<?> bulkDelete(@RequestBody AddressMasterHolder addressHolder){
//		if(addressHolder !=null) {
//			return states.bulkDelete(addressHolder);
//		}
//		return null;
//	}
	
}
