package com.infrasofttech.microfinance.controller;



import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProspectCreationEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CustomerHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.ProspectHolderBean;
import com.infrasofttech.microfinance.services.ProspectCreationService;

@RestController
@RequestMapping("/ProspectCreationMaster")
public class ProspectCreationController {

	@Autowired 
	ProspectCreationService prospectCreationService;
	
	
	@GetMapping(value = "/getlistOfData", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return null;
	}
	
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<ProspectCreationEntity> prospectList){
		if(null != prospectList)
			return null;
		return null;
	}
	
	@PostMapping(value = "/addProspectByHolder", produces = "application/json")
	public ResponseEntity<?>  addProspectListByHolder(@RequestBody List<ProspectHolderBean> prospectList){
				

		return prospectCreationService.addProspectListByHolder(prospectList);
		
	}
	
	
	@PostMapping(value = "/addProspectCheckedResult", produces = "application/json")
	public ResponseEntity<?>  addProspectCheckedResult(@RequestBody List<ProspectHolderBean> prospectList){
				

		return prospectCreationService.addProspectCheckedResult(prospectList);
		
	}

	
	@PostMapping(value = "/addAll", produces = "application/json")
	public ResponseEntity<?>  addAll(@RequestBody List<ProspectCreationEntity> prospectList){
		if(null != prospectList)
		
				return null;	
		return null;
	}
	
	
	@PostMapping(value = "/getProspect", produces = "application/json")
	public ResponseEntity<?>  getProspect(@RequestBody ProspectCreationEntity prospect){
		System.out.println(prospect.getMlastsynsdate());
		System.out.println(prospect.getMcreatedby());
		if( prospect.getMcreatedby()!=null )
			
			return prospectCreationService.getProspect(prospect.getMlastsynsdate(),prospect.getMcreatedby());
		
		System.out.println("agent user name is null");
				return null;
	}

	}








