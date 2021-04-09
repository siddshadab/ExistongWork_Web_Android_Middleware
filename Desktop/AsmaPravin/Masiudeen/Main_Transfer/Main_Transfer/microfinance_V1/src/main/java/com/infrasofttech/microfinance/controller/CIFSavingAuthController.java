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

import com.infrasofttech.microfinance.entityBeans.master.holder.CIFHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFSavingAuthHolder;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.CIFSavingAuthDetailsServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.CIFSavingWithdrawalAuthSubmit;

@RestController
@RequestMapping("/CIFSvingWdrawAuth")
public class CIFSavingAuthController {
	
	@Autowired
	CIFSavingAuthDetailsServiceImpl cifSavingAuthDetailsServiceImpl;
	
	@Autowired
	CIFSavingWithdrawalAuthSubmit cIFSavingWithdrawalAuthSubmit;


	@PostMapping(value = "/getPendingAuthorizationDetails/",produces = "application/json")
	public ResponseEntity<?> getDetails(@RequestBody CIFSavingAuthHolder cifSavingAuthHolder){
		try {
			if(cifSavingAuthHolder.getMusercode() != null && !"".equals(cifSavingAuthHolder.getMusercode())) {
				System.out.println("valid prdaccid and lbrcode");
				List<CIFSavingAuthHolder> beanList = cifSavingAuthDetailsServiceImpl.omniSoapSavingAuthDetails(cifSavingAuthHolder) ;//= cifSavingAccClosureServiceImpl.omniSoapServicesCifSavingClosureDetailList(cifHolderBean);
				return new ResponseEntity<List<CIFSavingAuthHolder>>(beanList,new HttpHeaders(),HttpStatus.OK);}
		}

		catch(Exception e) {
			return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

		return null;
		
	}
	
	@PostMapping(value = "/submitresponse/",produces = "application/json")
	public ResponseEntity<?> submitSavingAuthResponse(@RequestBody CIFSavingAuthHolder cifSavingAuthHolder){
		CIFSavingAuthHolder returnBean =new CIFSavingAuthHolder();
		//try {
			//if(cifSavingAuthHolder.getResponse() != 0) {
				System.out.println("valid prdaccid and lbrcode");
				
						
				OmniSoapResultBean returnedOmniBean = 	cIFSavingWithdrawalAuthSubmit.omniSoapServices(cifSavingAuthHolder);
				if(returnedOmniBean.getStatus()==1) {
					returnBean.setMissynctocoresys(1);
					returnBean.setMerrormessage(returnedOmniBean.getError());
				}else {
					returnBean.setMissynctocoresys(0);
					returnBean.setMerrormessage(returnedOmniBean.getError());
				}
				return new ResponseEntity<CIFSavingAuthHolder>(returnBean,new HttpHeaders(),HttpStatus.OK);
				
			//}
//		}
//
//		catch(Exception e) {
//			System.out.println("kuch fat gya");
//			return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
//		}

		//return null;
		
	}
	
	
	
	
}
