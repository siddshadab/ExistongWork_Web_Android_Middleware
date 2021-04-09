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
import com.infrasofttech.microfinance.entityBeans.master.holder.BulkLoanPreClosureHolderBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.BulkLoanPreClosureServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.BulkLoanPreClosureSubmitServiceImpl;


@RestController
@RequestMapping("/bulkPreClosure")
public class BulkLoanPreClosureController {

	@Autowired
	BulkLoanPreClosureServiceImpl closureServiceImpl;
	@Autowired
	BulkLoanPreClosureSubmitServiceImpl closureSubmitServiceImpl;	
	

	@PostMapping(value = "/getAccDetails/",produces = "application/json")
	public ResponseEntity<?> getCifDetailList(@RequestBody BulkLoanPreClosureHolderBean closureHolderBean){
		
		System.out.println(closureHolderBean.getMgroupcd());
		System.out.println(closureHolderBean.getMlbrcode());

		try {
			if(closureHolderBean.getMgroupcd() != 0 && closureHolderBean.getMlbrcode() != 0) {
				System.out.println("both groupcd and lbrcode value are present");
				List<BulkLoanPreClosureHolderBean> beanList = closureServiceImpl.omniSoapServicesBulkClosureList(closureHolderBean);
				return new ResponseEntity<List<BulkLoanPreClosureHolderBean>>(beanList,new HttpHeaders(),HttpStatus.OK);}
		}

		catch(Exception e) {
			return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
		return null;
		}
	
	
	@PostMapping(value = "/postVoucher/",produces = "application/json")
	public ResponseEntity<?> postLoanPreClosureVoucher(@RequestBody List<BulkLoanPreClosureHolderBean> closureHolderBean){	
		
		List<BulkLoanPreClosureHolderBean> beanList = closureSubmitServiceImpl.omniSoapServicesPostLoanClosureVoucher(closureHolderBean);
		return new ResponseEntity<List<BulkLoanPreClosureHolderBean>>(beanList,new HttpHeaders(),HttpStatus.OK);
			
	}
	
}
