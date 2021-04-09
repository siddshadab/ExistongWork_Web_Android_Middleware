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

import com.infrasofttech.microfinance.entityBeans.master.BranchMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.ChartsMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserAccessRightsEntity;
import com.infrasofttech.microfinance.services.ChartsMasterService;
import com.infrasofttech.microfinance.servicesimpl.ChartsMasterServicesImpl;


@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/chartsMaster")
public class ChartsMasterController {

	
	@Autowired
	ChartsMasterServicesImpl chartsMasterServicesImpl;
	
	@Autowired
	ChartsMasterService chartsMasterService;
	
	@GetMapping(value = "/getAll", produces = "application/json")
	public ResponseEntity<?>  getAll(){		
			return chartsMasterServicesImpl.getAll();		
	}
	
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
	
	@PostMapping(value = "/addChart", produces = "application/json")
	public ResponseEntity<?>  addChart(@RequestBody ChartsMasterEntity chartMasterEntity){
		
		System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "+chartMasterEntity);
		if(null != chartMasterEntity) {
			return chartsMasterServicesImpl.addChart(chartMasterEntity);
		}
		return null;
	}
	
	//crud
	
//	@PostMapping(value = "/add", produces = "application/json")
//	public ResponseEntity<?>  addCharts(@RequestBody ChartsMasterEntity chartsMasterEntity){
//		
//		System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "+chartsMasterEntity);
//		if(null != chartsMasterEntity) {
//			return chartsMasterService.addCharts(chartsMasterEntity);
//		}
//		return null;
//	}
//	
	@PostMapping(value = "/edit", produces = "application/json")
	public ResponseEntity<?>  editCharts(@RequestBody ChartsMasterEntity chartsMasterEntity){
		
		System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "+chartsMasterEntity);
		if(null != chartsMasterEntity) {
			return chartsMasterService.editCharts(chartsMasterEntity);
		}
		return null;
	}
	
	@PostMapping(value = "/delete", produces = "application/json")
	public ResponseEntity<?>  deleteCharts(@RequestBody List<Integer> mrefno){
		
		System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "+mrefno);
		if(null != mrefno) {
			return chartsMasterService.deleteCharts(mrefno);
		}
		return null;
	}
	
	
}