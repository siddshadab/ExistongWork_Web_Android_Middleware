package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.SystemParameterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.SystemParameterHolder;

public interface SystemParameterServices {

	public ResponseEntity<?> getAllSystemParameterData() ;

	public ResponseEntity<?> addList(SystemParameterEntity systemParameterEntity);
	
	public ResponseEntity<?> addSysParameter(SystemParameterHolder systemParamterHolder);
	
	public ResponseEntity<?> editSysParameter(SystemParameterHolder systemParamterHolder);
	
	public ResponseEntity<?> deleteSysParameter(List<SystemParameterHolder>  code);
	
	public ResponseEntity<?> findByMcodeMlbrcd(SystemParameterHolder systemParamterHolder);
}
