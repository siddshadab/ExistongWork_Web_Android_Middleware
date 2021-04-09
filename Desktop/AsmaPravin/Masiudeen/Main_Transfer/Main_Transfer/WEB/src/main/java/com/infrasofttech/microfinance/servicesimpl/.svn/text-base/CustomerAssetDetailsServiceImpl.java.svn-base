package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CustomerAssetDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.repository.CustomerAssetDetailsRepository;
import com.infrasofttech.microfinance.repository.CustomerRepository;
import com.infrasofttech.microfinance.services.CustomerAssetDetailsService;

@Service
@Transactional
public class CustomerAssetDetailsServiceImpl implements CustomerAssetDetailsService {
	@Autowired
	CustomerAssetDetailsRepository customerAssetDetailsRepository;
	
	@Autowired
	CustomerRepository customerRepo;

	@Override
	public ResponseEntity<?> addAssetList(List<CustomerAssetDetailsEntity> customer) {
	try {	 
				
				return new ResponseEntity<Object>(customerAssetDetailsRepository.saveAll(customer),new HttpHeaders(),HttpStatus.CREATED);
			} catch (Exception e) {
				//logger.error("Error While Persisting Object"+e.getMessage());
				return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
			}
		}
	

	@Override
	public ResponseEntity<?> getAllCustomerAssetData() {
		try {
			List<CustomerAssetDetailsEntity> customerList=customerAssetDetailsRepository.findAll();
			if(customerList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CustomerAssetDetailsEntity>>(customerList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

	}

	
	@Override
	public ResponseEntity<?> addAssetDetails(@Valid List<CustomerAssetDetailsEntity> entityList, int mCustRefno) {
		CustomerEntity customerEntity = (CustomerEntity) customerRepo.findByMrefno(mCustRefno);
		customerAssetDetailsRepository.deleteExistingRecords(mCustRefno);
		for(CustomerAssetDetailsEntity entity : entityList ) {
			entity.setAssetCustomerEntity(customerEntity);	
			customerAssetDetailsRepository.save(entity);	
			}			
		return new ResponseEntity<List<CustomerAssetDetailsEntity>>(entityList,new HttpHeaders(),HttpStatus.CREATED);	
	}
	
}
