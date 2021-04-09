package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.master.ProductEntity;

public interface ProductRepository extends JpaRepository<ProductEntity, Long> {
	
	@Query(value="SELECT * FROM  md009021 where mlbrcode =?1",nativeQuery = true)
	public List<ProductEntity> findBymlbrcode(int mlbrcode);
	
	
	
	 }
