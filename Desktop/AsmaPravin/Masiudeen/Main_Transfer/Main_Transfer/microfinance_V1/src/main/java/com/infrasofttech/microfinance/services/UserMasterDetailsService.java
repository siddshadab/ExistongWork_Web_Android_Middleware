package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.UserMasterEntity;

public interface UserMasterDetailsService {



	ResponseEntity<UserMasterEntity> loadUserByMusrcode(String musrcode, String musrpass,String mRegDevMacId);
	
	ResponseEntity<List<UserMasterEntity>> getHerarchy(String musrcode);
	
	ResponseEntity<UserMasterEntity> changePassword(String musrcode, 
			String oldPass,String newPass,String mregisterdMacId );
	
	public ResponseEntity<?> addList(UserMasterEntity userMasterEntity) ;

	
	ResponseEntity<UserMasterEntity> resetPassword(String musrcode,String resetPass);
	public int updateUserMnoofbadlogins(String musrcode,int mnoofbadlogins);
	
	public ResponseEntity<?> updateProfileImage(String musrcode,byte[] profileimage);
}
