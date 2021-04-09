package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.SpeedoMeterEntity;
import com.infrasofttech.microfinance.servicesimpl.SpeedoMeterServiceImpl;

@RestController
@RequestMapping("/speedoMeterData")
public class SpeedoMeterController {
	
	@Autowired
	SpeedoMeterServiceImpl SpeedoMeterService;
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<SpeedoMeterEntity> spmetr){
		if(null != spmetr)
			return SpeedoMeterService.addList(spmetr);
		return null;
	}


}
