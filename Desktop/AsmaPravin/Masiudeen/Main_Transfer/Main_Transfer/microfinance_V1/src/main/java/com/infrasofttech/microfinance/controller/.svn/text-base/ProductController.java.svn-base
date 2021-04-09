package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.CentersFoundationEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProductEntity;
import com.infrasofttech.microfinance.servicesimpl.ProductServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.TransactionModeServiceImpl;

@RestController
@RequestMapping("/productData")
public class ProductController {
	
	@Autowired
	ProductServiceImpl productService;
	
	
	@GetMapping(value = "/getlistOfproduct", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return productService.getAllProductData();
	}

	
	@PostMapping(value = "/getDataByLbrCode", produces = "application/json")
	public ResponseEntity<?>  getDataByAgentUserName(@RequestBody ProductEntity product){
		if(null != product) {
			return productService.getDataUserByLbrCode(product.getProductComposieEntity().getMlbrcode());
		}
		return null;
	}

}
