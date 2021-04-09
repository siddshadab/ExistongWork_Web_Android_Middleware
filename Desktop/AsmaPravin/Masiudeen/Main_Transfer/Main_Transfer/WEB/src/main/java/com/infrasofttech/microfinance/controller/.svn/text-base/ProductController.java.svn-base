package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.ProductComposieEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProductEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.ProductMasterHolder;
import com.infrasofttech.microfinance.services.ProductService;
import com.infrasofttech.microfinance.servicesimpl.ProductServiceImpl;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/productData")
public class ProductController {
	
	@Autowired
	ProductServiceImpl productService;
	
	@Autowired
	ProductService prdService;
	
	
	
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
	
	@PostMapping(value="/add" , produces="application/json")
	public ResponseEntity<?> addList(@RequestBody ProductEntity productEntity){
			System.out.println(productEntity);
			if(null != productEntity)
				return prdService.addList(productEntity);
			return null;
	}
	
	@PostMapping(value="/verifyPrdCd", produces="application/json")
	public ResponseEntity<?> verifyProduct(@RequestBody ProductComposieEntity productComposieEntity){
		
		if(null!= productComposieEntity)
			return prdService.verifyProduct(productComposieEntity);
		return null;
	}

	@PostMapping(value="/addPrd" , produces={ MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<?> addPrduct(@RequestBody ProductMasterHolder productHolder){
			System.out.println("xxxxxxxxxxxxxxxxxx"+productHolder);
			if(null != productHolder)
				return prdService.addPrd(productHolder);
			return null;
	}
	
	@PostMapping(value="/update" , produces={ MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<?> updatePrduct(@RequestBody ProductMasterHolder productHolder){
			System.out.println("xxxxxxxxxxxxxxxxxx"+productHolder);
			if(null != productHolder)
				return prdService.updatePrd(productHolder);
			return null;
	}
	
	@PostMapping(value="/delete", produces={ MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<?> deletePorduct(@RequestBody ProductMasterHolder productHolder){
		System.out.println("proxxxxxxxxxxxxxxx"+productHolder.getCode());
	
		if(null != productHolder)
			return prdService.deletePrd(productHolder.getCode());
		return null;
	}
	
	@GetMapping(value="/getPrdCdDesc",produces={ MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<?> getPrdCdDesc(){
		return prdService.getPrdCdDesc();
	}
	
	@PostMapping(value="/findByMlbrcode", produces={ MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<?> findByMlbrcode(@RequestBody ProductMasterHolder productHolder){
		if(productHolder !=null) {
			return prdService.findByMlbrcode(productHolder);
		
		}
		return null;
	}
	
}
