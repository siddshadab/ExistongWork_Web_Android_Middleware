package com.infrasofttech.microfinance.controller;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.holder.MiniStatementHolderBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.OmniLoginService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.OmniMiniStatementServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;



@RestController
@RequestMapping("/MiniStatementController")
public class MiniStatementController {


	@Autowired
	OmniMiniStatementServiceImpl miniStatementServiceImpl;
	
	@Autowired
	OmniLoginService omniLoginService;

	@PostMapping(value = "/getMiniStatementProductAccIdAndLbrCode/",produces = "application/json")
	public ResponseEntity<?> getSavingsListbyProductAccId(@RequestBody MiniStatementHolderBean miniStatementHolderBean){
		System.out.println(miniStatementHolderBean.getMprdacctid());
		System.out.println(miniStatementHolderBean.getMlbrcode());


		try {
			if(null != miniStatementHolderBean.getMprdacctid()) {
				if(Constants.Field204 != null && Constants.Field204.equals("") ) {
    				//OmniLoginService login = new OmniLoginService();
    				omniLoginService.loginOmni();
    			}
				List<MiniStatementHolderBean> beanList = miniStatementServiceImpl.omniSoapServicesMiniStatementList(miniStatementHolderBean);
				return new ResponseEntity<List<MiniStatementHolderBean>>(beanList,new HttpHeaders(),HttpStatus.OK);}
		}

		catch(Exception e) {
			return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

		return null; }





}
