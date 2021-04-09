package com.infrasofttech.microfinance.servicesimpl;

import java.time.LocalDateTime;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.CountriesEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.DailyLoanCollectionEntity;
import com.infrasofttech.microfinance.entityBeans.master.LookupMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.SystemParameterEntity;
import com.infrasofttech.microfinance.repository.DailyLoanCollectionRepository;
import com.infrasofttech.microfinance.repository.LookupMasterRepository;
import com.infrasofttech.microfinance.repository.SystemParameterRepository;
import com.infrasofttech.microfinance.services.DailyLoanCollectionServices;
import com.infrasofttech.microfinance.services.LookupMasterServices;
import com.infrasofttech.microfinance.services.SystemParameterServices;

@Transactional
@Service
public class DailyLoanCollectionImpl implements DailyLoanCollectionServices {

	@Autowired
	DailyLoanCollectionRepository repo;

	@Override
	public ResponseEntity<?> getAllLoanCollectionData() {
		try {
			List<DailyLoanCollectionEntity> dbEntity = repo.findAll();
			if (null == dbEntity)
				return ResponseEntity.notFound().build();
			return new ResponseEntity<Object>(dbEntity, new HttpHeaders(), HttpStatus.OK);
		} catch (Exception e) {
			// logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Transactional
	@Override
	public ResponseEntity<?> findByCreatedByAndLbr(DailyLoanCollectionEntity dailyLoanCollectionEntity) {



		try {
			LocalDateTime updatedDtOrCreatedDt = LocalDateTime.now();
			List<DailyLoanCollectionEntity> dailyLoanCollectionEntityList  =repo.findByCreatedByAndLbr
					(dailyLoanCollectionEntity.getMcreatedby(), dailyLoanCollectionEntity.getMlbrcode(),updatedDtOrCreatedDt);

			if(dailyLoanCollectionEntityList.isEmpty()) {
				return ResponseEntity.notFound().build();
			}
			return new ResponseEntity<List<DailyLoanCollectionEntity>>(dailyLoanCollectionEntityList,new HttpHeaders(),HttpStatus.OK); 
		}catch(Exception e) {
			System.out.println("No Record Found. wasasas : "+e.getStackTrace());
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}


	}

}
