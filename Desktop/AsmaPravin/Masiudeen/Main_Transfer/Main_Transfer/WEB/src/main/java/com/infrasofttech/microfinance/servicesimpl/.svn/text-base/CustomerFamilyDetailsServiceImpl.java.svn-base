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
import com.infrasofttech.microfinance.entityBeans.master.CustomerFamilyDetailsEntity;
import com.infrasofttech.microfinance.repository.CustomerFamilyDetailsRepository;
import com.infrasofttech.microfinance.repository.CustomerRepository;
import com.infrasofttech.microfinance.services.CustomerFamilyDetailsService;
@Service
@Transactional
public class CustomerFamilyDetailsServiceImpl implements CustomerFamilyDetailsService {
	@Autowired
	CustomerFamilyDetailsRepository customerFamilyDetailsRepository;
	
	@Autowired
	CustomerRepository customerRepo;

	@Override
	public ResponseEntity<?> addFamilyList(List<CustomerFamilyDetailsEntity> customer) {
try {	 
			
			return new ResponseEntity<Object>(customerFamilyDetailsRepository.saveAll(customer),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	

	@Override
	public ResponseEntity<?> getAllCustomerFamilyData() {
		try {
			List<CustomerFamilyDetailsEntity> customerList=customerFamilyDetailsRepository.findAll();
			if(customerList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CustomerFamilyDetailsEntity>>(customerList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

	}

	
	@Override
	public ResponseEntity<?> addFamilyDetails(@Valid List<CustomerFamilyDetailsEntity> entityList, int mCustRefno) {
		CustomerEntity customerEntity = (CustomerEntity) customerRepo.findByMrefno(mCustRefno);
		customerFamilyDetailsRepository.deleteExistingRecords(mCustRefno);
		for(CustomerFamilyDetailsEntity entity : entityList ) {
			entity.setFamilyDetailsCustomerEntity(customerEntity);	
			customerFamilyDetailsRepository.save(entity);	
			}			
		return new ResponseEntity<List<CustomerFamilyDetailsEntity>>(entityList,new HttpHeaders(),HttpStatus.CREATED);		
		
	}
	
}
