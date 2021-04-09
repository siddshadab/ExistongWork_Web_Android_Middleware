package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.LoanLevelMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.LoanLevelHolder;
import com.infrasofttech.microfinance.services.LoanLevelService;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/loanlevel")
public class LoanLevelController {
	
	@Autowired 
	LoanLevelService loanLevelService;
	
	
	
	@GetMapping(value = "/getloanlevel", produces = "application/json")
	public ResponseEntity<?>  getLoanLevel(){
	
			return loanLevelService.getLoanLevel();
	

	}
	
	@PostMapping(value="/add" , produces="application/json")
	public ResponseEntity<?> addList(@RequestBody LoanLevelMasterEntity loanLevelMasterEntity){
		System.out.println("LoanLevelMasterEntityzxxxxxxxxxxxxxxxxxxxx"+loanLevelMasterEntity);
		
		if(null != loanLevelMasterEntity) {
			return loanLevelService.addList(loanLevelMasterEntity); 
		}
		return null;
	}
	
	@PostMapping(value="/update",produces = { MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<?> updateByMref(@RequestBody LoanLevelMasterEntity loanLevelMasterEntity){
		System.out.println("LoanLevelMasterEntityxxxxxxxxxxxx"+loanLevelMasterEntity.getMrefno());
		System.out.println("loanLevelService.updateByMref(loanLevelMasterEntity) "+loanLevelService.updateByMref(loanLevelMasterEntity).getStatusCode().toString());
		if (null != loanLevelMasterEntity)			
			return loanLevelService.updateByMref(loanLevelMasterEntity);
		return null;
	}
	
	
	@PostMapping(value="/delete",produces={ MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<?> deleteByMref(@RequestBody LoanLevelHolder loanLevelHolder){			
		
		System.out.println("loanholderxxxxxxxxxx"+loanLevelHolder);
		if(null != loanLevelHolder)
			return loanLevelService.deleteByMref(loanLevelHolder.getMrefno());
		return null;
	}
	
	@PostMapping(value="/findByRecByMref",produces="application/json")
	public ResponseEntity<?> findByRecByMref(@RequestBody LoanLevelMasterEntity loanEntity){
		if(loanEntity !=null) {
			return loanLevelService.findByRecByMref(loanEntity);
		}
		return null;
	}
}
