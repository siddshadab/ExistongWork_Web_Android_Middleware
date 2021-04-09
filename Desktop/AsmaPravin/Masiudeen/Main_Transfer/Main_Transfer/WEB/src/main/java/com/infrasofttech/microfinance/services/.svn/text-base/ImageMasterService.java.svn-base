package com.infrasofttech.microfinance.services;

import java.util.List;

import javax.validation.Valid;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.CustomerCompositePrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.ImageMasterEntity;



public interface ImageMasterService {	

	
	public ResponseEntity<?> getAllCustomerImageData();


	ResponseEntity<?> addImageList(List<ImageMasterEntity> customer);

	public ResponseEntity<?> addimage(@Valid List<ImageMasterEntity> entityList, int mCustRefno);


	public ResponseEntity<?> addimageAndStore(@Valid ImageMasterEntity entity, int mCustRefno);
	
	

}
