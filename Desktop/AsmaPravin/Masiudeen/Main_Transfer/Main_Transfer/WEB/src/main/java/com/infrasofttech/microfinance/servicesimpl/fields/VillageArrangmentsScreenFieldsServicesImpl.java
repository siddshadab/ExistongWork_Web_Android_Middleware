package com.infrasofttech.microfinance.servicesimpl.fields;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.fields.VillageArrangmentsScreenFieldsEntity;
import com.infrasofttech.microfinance.repository.fields.VillageArrangmentsScreenFieldsRepository;
import com.infrasofttech.microfinance.services.fields.VillageArrangmentsScreenFieldsServices;

@Service
@Transactional
public class VillageArrangmentsScreenFieldsServicesImpl implements VillageArrangmentsScreenFieldsServices {

	@Autowired
	VillageArrangmentsScreenFieldsRepository villageArrangmentsScreenFieldsRepo;

	@Override
	public ResponseEntity<?> addVillageArrangmentsScreenFields(VillageArrangmentsScreenFieldsEntity entity) {
		try {
			return new ResponseEntity<Object>(villageArrangmentsScreenFieldsRepo.save(entity), new HttpHeaders(), HttpStatus.CREATED);
		} catch (Exception e) {

		}

		return null;
	}

	@Override
	public ResponseEntity<?> getAllArrangmentsScreenFields() {

		try {
			List<VillageArrangmentsScreenFieldsEntity> villageArrangmentsScreenFieldsEntity =villageArrangmentsScreenFieldsRepo.findAll();
			if(villageArrangmentsScreenFieldsEntity.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<VillageArrangmentsScreenFieldsEntity>>(villageArrangmentsScreenFieldsEntity,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}

}
