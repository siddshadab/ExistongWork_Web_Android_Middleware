package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.ProductComposieEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProductEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.ProductMasterHolder;

public interface ProductService {
	
	public ResponseEntity<?> getAllProductData();
	public ResponseEntity<?> getDataUserByLbrCode(int lbrCode);
	public ResponseEntity<?> addList(ProductEntity productEntity);
	public ResponseEntity<?> verifyProduct(ProductComposieEntity productComposieEntity);
	
	public ResponseEntity<?> addPrd(ProductMasterHolder productHodler);
	public ResponseEntity<?> updatePrd(ProductMasterHolder productHodler);
	public ResponseEntity<?> deletePrd(List<ProductMasterHolder> code);
	
	public ResponseEntity<?> getPrdCdDesc();
	
	public ResponseEntity<?> findByMlbrcode(ProductMasterHolder productHodler);
	
}
