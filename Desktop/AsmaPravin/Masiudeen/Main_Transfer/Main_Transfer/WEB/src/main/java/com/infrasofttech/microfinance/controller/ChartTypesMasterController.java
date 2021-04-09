package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.ChartTypesMasterEntity;
import com.infrasofttech.microfinance.services.ChartTypeMasterServices;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/chartTypeMaster")
public class ChartTypesMasterController {

	
	@Autowired 
	ChartTypeMasterServices service;
	
	@PostMapping(value = "/getChartType", produces = "application/json")
	public ResponseEntity<?> getChartsType(@RequestBody ChartTypesMasterEntity chartTypesMasterEntity){
		if(chartTypesMasterEntity !=null) {
			System.out.println("chartTypesMasterEntity"+chartTypesMasterEntity);
			return service.getcharts(chartTypesMasterEntity);
		}
		return null;
	}
	
	
	@GetMapping(value="/getAll", produces="application/json")
	public ResponseEntity<?> getAllChartTypes(){
		return service.getAllChartTypes();
	}
	
	@PostMapping(value = "/addChartTypes", produces = "application/json")
	public ResponseEntity<?> addChartTypes(@RequestBody ChartTypesMasterEntity chartTypesMasterEntity){
		if(chartTypesMasterEntity !=null) {
			System.out.println("chartTypesMasterEntity"+chartTypesMasterEntity);
			return service.addChartTypes(chartTypesMasterEntity);
		}
		return null;
	}
	
	@PostMapping(value = "/editChartTypes", produces = "application/json")
	public ResponseEntity<?> editChartTypes(@RequestBody ChartTypesMasterEntity chartTypesMasterEntity){
		if(chartTypesMasterEntity !=null) {
			System.out.println("chartTypesMasterEntity"+chartTypesMasterEntity);
			return service.editChartTypes(chartTypesMasterEntity);
		}
		return null;
	}
	
	@PostMapping(value = "/deleteChartTypes", produces = "application/json")
	public ResponseEntity<?> deleteChartTypes(@RequestBody ChartTypesMasterEntity chartTypesMasterEntity){
		if(chartTypesMasterEntity !=null) {
			System.out.println("chartTypesMasterEntity"+chartTypesMasterEntity);
			return service.deleteChartTypes(chartTypesMasterEntity);
		}
		return null;
	}
	
}
