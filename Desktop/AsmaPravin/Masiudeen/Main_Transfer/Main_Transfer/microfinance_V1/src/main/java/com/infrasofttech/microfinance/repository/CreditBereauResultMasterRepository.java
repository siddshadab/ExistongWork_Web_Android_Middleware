package com.infrasofttech.microfinance.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.CreditBereauResultMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProspectCompositePrimaryEntityAdhaar;
import java.util.List;

@Repository
public interface CreditBereauResultMasterRepository extends JpaRepository<CreditBereauResultMasterEntity,Long> {
	
	
	
	
	@Query(value="SELECT * FROM  Credit_Bereau_Result_Master where adhaar_No =?1 AND agentUserName = ?2",nativeQuery = true)
	CreditBereauResultMasterEntity findByAdhaarNoAndAgentUserName(Long adhaarNo,String agentUserName);
	
	
	@Query(value="SELECT * FROM  Credit_Bereau_Result_Master routed_to = ?1",nativeQuery = true)
	List<CreditBereauResultMasterEntity> findByRoutedTo(String agentUserName);
	
	
	
	@Modifying
	@Query(value="Delete  FROM  cbresultmaster where mrefno =?1",nativeQuery = true)
	void deleteExistingRecords(int mrefNo);
	
	
	@Modifying
	@Query(value="update  cbresultmaster set mexpsramt=?1 where mrefno =?2",nativeQuery = true)
	void updateExposureAmt(double mexpstAmt,int mrefNo);

}
