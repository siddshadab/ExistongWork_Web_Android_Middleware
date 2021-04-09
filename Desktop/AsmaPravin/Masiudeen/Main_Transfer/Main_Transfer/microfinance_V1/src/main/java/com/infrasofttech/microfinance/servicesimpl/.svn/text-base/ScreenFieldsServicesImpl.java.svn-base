package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.fields.VillageArrangmentsScreenFieldsEntity;
import com.infrasofttech.microfinance.entityBeans.fields.ScreenFieldsEntity;
import com.infrasofttech.microfinance.repository.fields.VillageArrangmentsScreenFieldsRepository;
import com.infrasofttech.microfinance.repository.fields.ScreenFieldsRepository;
import com.infrasofttech.microfinance.services.fields.VillageArrangmentsScreenFieldsServices;
import com.infrasofttech.microfinance.services.fields.ScreenFieldsServices;

@Service
@Transactional
public class ScreenFieldsServicesImpl implements ScreenFieldsServices {

	@Autowired
	ScreenFieldsRepository ScreenFieldsRepo;

	@Override
	public ResponseEntity<?> addScreenFields(ScreenFieldsEntity entity) {
		try {
			return new ResponseEntity<Object>(ScreenFieldsRepo.save(entity), new HttpHeaders(), HttpStatus.CREATED);
		} catch (Exception e) {

		}

		return null;
	}

	@Override
	public ResponseEntity<?> getAllScreenFields() {

		try {
			List<ScreenFieldsEntity> ScreenFieldsEntity =ScreenFieldsRepo.findAll();
			if(ScreenFieldsEntity.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<ScreenFieldsEntity>>(ScreenFieldsEntity,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}

}
