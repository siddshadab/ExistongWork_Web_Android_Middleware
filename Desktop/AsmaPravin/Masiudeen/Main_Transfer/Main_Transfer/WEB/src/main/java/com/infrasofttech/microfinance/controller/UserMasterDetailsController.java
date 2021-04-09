package com.infrasofttech.microfinance.controller;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.GuarantorEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.UserDetailsMasterHolder;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.OmniLoginService;
import com.infrasofttech.microfinance.omni.service.impl.GroupService;
import com.infrasofttech.microfinance.services.UserMasterDetailsService;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/userDetailsMaster")
public class UserMasterDetailsController {

	@Autowired 
	UserMasterDetailsService userMasterDetailsService;
	
	
	@RequestMapping(value = "/loginValidation")
	@GetMapping(value = "/loginValidation", produces = "application/json")
	public ResponseEntity<UserMasterEntity> getUserRecord(@RequestBody UserMasterEntity recievedUserForm){
		System.out.println(recievedUserForm.getMregdevicemacid());
		return getIfUserIsValidated(recievedUserForm);
	} 
	
	
	@PostMapping(value = "/changePassword", produces = "application/json")
	public ResponseEntity<?>  changePass(@RequestBody UserMasterEntity  userMasterEntity){
		if(null != userMasterEntity.getMusrcode()&& null != userMasterEntity.getMusrpass()&&
				null != userMasterEntity.getMregdevicemacid()) {
			String newPass = "";
			String[] pass= userMasterEntity.getMusrpass().split("~");
			System.out.println(pass[1]);
			return userMasterDetailsService.changePassword(userMasterEntity.getMusrcode(), pass[0],
					pass[1], userMasterEntity.getMregdevicemacid());
		}
		return null;
	}
	
	
	
	

	private ResponseEntity<UserMasterEntity>  getIfUserIsValidated(UserMasterEntity recievedUserForm) {

	
		//if(recievedUserForm!=null && !Utility.checkIfNullOrEmpty(recievedUserForm.getUsrCode()) && !Utility.checkIfNullOrEmpty(recievedUserForm.getUsrPass())) {
			return  userMasterDetailsService.loadUserByMusrcode(recievedUserForm.getMusrcode(),
					recievedUserForm.getMusrpass());
		/*}
		return null;	   
		*/
	
	
					//,recievedUserForm.getMregdevicemacid());
		//if(recievedUserForm!=null && !Utility.checkIfNullOrEmpty(recievedUserForm.getUsrCode()) && !Utility.checkIfNullOrEmpty(recievedUserForm.getUsrPass())) {
			
		/*}
		return null;	   
		*/
	
		}
		


	@CrossOrigin(origins = "*", allowedHeaders = "*")
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?> addlist(@RequestBody UserMasterEntity userMasterEntity) {
		System.out.println("userMasterEntityxxxxxxxxxxxxxxxx"+userMasterEntity);
		if (null != userMasterEntity)
			return userMasterDetailsService.addList(userMasterEntity);
		return null;
	}

	
	@PostMapping(value ="/get", produces = "application/json")
	public List<UserMasterEntity> getAllGrpCd(@RequestBody UserMasterEntity userMasterEntity){
		System.out.println("userMasterEntityxxxxxxxxxxxxxxxx"+userMasterEntity);
		if (null != userMasterEntity)
			return userMasterDetailsService.getUserData(userMasterEntity);
		return null;
	}
	
	//@CrossOrigin(origins = "*", allowedHeaders = "*")
	@GetMapping(value ="/getAllUsr", produces = "application/json")
	public ResponseEntity<?> getAllUsrByGrpCd(){
		//System.out.println("userMasterEntityxxxxxxxxxxxxxxxx"+userMasterEntity);
		return userMasterDetailsService.getAllUsrByGrpCd();
		
	}
	
	@PostMapping(value="/delete", produces = "application/json")
	public ResponseEntity<?> deleteByUsrCode(@RequestBody UserDetailsMasterHolder userHolder){
		
		if (null != userHolder)
			return userMasterDetailsService.deleteUser(userHolder);
		return null;
	}
	
	@PostMapping(value="/update", produces = "application/json")
	public ResponseEntity<?> updateByUsrCode(@RequestBody UserMasterEntity userMasterEntity){
		System.out.println("UserMasterEntityxxxxxxxxxxxx"+userMasterEntity.getMusrcode());
		if (null != userMasterEntity)
			return userMasterDetailsService.updateUser(userMasterEntity);
		return null;
	}
	
	@GetMapping(value="/getUsrCdDesc",produces={ MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<?> getUsrCdDesc(){
		return userMasterDetailsService.getUsrCdDesc();
	}
	
	@PostMapping(value="/findRecByUsrCd",produces= "application/json")
	public ResponseEntity<?> findRecByUsrCd(@RequestBody UserMasterEntity userMasterEntity){
		if(userMasterEntity != null)
			return userMasterDetailsService.findRecByUsrCd(userMasterEntity);
		return null;
	}
}








