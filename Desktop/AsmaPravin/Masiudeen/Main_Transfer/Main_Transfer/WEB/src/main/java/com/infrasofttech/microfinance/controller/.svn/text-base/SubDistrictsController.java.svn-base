package com.infrasofttech.microfinance.controller;

import java.util.List;

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
import com.infrasofttech.microfinance.entityBeans.SubDistrictsEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.AddressMasterHolder;
import com.infrasofttech.microfinance.repository.DistrictsRepository;
import com.infrasofttech.microfinance.services.DistrictsServices;
import com.infrasofttech.microfinance.services.StatesServices;
import com.infrasofttech.microfinance.services.SubDistrictsServices;

@CrossOrigin(origins = "*", allowedHeaders = "*")
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
	
	@PostMapping(value="/getDistricts", produces = "application/json")
	public ResponseEntity<?> getAllSubDistricts(@RequestBody SubDistrictsEntity subDistsEntity){
		if(subDistsEntity !=null) {
			return subdist.getAllSubDistricts(subDistsEntity);
		}
		return null;
	}
	
	
	@PostMapping(value="/addSubDist",produces="application/json")
	public ResponseEntity<?> addSubDist(@RequestBody SubDistrictsEntity subDistsEntity){
		if(null!= subDistsEntity) {
			return subdist.addSubDist(subDistsEntity);
		}
		return null;
	}
	
	@PostMapping(value="/editSubDist",produces="application/json")
	public ResponseEntity<?> editSubDist(@RequestBody SubDistrictsEntity subDistsEntity){
		if(null!= subDistsEntity) {
			return subdist.editSubDist(subDistsEntity);
		}
		return null;
	}
	
	@PostMapping(value="/deleteSubDist",produces="application/json")
	public ResponseEntity<?> deleteSubDist(@RequestBody AddressMasterHolder addressHolder){
		if(null!= addressHolder) {
			return subdist.deleteSubDist(addressHolder);
		}
		return null;
	}
	
//	@PostMapping(value="/bulkDelete",produces="applcation/json")
//	public ResponseEntity<?> bulkDelete(@RequestBody AddressMasterHolder addressHolder){
//		if(null!= addressHolder) {
//			return subdist.bulkDelete(addressHolder);
//		}
//		return null;
//	}
	
	
}
