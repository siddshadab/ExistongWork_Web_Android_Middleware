package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CentersFoundationEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProductEntity;
import com.infrasofttech.microfinance.repository.ProductRepository;
import com.infrasofttech.microfinance.services.ProductService;


@Service
@Transactional
public class ProductServiceImpl implements ProductService {


	@Autowired
	ProductRepository repo;


	@Transactional
	@Override
	public ResponseEntity<?> getAllProductData() {
		try {
			List<ProductEntity> productList=repo.findAll();
			if(productList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<ProductEntity>>(productList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Transactional
	@Override
	public ResponseEntity<?> getDataUserByLbrCode(int mlbrcode) {		
		try {

			List<ProductEntity> productList=repo.findBymlbrcode(mlbrcode);
			if(productList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<ProductEntity>>(productList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

	}

}
