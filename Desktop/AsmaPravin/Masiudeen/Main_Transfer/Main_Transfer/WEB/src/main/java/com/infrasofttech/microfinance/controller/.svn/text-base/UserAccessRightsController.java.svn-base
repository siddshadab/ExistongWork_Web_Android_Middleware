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

import com.infrasofttech.microfinance.entityBeans.master.UserAccessRightsEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserAccressRightsCompositeEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.MenuAndAccessRightsHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.MenuHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.UserAccessRightsHolder;
import com.infrasofttech.microfinance.services.MenuMasterService;
import com.infrasofttech.microfinance.services.UserAccessRightsService;
import com.infrasofttech.microfinance.servicesimpl.UserAccessRightsServicesImpl;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/userAccessRights")
public class UserAccessRightsController {
	
	@Autowired
	UserAccessRightsService userAccessRightsService;
	
	@Autowired
	UserAccessRightsServicesImpl userAccessRightsServicesImpl;

	@Autowired
	MenuMasterService menuMasterService;
	
	
	@GetMapping(value = "/getAllUserAccessRightsFromMaster", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return userAccessRightsService.getAllUserAccessRightsFromMaster();
	}
	
	@PostMapping(value = "/getUserAccessRightsByUSerCode", produces = "application/json")
	public ResponseEntity<?>  getDataByAgentUserName(@RequestBody UserAccessRightsEntity userAccessRightsEntity){
		if(null != userAccessRightsEntity) {
			return userAccessRightsService.getDataUserByMUserCode(userAccessRightsEntity.getUserAccressRightsCompositeEntity().getusrcode(),userAccessRightsEntity.getUserAccressRightsCompositeEntity().getMgrpcd());
		}
		return null;
	}
	
	
	
	@PostMapping(value="/add" , produces="application/json")
	public ResponseEntity<?> addList(@RequestBody UserAccessRightsHolder userAccessRights){
		System.out.println("userAccessRightsEntityxxxxxxxxxxxxxxxxxxxxx"+userAccessRights);
		
		
		if(null != userAccessRights) {
			return userAccessRightsService.addList(userAccessRights);
		}
		return null;
	}
	
	@PostMapping(value="/getMenuByUsrCode", produces="application/json")
	public List<MenuHolderBean> getMenubyUsrCode(@RequestBody UserAccressRightsCompositeEntity userAccressRightsCompositeEntity){
				
		if(null != userAccressRightsCompositeEntity) {
		
			return userAccessRightsService.getDataMenu(userAccressRightsCompositeEntity);
			
		}
		return null;
		
	}
	
	@PostMapping(value="/update", produces = "application/json")
	public ResponseEntity<?> updateByUsrCode(@RequestBody UserAccessRightsHolder userAccessRightsHolder){
		System.out.println("userAccessRightsEntityxxxxxxxxxxxx"+userAccessRightsHolder);
		if (null != userAccessRightsHolder)
			return userAccessRightsService.updateUserRights(userAccessRightsHolder);
		return null;
	}
	
	
	@PostMapping(value="/delete", produces="application/json")
	public ResponseEntity<?> deleteData(@RequestBody List<UserAccessRightsHolder> code ){
		
		System.out.println("xxxxxxxxxxxxxxxxxx"+code);
		if(null!= code) {
			return userAccessRightsService.deleteData(code);
		}
		
		return null;
	}	

	@PostMapping(value="/findRecByPrmKey",produces= "application/json")
	public ResponseEntity<?> findRecByPrmKey(@RequestBody UserAccessRightsHolder userAccessHolder){
		if(userAccessHolder !=null) {
			return userAccessRightsService.findRecByPrmKey(userAccessHolder);
		}
		return null;
	}
	
	
}
