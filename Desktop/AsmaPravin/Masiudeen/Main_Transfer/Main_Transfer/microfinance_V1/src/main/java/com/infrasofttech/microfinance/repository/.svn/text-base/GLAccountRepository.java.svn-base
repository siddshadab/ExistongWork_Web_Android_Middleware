package com.infrasofttech.microfinance.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.infrasofttech.microfinance.entityBeans.master.GLAccountEntity;
import java.util.List;


@Repository
public interface GLAccountRepository extends JpaRepository<GLAccountEntity, Long> { 
	
	 @Query(value = "Select * from  glaccountmaster  WHERE mlbrcode= ?1",nativeQuery = true)
	 List<GLAccountEntity> findByMlbrCode(int mLbrcode);
	 
}
