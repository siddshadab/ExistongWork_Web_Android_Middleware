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
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.CIFCustAuthServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.CIFServiceImpl;


@RestController
@RequestMapping("/CIF")
public class CIFController {

	@Autowired
	CIFServiceImpl cifServiceImpl;
	@Autowired
	CIFCustAuthServiceImpl cifCustAuthServiceImpl;	
	

	@PostMapping(value = "/getCifDetails/",produces = "application/json")
	public ResponseEntity<?> getCifDetailList(@RequestBody CIFHolderBean cifHolderBean){
		
		System.out.println(cifHolderBean.getMcustno());
		System.out.println(cifHolderBean.getMnid());

		try {
			if(cifHolderBean.getMcustno() != 0 || cifHolderBean.getMnid() != null) {
				System.out.println("either custno or nid value is present");
				List<CIFHolderBean> beanList = cifServiceImpl.omniSoapServicesCifDetailList(cifHolderBean);
				return new ResponseEntity<List<CIFHolderBean>>(beanList,new HttpHeaders(),HttpStatus.OK);}
		}

		catch(Exception e) {
			return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

		return null;
		}
	
	
	@PostMapping(value = "/postCIFCustAuthorizationToOmni/",produces = "application/json")
	public ResponseEntity<?> postCIFCustAuthorizationToOmni(@RequestBody CIFHolderBean cifHolderBean){
		
		System.out.println(cifHolderBean.getMcustno());

		try {
			if(cifHolderBean.getMcustno() != 0 ) {
				System.out.println("custno is present");
				List<CIFHolderBean> beanList = cifCustAuthServiceImpl.omniSoapServicesCifCustAuth(cifHolderBean);
				return new ResponseEntity<List<CIFHolderBean>>(beanList,new HttpHeaders(),HttpStatus.OK);}
		}

		catch(Exception e) {
			return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

		return null;
		}
	
}
