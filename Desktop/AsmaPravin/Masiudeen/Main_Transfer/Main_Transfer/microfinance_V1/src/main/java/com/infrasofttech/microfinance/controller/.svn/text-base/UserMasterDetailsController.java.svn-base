package com.infrasofttech.microfinance.controller;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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
	
	
	@PostMapping(value = "/changePassword/", produces = "application/json")
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
	
	
	@PostMapping(value = "/updateProfileImage/", produces = "application/json")
	public ResponseEntity<?>  updateProfileImage(@RequestBody UserMasterEntity  userMasterEntity){
		if(null != userMasterEntity.getMusrcode() && null != userMasterEntity.getProfileimage()) {			
			return userMasterDetailsService.updateProfileImage(userMasterEntity.getMusrcode(), userMasterEntity.getProfileimage());
		}
		return null;
	}
	
	
	
	

	private ResponseEntity<UserMasterEntity>  getIfUserIsValidated(UserMasterEntity recievedUserForm) {

	
		//if(recievedUserForm!=null && !Utility.checkIfNullOrEmpty(recievedUserForm.getUsrCode()) && !Utility.checkIfNullOrEmpty(recievedUserForm.getUsrPass())) {
			return  userMasterDetailsService.loadUserByMusrcode(recievedUserForm.getMusrcode(),
					recievedUserForm.getMusrpass()
		/*}
		return null;	   
		*/
	
	
					,recievedUserForm.getMregdevicemacid());
		//if(recievedUserForm!=null && !Utility.checkIfNullOrEmpty(recievedUserForm.getUsrCode()) && !Utility.checkIfNullOrEmpty(recievedUserForm.getUsrPass())) {
			
		/*}
		return null;	   
		*/
	
		}
		


	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?> addlist(@RequestBody UserMasterEntity userMasterEntity) {
		
		if (null != userMasterEntity)
			return userMasterDetailsService.addList(userMasterEntity);
		return null;
	}

	
	
	@PostMapping(value = "/resetPassword/", produces = "application/json")
	public ResponseEntity<?>  resetPassword(@RequestBody UserMasterEntity  userMasterEntity){
		if(null != userMasterEntity.getMusrcode()&& null != userMasterEntity.getMusrpass()) {
			
			return userMasterDetailsService.resetPassword(userMasterEntity.getMusrcode(), userMasterEntity.getMusrpass());
		}
		return null;
	}
	

	}








