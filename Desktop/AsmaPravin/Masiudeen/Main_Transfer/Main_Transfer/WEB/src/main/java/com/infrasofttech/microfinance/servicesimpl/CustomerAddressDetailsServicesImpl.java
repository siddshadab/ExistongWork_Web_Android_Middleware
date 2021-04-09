package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CustomerAddressDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerBorrowingDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerCompositePrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.repository.CustomerAddressDetailsRepository;
import com.infrasofttech.microfinance.repository.CustomerBorrowingDetailsRepository;
import com.infrasofttech.microfinance.repository.CustomerRepository;
import com.infrasofttech.microfinance.services.CustomerAddressDetailsServices;

@Service
public class CustomerAddressDetailsServicesImpl implements CustomerAddressDetailsServices{

	@Autowired
	CustomerAddressDetailsRepository customerAddressDetailsRepository;
	
	@Autowired
	CustomerRepository customerRepo;
	
	@Override
	public ResponseEntity<?> addList(CustomerAddressDetailsEntity customer) {
		// TODO Auto-generated method stub
		try {	 
			
			return new ResponseEntity<Object>(customerAddressDetailsRepository.save(customer),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Override
	public ResponseEntity<?> getAllCustomerAddressDetailsData() {
		try {
			List<CustomerAddressDetailsEntity> customerList=customerAddressDetailsRepository.findAll();
			if(customerList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CustomerAddressDetailsEntity>>(customerList,new HttpHeaders(),HttpStatus.OK);
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
	public ResponseEntity<?> addCustomerAddressDetails(@Valid List<CustomerAddressDetailsEntity> entityList, int mCustRefno) {
		customerAddressDetailsRepository.deleteExistingRecords(mCustRefno);
		CustomerEntity customerEntity = (CustomerEntity) customerRepo.findByMrefno(mCustRefno);		
		for(CustomerAddressDetailsEntity entity : entityList ) {			
			entity.setAddressDetailsCustomerEntity(customerEntity);	
			customerAddressDetailsRepository.save(entity);
		}
			
		return new ResponseEntity<List<CustomerAddressDetailsEntity>>(entityList,new HttpHeaders(),HttpStatus.CREATED);	
		
	}
	
}
