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
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.CIFRepayScheduleServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.CIFServiceImpl;


@RestController
@RequestMapping("/CIF")
public class CIFRepayScheduleController {

	@Autowired
	CIFRepayScheduleServiceImpl cifRepayScheduleServiceImpl;
	

	@PostMapping(value = "/getRepaymentSchedule/",produces = "application/json")
	public ResponseEntity<?> getRepaymentSchedule(@RequestBody CIFHolderBean cifHolderBean){
		
		System.out.println(cifHolderBean.getMprdacctid());

		try {
			if(cifHolderBean.getMprdacctid() != null) {
				System.out.println("valid prdaccid");
				List<CIFHolderBean> beanList = cifRepayScheduleServiceImpl.omniSoapServicesCifDetailList(cifHolderBean);
				return new ResponseEntity<List<CIFHolderBean>>(beanList,new HttpHeaders(),HttpStatus.OK);}
		}

		catch(Exception e) {
			return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

		return null;
		}
	
}
