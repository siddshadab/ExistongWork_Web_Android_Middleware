package com.infrasofttech.microfinance.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.DistrictsEntity;
import com.infrasofttech.microfinance.entityBeans.StatesEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.AddressMasterHolder;
import com.infrasofttech.microfinance.repository.DistrictsRepository;
import com.infrasofttech.microfinance.services.DistrictsServices;
import com.infrasofttech.microfinance.services.StatesServices;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/districts")
public class DistrictsController {

	
	@Autowired 
	DistrictsServices dist;

	/*
	 * @PostMapping("/addDistricts/{statesId}/") public ResponseEntity<?>
	 * createComment(@PathVariable (value = "statesId") Long stateId,
	 * 
	 * @Valid @RequestBody DistrictsEntity entity) { return
	 * dist.addDistricts(entity,stateId);
	 * 
	 * 
	 * }
	 */
	
	@GetMapping(value = "/getlistOfData", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return dist.getDistricts();
	}
	
	@PostMapping(value="/getAllDistrict",produces="application/json")
	public ResponseEntity<?> getAllDistricts(@RequestBody DistrictsEntity districtsEntity){
		if(null!= districtsEntity) {
			return dist.getAllDistricts(districtsEntity);
		}
		return null;
	}

	@PostMapping(value="/addDistricts",produces="application/json")
	public ResponseEntity<?> addDistricts(@RequestBody DistrictsEntity districtsEntity){
		if(null!= districtsEntity) {
			return dist.addDistricts(districtsEntity);
		}
		return null;
	}
	
	@PostMapping(value="/editDistricts",produces="application/json")
	public ResponseEntity<?> editDistricts(@RequestBody DistrictsEntity districtsEntity){
		if(null!= districtsEntity) {
			return dist.editDistricts(districtsEntity);
		}
		return null;
	}
	
	@PostMapping(value="/deleteDistricts",produces="application/json")
	public ResponseEntity<?> deleteDistricts(@RequestBody AddressMasterHolder addressMasterHolder){
		if(null!= addressMasterHolder) {
			return dist.deleteDistricts(addressMasterHolder);
		}
		return null;
	}
	
//	@PostMapping(value="/bulkDelete",produces="application/json")
//	public ResponseEntity<?> deleteDistricts(@RequestBody AddressMasterHolder addressHolder){
//		if(null!= addressHolder) {
//			return dist.bulkDelete(addressHolder);
//		}
//		return null;
//	}

}
