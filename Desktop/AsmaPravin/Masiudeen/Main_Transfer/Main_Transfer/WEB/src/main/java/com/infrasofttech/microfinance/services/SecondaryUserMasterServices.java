package com.infrasofttech.microfinance.services;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.SecondaryUserMasterEntity;

public interface SecondaryUserMasterServices {

	ResponseEntity<?> getAllSecondaryUser();

	ResponseEntity<?> addSecondaryUser(SecondaryUserMasterEntity secondaryEntity);

	ResponseEntity<?> editSecondaryUser(SecondaryUserMasterEntity secondaryEntity);

	ResponseEntity<?> deleteSecondaryUser(SecondaryUserMasterEntity secondaryEntity);

}
