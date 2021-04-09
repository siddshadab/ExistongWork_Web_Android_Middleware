package com.infrasofttech.microfinance.controller;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.DisbursedListEntity;
import com.infrasofttech.microfinance.entityBeans.master.DisbursmentListEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.DisbursmentHolderBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.CIFCustAuthServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.CIFDisbursmentServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.CIFServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.OmniDisbursedListAuthorizationServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.OmniDisbursedListServiceImpl;


@RestController
@RequestMapping("/CIF")
public class CIFController {

	@Autowired
	CIFServiceImpl cifServiceImpl;
	@Autowired
	CIFCustAuthServiceImpl cifCustAuthServiceImpl;	
	@Autowired
	CIFDisbursmentServiceImpl cifDisbursmentServiceImpl;
	
	@Autowired
	OmniDisbursedListServiceImpl omniDisbursedListImpl;
	
	@Autowired
	OmniDisbursedListAuthorizationServiceImpl omniDisbursedAuthListImpl;
	

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
	
	
	
	
	
	
	@PostMapping(value = "/getDisbursmentDetails/",produces = "application/json")
	public ResponseEntity<?> getDisbursmentDetails(@RequestBody CIFHolderBean cifHolderBean){
		System.out.println("Getting Disbursment Details");
		System.out.println(cifHolderBean.getMcustno());
		System.out.println(cifHolderBean.getMlbrcode());

		try {
			if(cifHolderBean.getMlbrcode() != 0&&!("").equals(cifHolderBean.getMprdacctid())) {
				DisbursmentListEntity beanList = cifDisbursmentServiceImpl.getDisbursmentDetails(cifHolderBean);
				System.out.println("Returning Bean "+ beanList);
				return new ResponseEntity<DisbursmentListEntity>(beanList,new HttpHeaders(),HttpStatus.CREATED);}
		}

		catch(Exception e) {
			return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

		return null;
		}
	
	
	
	@PostMapping(value = "/postDisbursmentCreate/",produces = "application/json")
	public ResponseEntity<?> disbursmentCreate(@RequestBody DisbursedListEntity disbBean){
		System.out.println("postinhg Disbursment Create");

		try {
			if(disbBean!=null) {
				List<DisbursedListEntity> ListDisbEntity  =new ArrayList<DisbursedListEntity>();
				ListDisbEntity.add(disbBean);
				 omniDisbursedListImpl.omniSoapServicesDisbursedList(ListDisbEntity,true);
				 //System.out.println(ListDisbEntity.get(0));
				 //System.out.println("Returning "+ ListDisbEntity.get(0).getMissynctocoresys());
				//DisbursmentHolderBean beanList = cifDisbursmentServiceImpl.getDisbursmentDetails(cifHolderBean);
				return new ResponseEntity<DisbursedListEntity>(ListDisbEntity.get(0),new HttpHeaders(),HttpStatus.OK);}
		}

		catch(Exception e) {
			return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

		return null;
		}
	
	
	
	
	@PostMapping(value = "/postDisbursmentAuth/",produces = "application/json")
	public ResponseEntity<?> disbursmentAuthorize(@RequestBody DisbursedListEntity disbBean){
		System.out.println("postinhg Disbursment Authorize");

		try {
			if(disbBean!=null) {
				//System.out.println("custno is present");
				List<DisbursedListEntity> ListDisbEntity  =new ArrayList<DisbursedListEntity>();
				ListDisbEntity.add(disbBean);
				omniDisbursedAuthListImpl.omniSoapServicesDisbursedList(ListDisbEntity,true);
				//System.out.println("Returning "+ ListDisbEntity.get(0).getMissynctocoresys());
				//DisbursmentHolderBean beanList = cifDisbursmentServiceImpl.getDisbursmentDetails(cifHolderBean);
				return new ResponseEntity<DisbursedListEntity>(ListDisbEntity.get(0),new HttpHeaders(),HttpStatus.OK);}
		}

		catch(Exception e) {
			return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

		return null;
		}
	
	
}
