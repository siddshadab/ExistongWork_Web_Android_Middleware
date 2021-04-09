package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CustomerBorrowingDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerCompositePrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerPPIDetailsEntity;
import com.infrasofttech.microfinance.repository.CustomerPPIDetailsRepository;
import com.infrasofttech.microfinance.repository.CustomerRepository;
import com.infrasofttech.microfinance.services.CustomerPPIDetailsService;
@Service
@Transactional
public class CustomerPPIDetailsServiceImpl implements CustomerPPIDetailsService {
	@Autowired
	CustomerPPIDetailsRepository customerPPIDetailsRepository;
	
	@Autowired
	CustomerRepository customerRepo;

	@Override
	public ResponseEntity<?> addPPIList(List<CustomerPPIDetailsEntity> customer) {
try {	 
			
			return new ResponseEntity<Object>(customerPPIDetailsRepository.saveAll(customer),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	

	@Override
	public ResponseEntity<?> getAllCustomerPPIData() {
		try {
			List<CustomerPPIDetailsEntity> customerList=customerPPIDetailsRepository.findAll();
			if(customerList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CustomerPPIDetailsEntity>>(customerList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

	}

	
	@Override
	public ResponseEntity<?> addPPIDetails(@Valid List<CustomerPPIDetailsEntity> entityList, int mCustRefno) {
		CustomerEntity customerEntity = (CustomerEntity) customerRepo.findByMrefno(mCustRefno);
		for(CustomerPPIDetailsEntity entity : entityList ) {
			entity.setPpiDetailsCustomerEntity(customerEntity);	
			//changesssss
			customerPPIDetailsRepository.save(entity);
		}
			
		return new ResponseEntity<List<CustomerPPIDetailsEntity>>(entityList,new HttpHeaders(),HttpStatus.CREATED);		
		
	}
	
}
