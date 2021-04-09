package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.SystemParameterEntity;
import com.infrasofttech.microfinance.repository.SystemParameterRepository;
import com.infrasofttech.microfinance.services.SystemParameterServices;

@Transactional
@Service
public class SystemParameterServicesImpl implements SystemParameterServices{

	@Autowired
	SystemParameterRepository repo;
	
	@Override
	public ResponseEntity<?> getAllSystemParameterData() {
		try {
			List<SystemParameterEntity> dbEntity = repo.findAll();
			if(null == dbEntity)
				return ResponseEntity.notFound().build();
			return new ResponseEntity<Object>(dbEntity,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	
	
	public String getCodeDesc(String mcode) {
		String getCodeDesc =null;
		if(mcode !=null) {
			try {
			getCodeDesc= repo.findByCode(mcode).getMcodedesc();
			}catch(Exception e) {
				getCodeDesc=null;
				e.printStackTrace();
			}
		}
		return getCodeDesc;
	}
	
	
	
	public String getCodeValue(String mcode) {
		String getCodeValue =null;
		if(mcode !=null) {
			try {
				System.out.println("Getting code for "+ mcode);
				getCodeValue= repo.findByCode(mcode).getMcodevalue();
			}catch(Exception e) {
				getCodeValue=null;
				e.printStackTrace();
			}
		}
		return getCodeValue;
	}
}
