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
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFLoanClosureHolderBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.CIFLoanClosureServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.CIFLoanClosureSubmitServiceImpl;


@RestController
@RequestMapping("/CIF")
public class CIFLoanClosureController {

	@Autowired
	CIFLoanClosureServiceImpl cifLoanClosureServiceImpl;
	@Autowired
	CIFLoanClosureSubmitServiceImpl cifLoanClosureSubmitServiceImpl;
	

	@PostMapping(value = "/getLoanClosureDetail/",produces = "application/json")
	public ResponseEntity<?> getLoanClosureDetail(@RequestBody CIFLoanClosureHolderBean cifLoanClosureHolderBean){
		
		System.out.println(cifLoanClosureHolderBean.getMprdacctid());
		System.out.println(cifLoanClosureHolderBean.getMentrydate());

		try {
			if(cifLoanClosureHolderBean.getMprdacctid() != null && cifLoanClosureHolderBean.getMentrydate() != null) {
				System.out.println("valid prdaccid and date");
				List<CIFLoanClosureHolderBean> beanList = cifLoanClosureServiceImpl.omniSoapServicesCifLoanDetailList(cifLoanClosureHolderBean);
				return new ResponseEntity<List<CIFLoanClosureHolderBean>>(beanList,new HttpHeaders(),HttpStatus.OK);}
		}

		catch(Exception e) {
			return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

		return null;
		}
	
	@PostMapping(value = "/postLoanClosureVoucher/",produces = "application/json")
	public ResponseEntity<?> postLoanClosureVoucher(@RequestBody CIFLoanClosureHolderBean cifLoanClosureHolderBean){
		
		System.out.println(cifLoanClosureHolderBean.getMprdacctid());

		//try {
			if(cifLoanClosureHolderBean.getMprdacctid() != null) {
				System.out.println("valid prdaccid");
				List<CIFLoanClosureHolderBean> beanList = cifLoanClosureSubmitServiceImpl.omniSoapServicesCifPostLoanClosureVoucher(cifLoanClosureHolderBean);
				return new ResponseEntity<List<CIFLoanClosureHolderBean>>(beanList,new HttpHeaders(),HttpStatus.OK);}
//		}
//
//		catch(Exception e) {
//			return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
//		}

		return null;
		}
	
}
