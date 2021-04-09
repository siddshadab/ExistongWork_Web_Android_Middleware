package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.CentersFoundationEntity;
import com.infrasofttech.microfinance.entityBeans.master.GroupsFoundationEntity;
import com.infrasofttech.microfinance.services.CentersFoundationService;

@RestController
@RequestMapping("/createCentersFoundations")
public class CentersFoundationsController {
	
	@Autowired 
	CentersFoundationService centersFoundationService;
	
	
	@GetMapping(value = "/getlistOfData", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return centersFoundationService.getAllUsersData();
	}
	
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<CentersFoundationEntity> centerList){
		System.out.println("centerList--------------------"+centerList.toString());
		if(null != centerList) {
			System.out.println("yhhhhhhh");
			return centersFoundationService.addList(centerList);
		}
			
		return null;
	}
	

	
	
	@PostMapping(value = "/getDataByMcreatedBy", produces = "application/json")
	public ResponseEntity<?>  getDataByAgentUserName(@RequestBody CentersFoundationEntity center){
		if(null != center) {
			return centersFoundationService.getDataByCreatedBy(center.getMcreatedby());
		}
		return null;
	}
	
	
	
	  @PostMapping(value = "/getCenterDataByCreatedByAndMlbrCode", produces =
			  "application/json")	 
			public ResponseEntity<?>  getDataByMcreatedByAndMlbrCode(@RequestBody CentersFoundationEntity group){
				if(null != group) {
					return centersFoundationService.getDataByMcreatedByAndMlbrCode(group.getMcreatedby(),group.getMlbrcode());
				}
				return null;
			}
	
	

	@PostMapping(value = "/getDataByAgentUserNameAndIdAndCenterName", produces = "application/json")
	public ResponseEntity<?>  getDataByAgentUserNameAndIdAndCenterName(@RequestBody CentersFoundationEntity center){
		if(null != center) {
			return centersFoundationService.getDataUserByMcenterNameAndMrefno(center.getMcentername(),center.getMrefno());
		}
		return null;
	}
	
	@PostMapping(value = "/updateCenterLocation", produces = "application/json")
	public ResponseEntity<?>  updateCenterLocation(@RequestBody CentersFoundationEntity center){
		try {
			if(null != center) {
				center.setMissynctocoresys(centersFoundationService.updateCenterLocation(center));
				
				return new ResponseEntity<CentersFoundationEntity>(center,new HttpHeaders(),HttpStatus.OK);
			}
		}catch(Exception e) {
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
		return null;
	}
	
}
