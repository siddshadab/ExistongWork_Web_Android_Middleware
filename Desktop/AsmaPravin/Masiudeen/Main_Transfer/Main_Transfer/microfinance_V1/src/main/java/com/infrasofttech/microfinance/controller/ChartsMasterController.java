package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.BranchMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserAccessRightsEntity;
import com.infrasofttech.microfinance.servicesimpl.ChartsMasterServicesImpl;



@RestController
@RequestMapping("/chartsMaster")
public class ChartsMasterController {

	
	@Autowired
	ChartsMasterServicesImpl chartsMasterServicesImpl;
	
	
	@PostMapping(value = "/getChartsDataByAccessRightAndChartsMaster", produces = "application/json")
	public ResponseEntity<?>  getDataByAgentUserName(@RequestBody UserAccessRightsEntity userAccessRightsEntity){
		if(null != userAccessRightsEntity) {
			return chartsMasterServicesImpl.getChartsDataByAccessRightAndChartsMaster(userAccessRightsEntity.getUserAccressRightsCompositeEntity().getusrcode(),userAccessRightsEntity.getUserAccressRightsCompositeEntity().getMgrpcd());
		}
		return null;
	}
	
	
	
	@PostMapping(value = "/getChartsDataByAllThreeMasterJoin", produces = "application/json")
	public ResponseEntity<?>  getChartsDataByAllThreeMasterJoin(@RequestBody UserAccessRightsEntity userAccessRightsEntity){
		
		System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "+userAccessRightsEntity.getUserAccressRightsCompositeEntity().getusrcode()+"   "+userAccessRightsEntity.getUserAccressRightsCompositeEntity().getMgrpcd());
		if(null != userAccessRightsEntity) {
			return chartsMasterServicesImpl.getJoinAllthreeTables(userAccessRightsEntity.getUserAccressRightsCompositeEntity().getusrcode(),userAccessRightsEntity.getUserAccressRightsCompositeEntity().getMgrpcd());
		}
		return null;
	}
	
	
}