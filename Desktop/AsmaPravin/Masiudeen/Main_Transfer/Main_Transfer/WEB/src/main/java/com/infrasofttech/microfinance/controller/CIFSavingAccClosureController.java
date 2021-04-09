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
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFLoanClosureHolderBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.CIFLoanClosureSubmitServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.CIFSavingAccClosureServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.CIFSavingAccClosureSubmitServiceImpl;


@RestController
@RequestMapping("/CIF")
public class CIFSavingAccClosureController {

	@Autowired
	CIFSavingAccClosureServiceImpl cifSavingAccClosureServiceImpl;
	@Autowired
	CIFSavingAccClosureSubmitServiceImpl cifSavingAccClosureSubmitServiceImpl;
	

	@PostMapping(value = "/getSavingAccClosureDetail/",produces = "application/json")
	public ResponseEntity<?> getLoanClosureDetail(@RequestBody CIFHolderBean cifHolderBean){
		
		System.out.println(cifHolderBean.getMprdacctid());
		System.out.println(cifHolderBean.getMlbrcode());

		try {
			if(cifHolderBean.getMprdacctid() != null && cifHolderBean.getMlbrcode() != 0) {
				System.out.println("valid prdaccid and lbrcode");
				List<CIFHolderBean> beanList = cifSavingAccClosureServiceImpl.omniSoapServicesCifSavingClosureDetailList(cifHolderBean);
				return new ResponseEntity<List<CIFHolderBean>>(beanList,new HttpHeaders(),HttpStatus.OK);}
		}

		catch(Exception e) {
			return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

		return null;
		}
	
	@PostMapping(value = "/postSavingAcctClosureVoucher/",produces = "application/json")
	public ResponseEntity<?> postSavingAcctClosureVoucher(@RequestBody CIFHolderBean cifHolderBean){
		
		System.out.println(cifHolderBean.getMprdacctid());
		System.out.println(cifHolderBean.getMlbrcode());
		
		try {
			if(cifHolderBean.getMprdacctid() != null) {
				System.out.println("valid prdaccid");
				List<CIFHolderBean> beanList = cifSavingAccClosureSubmitServiceImpl.omniSoapServicesCifPostSavingAcctClosureVoucher(cifHolderBean);
				return new ResponseEntity<List<CIFHolderBean>>(beanList,new HttpHeaders(),HttpStatus.OK);}
		}

		catch(Exception e) {
			return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

		return null;
		}
	
}
