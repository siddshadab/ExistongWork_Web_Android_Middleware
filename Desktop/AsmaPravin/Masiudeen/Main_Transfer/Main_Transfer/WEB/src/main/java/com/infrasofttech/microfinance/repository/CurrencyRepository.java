package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.CurrencyEntity;
@Repository
public interface CurrencyRepository extends JpaRepository<CurrencyEntity, Long>{

	@Query(value="select * from md001012",nativeQuery=true)
	List<CurrencyEntity> getAll();

}
