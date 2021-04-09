package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.CountriesEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsListEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsCollectionListEntity;
import com.infrasofttech.microfinance.entityBeans.master.SpeedoMeterEntity;
import com.infrasofttech.microfinance.repository.LookupMasterRepository;
import com.infrasofttech.microfinance.services.SavingsListServices;
import com.infrasofttech.microfinance.servicesimpl.CountriesServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.LookupMasterServicesImpl;
import com.infrasofttech.microfinance.servicesimpl.SavingsListServicesImpl;
import com.infrasofttech.microfinance.servicesimpl.SavingsCollectionListServicesImpl;
import com.infrasofttech.microfinance.servicesimpl.SpeedoMeterServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.SystemParameterServicesImpl;

@RestController
@RequestMapping("/SavingsCollectionListController")
public class SavingsCollectionListController {


	@Autowired
	SavingsCollectionListServicesImpl savingsCollectionListServicesImpl;

	

	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?> addlist(@RequestBody List<SavingsCollectionListEntity> svng) {
		if (null != svng)
			return savingsCollectionListServicesImpl.addList(svng);
		return null;
	}
}

