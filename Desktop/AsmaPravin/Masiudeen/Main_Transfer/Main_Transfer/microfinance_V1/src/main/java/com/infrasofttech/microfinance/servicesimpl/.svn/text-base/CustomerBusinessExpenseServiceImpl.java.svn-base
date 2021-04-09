package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CustomerBusinessExpenseEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.repository.CustomerBusinessExpenseRepository;
import com.infrasofttech.microfinance.repository.CustomerRepository;
import com.infrasofttech.microfinance.services.CustomerBusinessExpenseService;
@Service
@Transactional
public class CustomerBusinessExpenseServiceImpl implements CustomerBusinessExpenseService {
	@Autowired
	CustomerBusinessExpenseRepository customerBusinessExpenseRepository;
	
	@Autowired
	CustomerRepository customerRepo;

	@Override
	public ResponseEntity<?> addBnExpenseList(List<CustomerBusinessExpenseEntity> customer) {
try {	 
			
			return new ResponseEntity<Object>(customerBusinessExpenseRepository.saveAll(customer),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	

	@Override
	public ResponseEntity<?> getAllCustomerBnExpenseData() {
		try {
			List<CustomerBusinessExpenseEntity> customerList=customerBusinessExpenseRepository.findAll();
			if(customerList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CustomerBusinessExpenseEntity>>(customerList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

	}

	
	@Override
	public ResponseEntity<?> addBnExpenseDetails(@Valid List<CustomerBusinessExpenseEntity> entityList, int mCustRefno) {
		CustomerEntity customerEntity = (CustomerEntity) customerRepo.findByMrefno(mCustRefno);
		customerBusinessExpenseRepository.deleteExistingRecords(mCustRefno);
		for(CustomerBusinessExpenseEntity entity : entityList ) {
			entity.setBusinessExpenseCustomerEntity(customerEntity);	
			customerBusinessExpenseRepository.save(entity);	
			}			
		return new ResponseEntity<List<CustomerBusinessExpenseEntity>>(entityList,new HttpHeaders(),HttpStatus.CREATED);		
		
	}
	
}
