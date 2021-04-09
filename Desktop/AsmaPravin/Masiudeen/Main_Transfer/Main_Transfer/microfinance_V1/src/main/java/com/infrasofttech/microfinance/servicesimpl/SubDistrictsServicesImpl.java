package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

import com.infrasofttech.microfinance.entityBeans.CountriesEntity;
import com.infrasofttech.microfinance.entityBeans.DistrictsEntity;
import com.infrasofttech.microfinance.entityBeans.StatesEntity;
import com.infrasofttech.microfinance.entityBeans.SubDistrictsEntity;
import com.infrasofttech.microfinance.repository.CountriesRepository;
import com.infrasofttech.microfinance.repository.DistrictsRepository;
import com.infrasofttech.microfinance.repository.StatesRepository;
import com.infrasofttech.microfinance.repository.SubDistrictsRepository;
import com.infrasofttech.microfinance.services.DistrictsServices;
import com.infrasofttech.microfinance.services.SubDistrictsServices;


@Service
@Transactional
public class SubDistrictsServicesImpl implements SubDistrictsServices {	
	
	@Autowired
	SubDistrictsRepository repo;
	
	
	@Override
	public ResponseEntity<?> getSubDistricts() {
		try {
			List<SubDistrictsEntity> subDistrictList=repo.findAll();
			if(subDistrictList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<SubDistrictsEntity>>(subDistrictList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

}
