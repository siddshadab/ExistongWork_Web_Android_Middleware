package com.infrasofttech.microfinance.servicesimpl;
import java.util.List;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CustomerProductwiseCycleCompositeEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerProductwiseCycleEntity;
import com.infrasofttech.microfinance.repository.CustomerProductwiseCycleRepository;
import com.infrasofttech.microfinance.services.CustomerProductwiseCycleServices;

@Service
@Transactional
public class CustomerProductwiseCycleServicesImpl implements CustomerProductwiseCycleServices {

	@Autowired
	CustomerProductwiseCycleRepository repo;


	  @Transactional
	  
	  @Override 
	  public ResponseEntity<?> findByCreatedByAndLastSyncedTime(CustomerProductwiseCycleEntity customerProductwiseCycleEntity)
	  { 
		  try {
	  List<CustomerProductwiseCycleEntity> customerProductwiseCycleList;
	  if(customerProductwiseCycleEntity.getMlastsynsdate()==null ) {
		  customerProductwiseCycleList =repo.findByCreatedby(customerProductwiseCycleEntity.getMcreatedby()); 
		  }
	  else {
		  customerProductwiseCycleList=repo.findByCreatedbyAndDateTime(customerProductwiseCycleEntity.getMcreatedby(), customerProductwiseCycleEntity.getMlastsynsdate()); }
	  if(customerProductwiseCycleList.isEmpty())
	       return ResponseEntity.notFound().build(); 
	   return  new ResponseEntity<List<CustomerProductwiseCycleEntity>>(customerProductwiseCycleList,new HttpHeaders(),HttpStatus.OK); }
		  catch(Exception e) {

		  return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY) ;}
	  
	  }



		
	
	  

}
