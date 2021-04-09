package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.CountriesEntity;
import com.infrasofttech.microfinance.entityBeans.StatesEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerBorrowingDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerCompositePrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerFamilyDetailsEntity;
import com.infrasofttech.microfinance.repository.CustomerBorrowingDetailsRepository;
import com.infrasofttech.microfinance.repository.CustomerRepository;
import com.infrasofttech.microfinance.services.CustomerBorrowingDetailsService;
@Service
@Transactional
public class CustomerBorrowingDetailsServiceImpl implements CustomerBorrowingDetailsService {

	
	
	@Autowired
	CustomerBorrowingDetailsRepository customerBorrowingDetailsRepository;
	
	@Autowired
	CustomerRepository customerRepo;
	
	@Override
	public ResponseEntity<?> addList(CustomerBorrowingDetailsEntity customer) {
		// TODO Auto-generated method stub
		try {	 
			
			return new ResponseEntity<Object>(customerBorrowingDetailsRepository.save(customer),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Override
	public ResponseEntity<?> getAllCustomerBorrowingData() {
		try {
			List<CustomerBorrowingDetailsEntity> customerList=customerBorrowingDetailsRepository.findAll();
			if(customerList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CustomerBorrowingDetailsEntity>>(customerList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

/*	@Override
	public ResponseEntity<?> getCustomerBorrowingByCustomerNo(Long custno) {
		try {
			List<CustomerBorrowingDetailsEntity> customer=customerBorrowingDetailsRepository.find(custno);
			if(customer.equals(null)) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CustomerBorrowingDetailsEntity>>(customer,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}*/
	
	@Override
	public ResponseEntity<?> addCustomerBorrowingDetails(@Valid List<CustomerBorrowingDetailsEntity> entityList, int  mCustRefno) {
		customerBorrowingDetailsRepository.deleteExistingRecords(mCustRefno);
		CustomerEntity customerEntity = (CustomerEntity) customerRepo.findByMrefno(mCustRefno);		
		for(CustomerBorrowingDetailsEntity entity : entityList ) {
			entity.setBorrowingDetailsCustomerEntity(customerEntity);	
			customerBorrowingDetailsRepository.save(entity);
		}
			
		return new ResponseEntity<List<CustomerBorrowingDetailsEntity>>(entityList,new HttpHeaders(),HttpStatus.CREATED);	
		
	}

}
