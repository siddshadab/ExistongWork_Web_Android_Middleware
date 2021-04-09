package com.infrasofttech.microfinance.services;

import java.util.List;

import javax.validation.Valid;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.CustomerFingerPrintEntity;
import com.infrasofttech.microfinance.entityBeans.master.ImageMasterEntity;

public interface CustomerFingerPrintService {



	ResponseEntity<?> addFingerPrintList(List<CustomerFingerPrintEntity> fingerPrintList );

	public ResponseEntity<?> addimage(@Valid List<CustomerFingerPrintEntity> entityList, int mCustRefno);


	public ResponseEntity<?> addFingerPrintAndStore(@Valid CustomerFingerPrintEntity entity, int mCustRefno);
	
	public ResponseEntity<?> getCustomerFingerPrint(int mrefno);
	
	
}
