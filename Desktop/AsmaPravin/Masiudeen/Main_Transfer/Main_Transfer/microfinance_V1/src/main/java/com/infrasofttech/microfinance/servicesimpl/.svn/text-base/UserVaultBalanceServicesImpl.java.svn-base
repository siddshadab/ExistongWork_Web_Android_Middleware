package com.infrasofttech.microfinance.servicesimpl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.infrasofttech.microfinance.entityBeans.master.UserVaultBalanceEntity;
import com.infrasofttech.microfinance.repository.UserValutBalanceRepository;
import com.infrasofttech.microfinance.services.UserVaultBalanceServices;


@Service
@Transactional
public class UserVaultBalanceServicesImpl implements UserVaultBalanceServices{

	@Autowired
	UserValutBalanceRepository userValutBalanceRepository;


	@Override
	public ResponseEntity<UserVaultBalanceEntity> findByMusrcode(String musrcode) {
		UserVaultBalanceEntity user = null;
		
		try {
			
			user  = (UserVaultBalanceEntity) userValutBalanceRepository.findByMusrcode(musrcode);
			
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			System.out.println("Exception occured");
	
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
			}
		return new ResponseEntity<UserVaultBalanceEntity>(user,new HttpHeaders(),HttpStatus.OK);
		
	}	
	

}
