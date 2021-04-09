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
import com.infrasofttech.microfinance.entityBeans.master.holder.CustAuthHolderBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.CIFLoanClosureSubmitServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.CustAuthViewServiceImpl;


@RestController
@RequestMapping("/custAuth")
public class CustAuthController {

	@Autowired
	CIFLoanClosureSubmitServiceImpl cifLoanClosureSubmitServiceImpl;
	@Autowired
	CustAuthViewServiceImpl custAuthViewServiceImpl;

	@PostMapping(value = "/getCustAuthDetail",produces = "application/json")
	public ResponseEntity<?> getCustAuthDetail(@RequestBody CustAuthHolderBean custAuthHolderBean){
		
		System.out.println(custAuthHolderBean.getMcustno());
		System.out.println(custAuthHolderBean.getMnid());
		
		try {
			if(custAuthHolderBean.getMcustno() != 0 || custAuthHolderBean.getMnid() != null) {
				System.out.println("valid custno or nid value");
				List<CustAuthHolderBean> beanList = custAuthViewServiceImpl.omniSoapServicesCustAuthDetailList(custAuthHolderBean);
				return new ResponseEntity<List<CustAuthHolderBean>>(beanList,new HttpHeaders(),HttpStatus.OK);}
		}

		catch(Exception e) {
			return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

		return null;
		}
	
}
