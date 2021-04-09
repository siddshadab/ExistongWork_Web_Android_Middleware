package com.infrasofttech.microfinance.repository;




import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.UserVaultBalanceEntity;


@Repository
public interface UserValutBalanceRepository extends JpaRepository<UserVaultBalanceEntity, String> {    
    
	@Query(value="select * from md011054 where musercode =?1",nativeQuery = true)
	public UserVaultBalanceEntity findByMusrcode(String musrcode);
	
	
	
	

}
