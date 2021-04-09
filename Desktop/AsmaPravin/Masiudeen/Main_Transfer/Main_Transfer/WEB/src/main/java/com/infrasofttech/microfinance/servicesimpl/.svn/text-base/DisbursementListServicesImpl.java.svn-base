package com.infrasofttech.microfinance.servicesimpl;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.DisbursmentListEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsListEntity;
import com.infrasofttech.microfinance.repository.DisbursmentListRepository;
import com.infrasofttech.microfinance.repository.SavingsListRepository;
import com.infrasofttech.microfinance.services.DisbursmentListServices;
import com.infrasofttech.microfinance.services.SavingsListServices;

@Service
@Transactional
public class DisbursementListServicesImpl implements DisbursmentListServices {

	@Autowired
	DisbursmentListRepository dsbrsrepo;

	@Transactional
	@Override
	public ResponseEntity<?> addList(List<DisbursmentListEntity> dsbrs) {

		System.out.println("dsbrs::::::::::::::::::::::::::"+dsbrs.toString());
		for(DisbursmentListEntity obj : dsbrs){
			System.out.println("dsbrs::::::::::::::::::::::::::"+obj.getMrefno());
			System.out.println("dsbrs::::::::::::::::::::::::::"+obj.getTrefno());
			}
		

			return new ResponseEntity<Object>(dsbrsrepo.saveAll(dsbrs), new HttpHeaders(), HttpStatus.CREATED);
	

	}



	
	  @Transactional
	  @Override 
	  public ResponseEntity<?> findByCreatedByAndLastSyncedTime(DisbursmentListEntity disbursmentListEntity)
	  { 
		  try {
			  System.out.println("Service impl k andar");
	  List<DisbursmentListEntity> disbursmentList;
	  if(disbursmentListEntity.getMlastsynsdate()==null ) {
		  disbursmentList =dsbrsrepo.findByCreatedby(disbursmentListEntity.getMcreatedby()); 
		  }
	  else {
		  disbursmentList=dsbrsrepo.findByCreatedbyAndDateTime(disbursmentListEntity.getMcreatedby(), disbursmentListEntity.getMlastsynsdate()); }
	  //manipulateSavingsEntity(savingsList);
	  
	  
	  if(disbursmentList.isEmpty())
	return ResponseEntity.notFound().build(); 
	  return  new ResponseEntity<List<DisbursmentListEntity>>(disbursmentList,new HttpHeaders(),HttpStatus.OK); }
		  
		  catch(Exception e) {
	 // System.out.println("No Record Found. wasasas : "+e.getStackTrace());
	  //logger.error("No Record Found."+e.getMessage()); return new
		  return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY) ;}
	  
	  }
		
	 

}
