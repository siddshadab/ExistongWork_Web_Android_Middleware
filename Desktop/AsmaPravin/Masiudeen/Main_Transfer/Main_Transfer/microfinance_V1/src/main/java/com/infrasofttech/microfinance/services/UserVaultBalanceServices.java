package com.infrasofttech.microfinance.services;



import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.UserVaultBalanceEntity;

@Service
public interface UserVaultBalanceServices {


	ResponseEntity<UserVaultBalanceEntity> findByMusrcode(String musrcode);
	
	

}
