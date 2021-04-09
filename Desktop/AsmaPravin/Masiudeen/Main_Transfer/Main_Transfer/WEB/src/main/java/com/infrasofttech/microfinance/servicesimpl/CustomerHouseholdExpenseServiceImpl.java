package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerHouseholdExpenseEntity;
import com.infrasofttech.microfinance.repository.CustomerHouseholdExpenseRepository;
import com.infrasofttech.microfinance.repository.CustomerRepository;
import com.infrasofttech.microfinance.services.CustomerHouseholdExpenseService;
@Service
@Transactional
public class CustomerHouseholdExpenseServiceImpl implements CustomerHouseholdExpenseService {
	@Autowired
	CustomerHouseholdExpenseRepository customerHouseholdExpenseRepository;
	
	@Autowired
	CustomerRepository customerRepo;

	@Override
	public ResponseEntity<?> addHhExpenseList(List<CustomerHouseholdExpenseEntity> customer) {
try {	 
			
			return new ResponseEntity<Object>(customerHouseholdExpenseRepository.saveAll(customer),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	

	@Override
	public ResponseEntity<?> getAllCustomerHhExpenseData() {
		try {
			List<CustomerHouseholdExpenseEntity> customerList=customerHouseholdExpenseRepository.findAll();
			if(customerList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CustomerHouseholdExpenseEntity>>(customerList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

	}

	
	@Override
	public ResponseEntity<?> addHhExpenseDetails(@Valid List<CustomerHouseholdExpenseEntity> entityList, int mCustRefno) {
		CustomerEntity customerEntity = (CustomerEntity) customerRepo.findByMrefno(mCustRefno);
		customerHouseholdExpenseRepository.deleteExistingRecords(mCustRefno);
		for(CustomerHouseholdExpenseEntity entity : entityList ) {
			entity.setHouseholdExpenseCustomerEntity(customerEntity);	
			customerHouseholdExpenseRepository.save(entity);	
			}			
		return new ResponseEntity<List<CustomerHouseholdExpenseEntity>>(entityList,new HttpHeaders(),HttpStatus.CREATED);		
		
	}
	
}
