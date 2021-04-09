
package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.LookupComposieEntity;
import com.infrasofttech.microfinance.entityBeans.master.LookupMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.LookupMasterEntityHolder;
import com.infrasofttech.microfinance.services.LookupMasterServices;
import com.infrasofttech.microfinance.servicesimpl.LookupMasterServicesImpl;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/lookupMasterController")
public class LookupMasterController {
	
	
	
	@Autowired 
	LookupMasterServicesImpl lookupMasterServicesImpl;

	@Autowired
	LookupMasterServices lookupMasterServices;

/*	@GetMapping(value = "/get/{countryName}", produces = "application/json")
	public ResponseEntity<?> getCountries(@PathVariable String countryName){	
		return countries.getCountries(countryName);
	}*/
	
	
/*	@GetMapping(value = "/getAllSubLookup/", produces = "application/json")
	public ResponseEntity<?>  getAllSubLookupData() {
		return lookupMasterServicesImpl.getAllSubLookupData();
	}*/

	/*
	 * @PostMapping(value = "/add", produces = "application/json") public
	 * ResponseEntity<?> addlist(@RequestBody LookupComposieEntity
	 * lookupComposieEntity){
	 * System.out.println("lookupMasterEntityxxxxxxxxxxxxxxxxx"+lookupComposieEntity
	 * ); if(null != lookupComposieEntity) return
	 * lookupMasterServices.addList(lookupComposieEntity); return null; }
	 */
	
	@GetMapping(value = "/getAllLookup/", produces = "application/json")
	public ResponseEntity<?>  getAllLookupData() {
		return lookupMasterServices.getAllLookupData();
	}
	
	@PostMapping(value="/add", produces ="application/json")
	public ResponseEntity<?> addLookupCodeType(@RequestBody LookupMasterEntityHolder lookupEntityHolder){
		
		if(null != lookupEntityHolder) {
			System.out.println("lookupEntityHolder "+lookupEntityHolder);
			return lookupMasterServices.addLookupEntity(lookupEntityHolder);
		}						
		return null;
	}
	
//	@PostMapping(value="/addVerify", produces ="application/json")
//	public ResponseEntity<?> addLookupDetails(@RequestBody LookupMasterEntity lookupMasterEntity){
//				
//		if(null != lookupMasterEntity) {		
//			System.out.println(lookupMasterEntity);
//			return lookupMasterServices.addList(lookupMasterEntity);
//		}
//		return null;	
//	}
	
	@PostMapping(value="/edit", produces ="application/json")
	public ResponseEntity<?> editLookupCodeType(@RequestBody LookupMasterEntityHolder lookupEntityHolder){
		
		if(null != lookupEntityHolder) {
			System.out.println("lookupEntityHolder "+lookupEntityHolder);
			return lookupMasterServices.updateLookupEntity(lookupEntityHolder);
		}						
		return null;
	}
	
	@PostMapping(value="/delete", produces ="application/json")
	public ResponseEntity<?> deleteLookupCodeType(@RequestBody LookupMasterEntityHolder lookupEntityHolder){
		
		if(null != lookupEntityHolder) {
			System.out.println("lookupEntityHolder "+lookupEntityHolder.getCode());
			return lookupMasterServices.deleteLookupEntity(lookupEntityHolder);
		}						
		return null;
	}
	
	@GetMapping(value="/findAll",produces="application/json")
	public ResponseEntity<?> findAllLookup(){
		return lookupMasterServices.findAllLookup();
	}
	
	@PostMapping(value="/findByMcode", produces="application/json")
	public ResponseEntity<?> findByMcode(@RequestBody LookupMasterEntityHolder lookupHolder){
		if(lookupHolder !=null) {
			return lookupMasterServices.findByRecMCode(lookupHolder);
		}
		return null;
	}
	
	@GetMapping(value="/findBy", produces="application/json")
	public ResponseEntity<?> findByCode(){		
			return lookupMasterServices.findByCode();
		
	}
	
	@PostMapping(value="/findByCodeType", produces="application/json")
	public ResponseEntity<?> findByCodeType(@RequestBody LookupMasterEntityHolder lookupHolder){		
		if(lookupHolder !=null) {
			return lookupMasterServices.findByCodeType(lookupHolder);
		}
		return null;
	}
	
	@PostMapping(value="/deleteByBulk", produces="application/json")
	public ResponseEntity<?> deleteByBulk(@RequestBody List<LookupMasterEntityHolder> code){
	if(code != null) {
		return lookupMasterServices.deleteByBulk(code);
	 }
		return null;
	}
}
