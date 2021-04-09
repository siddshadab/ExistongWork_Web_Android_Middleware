package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Lookup;
import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.LookupComposieEntity;
import com.infrasofttech.microfinance.entityBeans.master.LookupMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.LookupMasterEntityHolder;

public interface LookupMasterServices {

	public ResponseEntity<?> getAllLookupData() ;
	
	public ResponseEntity<?> addLookupEntity(LookupMasterEntityHolder lookupEntityHolder);
	
	public ResponseEntity<?> updateLookupEntity(LookupMasterEntityHolder lookupEntityHolder);
	
	public ResponseEntity<?> deleteLookupEntity(LookupMasterEntityHolder lookupEntityHolder);
	
	public ResponseEntity<?> FindByMcodeType(LookupComposieEntity lookupComposieEntity);
	
	public ResponseEntity<?> findAllLookup();

	public ResponseEntity<?> findByRecMCode(LookupMasterEntityHolder lookupHolder);
	
	public ResponseEntity<?> findByCode();
	
	public ResponseEntity<?> findByCodeType(LookupMasterEntityHolder lookupHolder);
	
	public ResponseEntity<?> deleteByBulk(List<LookupMasterEntityHolder> code);
	
	
}