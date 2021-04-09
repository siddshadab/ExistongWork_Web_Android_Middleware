package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.KycMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.UserDetailsMasterHolder;

public interface UserMasterDetailsService {



	ResponseEntity<UserMasterEntity> loadUserByMusrcode(String musrcode, String musrpass);//mac id remove from paramaeter
	
	ResponseEntity<List<UserMasterEntity>> getHerarchy(String musrcode);
	
	ResponseEntity<UserMasterEntity> changePassword(String musrcode, String oldPass,String newPass,String mregisterdMacId );
	
	ResponseEntity<?> addList(UserMasterEntity userMasterEntity);

	List<UserMasterEntity> getUserData(UserMasterEntity userMasterEntity);

	ResponseEntity<?> deleteUser(UserDetailsMasterHolder userHolder);
	
	ResponseEntity<?> updateUser(UserMasterEntity userMasterEntity);

	ResponseEntity<?> getUsrCdDesc();
	
	ResponseEntity<?> getAllUsrByGrpCd();
	
	ResponseEntity<?> findRecByUsrCd(UserMasterEntity userMasterEntity);
	
	
	


}
