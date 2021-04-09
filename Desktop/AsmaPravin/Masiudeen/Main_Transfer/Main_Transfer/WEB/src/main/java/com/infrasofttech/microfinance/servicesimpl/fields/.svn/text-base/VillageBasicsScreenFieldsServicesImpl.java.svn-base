package com.infrasofttech.microfinance.servicesimpl.fields;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.fields.VillageBasicScreenFieldsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CentersFoundationEntity;
import com.infrasofttech.microfinance.repository.fields.VillageBasicScreenFieldsRepository;
import com.infrasofttech.microfinance.services.fields.VillageBasicsScreenFieldsServices;

@Service
@Transactional
public class VillageBasicsScreenFieldsServicesImpl implements VillageBasicsScreenFieldsServices {

	@Autowired
	VillageBasicScreenFieldsRepository villageBasicScreenFieldsrepo;

	@Override
	public ResponseEntity<?> addVillageBasicsScreenFields(VillageBasicScreenFieldsEntity entity) {
		try {
			return new ResponseEntity<Object>(villageBasicScreenFieldsrepo.save(entity), new HttpHeaders(), HttpStatus.CREATED);
		} catch (Exception e) {

		}

		return null;
	}

	@Override
	public ResponseEntity<?> getAllBasicsScreenFields() {

		try {
			List<VillageBasicScreenFieldsEntity> villageBasicScreenFieldsEntity =villageBasicScreenFieldsrepo.findAll();
			if(villageBasicScreenFieldsEntity.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<VillageBasicScreenFieldsEntity>>(villageBasicScreenFieldsEntity,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}

}
