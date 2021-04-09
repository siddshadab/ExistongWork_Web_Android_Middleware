package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CustomerFingerPrintEntity;
import com.infrasofttech.microfinance.entityBeans.master.ImageMasterEntity;
import com.infrasofttech.microfinance.repository.CustomerFingerPrintRepository;
import com.infrasofttech.microfinance.services.CustomerFingerPrintService;

@Service
@Transactional
public class CustomerFingerPrintServiceImpl implements CustomerFingerPrintService{

	@Autowired
	CustomerFingerPrintRepository fingerPrintRepo;
	
	
	@Override
	public ResponseEntity<?> addFingerPrintList(List<CustomerFingerPrintEntity> fingerPrintList) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResponseEntity<?> addimage(@Valid List<CustomerFingerPrintEntity> entityList, int mCustRefno) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResponseEntity<?> addFingerPrintAndStore(@Valid CustomerFingerPrintEntity entity, int mCustRefno) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResponseEntity<?> getCustomerFingerPrint(int mrefno) {
		try {
			List<CustomerFingerPrintEntity> fingerPrintList=fingerPrintRepo.findByMrefno(mrefno);
			if(fingerPrintList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CustomerFingerPrintEntity>>(fingerPrintList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

}
