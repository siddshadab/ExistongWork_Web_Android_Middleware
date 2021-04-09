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
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFLoanPaymentHistoryHolderBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.CIFLoanPaymentHistoryServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.CIFRepayScheduleServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.CIFServiceImpl;


@RestController
@RequestMapping("/CIF")
public class CIFLoanPaymentHistoryController {

	@Autowired
	CIFLoanPaymentHistoryServiceImpl cifLoanPaymentHistoryServiceImpl;
	

	@PostMapping(value = "/getLoanPaymentHistory/",produces = "application/json")
	public ResponseEntity<?> getLoanPaymentHistory(@RequestBody CIFLoanPaymentHistoryHolderBean cifLoanPaymentHistoryHolderBean){
		
		System.out.println(cifLoanPaymentHistoryHolderBean.getMprdacctid());

		try {
			if(cifLoanPaymentHistoryHolderBean.getMprdacctid() != null) {
				System.out.println("valid prdaccid");
				List<CIFLoanPaymentHistoryHolderBean> beanList = cifLoanPaymentHistoryServiceImpl.omniSoapServicesPaymentDetailHistory(cifLoanPaymentHistoryHolderBean);
				return new ResponseEntity<List<CIFLoanPaymentHistoryHolderBean>>(beanList,new HttpHeaders(),HttpStatus.OK);}
		}

		catch(Exception e) {
			return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

		return null;
		}
	
}
