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
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFTransactionHolderBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.CIFServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.CIFTransactionServiceImpl;


@RestController
@RequestMapping("/CIF")
public class CIFTransactionController {

	@Autowired
	CIFTransactionServiceImpl cifTransactionServiceImpl;
	

	@PostMapping(value = "/getCifTransactionDetails/",produces = "application/json")
	public ResponseEntity<?> getTransactionDetails(@RequestBody CIFTransactionHolderBean cifTransHolderBean){
		
		System.out.println(cifTransHolderBean.getMprdacctid());
		System.out.println(cifTransHolderBean.getMamt());

		try {
			if(cifTransHolderBean.getMamt() != 0 || cifTransHolderBean.getMprdacctid() != null) {
				System.out.println("prdaccid and amt both values are present");
				List<CIFTransactionHolderBean> beanList = cifTransactionServiceImpl.omniSoapServicesCifTransactionDetailList(cifTransHolderBean);
				return new ResponseEntity<List<CIFTransactionHolderBean>>(beanList,new HttpHeaders(),HttpStatus.OK);}
		}

		catch(Exception e) {
			return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

		return null;
		}
	
	@PostMapping(value = "/getCifWithdrawalDetails/",produces = "application/json")
	public ResponseEntity<?> getCifWithdrawalDetails(@RequestBody CIFTransactionHolderBean cifTransHolderBean){
		
		System.out.println(cifTransHolderBean.getMprdacctid());
		System.out.println(cifTransHolderBean.getMamt());

		try {
			if(cifTransHolderBean.getMamt() != 0 || cifTransHolderBean.getMprdacctid() != null) {
				System.out.println("prdaccid and amt both values are present");
				List<CIFTransactionHolderBean> beanList = cifTransactionServiceImpl.omniSoapServicesCifWithdrawalDetailList(cifTransHolderBean);
				return new ResponseEntity<List<CIFTransactionHolderBean>>(beanList,new HttpHeaders(),HttpStatus.OK);}
		}

		catch(Exception e) {
			return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

		return null;
		}
	
}
