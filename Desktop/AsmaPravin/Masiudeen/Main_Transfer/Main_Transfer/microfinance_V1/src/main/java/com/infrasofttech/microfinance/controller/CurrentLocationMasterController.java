package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.CentersFoundationEntity;
import com.infrasofttech.microfinance.entityBeans.master.CurrentLocationMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.PathTrackerMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CurrentLocationHolderBean;
import com.infrasofttech.microfinance.servicesimpl.CurrentLocationMasterServiceImpl;

@RestController
@RequestMapping("/currentLocationMaster")
public class CurrentLocationMasterController {

	
	@Autowired 
	CurrentLocationMasterServiceImpl currentLocationMasterServiceImpl;
	
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody CurrentLocationMasterEntity currentLocationMasterEntity){
		if(null != currentLocationMasterEntity) {
			//System.out.println("inside add");
			return currentLocationMasterServiceImpl.add(currentLocationMasterEntity);
			
		}
			
		return null;
	}
	
	
	@PostMapping(value = "/getBySuperUser/", produces = "application/json")
	public ResponseEntity<?>  findBySuperUser(@RequestBody CurrentLocationMasterEntity currentLocationMasterEntity){
		if(null != currentLocationMasterEntity.getMreportinguser()) {	
			System.out.println("cccccccccccccccccccccXXXXXXXXXXXXXXXXXCCCCCC  : -"+ currentLocationMasterEntity.getMreportinguser());
			return new ResponseEntity<List<CurrentLocationHolderBean>>(currentLocationMasterServiceImpl.findBySuperUser(currentLocationMasterEntity.getMreportinguser()),new HttpHeaders(),HttpStatus.OK);
			
		}
		return null;
	}
	
	
	@PostMapping(value = "/getCenterByUser/", produces = "application/json")
	public ResponseEntity<?>  getCenterByUser(@RequestBody CentersFoundationEntity center){
		if(null != center) {
			return currentLocationMasterServiceImpl.getDataByCreatedBy(center.getMcreatedby());
		}
		return null;
	}
	
	@PostMapping(value = "/addPathTracker", produces = "application/json")
	public ResponseEntity<?>  addPathTracker(@RequestBody PathTrackerMasterEntity pathTrackerMasterEntity){
		if(null != pathTrackerMasterEntity) {
			//System.out.println("inside add");
			return currentLocationMasterServiceImpl.addPathTracker(pathTrackerMasterEntity);
			
		}
			
		return null;
	}
	
	
	@PostMapping(value = "/pathTrackerDraw", produces = "application/json")
	public ResponseEntity<?>  pathTrackerDraw(@RequestBody PathTrackerMasterEntity pathTrackerMasterEntity){
		if(null != pathTrackerMasterEntity) {
			//System.out.println("inside add");
			return currentLocationMasterServiceImpl.getPathTrackerDataFromUserId(pathTrackerMasterEntity.getMusrcode());
			
		}
			
		return null;
	}
	
}
