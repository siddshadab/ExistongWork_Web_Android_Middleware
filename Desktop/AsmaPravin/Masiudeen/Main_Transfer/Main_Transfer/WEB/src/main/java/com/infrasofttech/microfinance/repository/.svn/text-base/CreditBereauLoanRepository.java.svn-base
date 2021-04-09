package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.CreditBereauLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanCompositePrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProspectCompositeLoanEntity;

@Repository
public interface CreditBereauLoanRepository extends JpaRepository<CreditBereauLoanEntity,Long> {
	
/*List<CustomerLoanEntity> findByCompositeLoanId(LoanCompositePrimaryEntity compositeloanid);
	

	@Query(value="SELECT * FROM  customer_Loan_Master where is_data_synced_to_core_system =?1",nativeQuery = true)
	List<CustomerLoanEntity> findByisDatasyncedToCoreSystem(int isdatasyncedtocorseystem);
	
	@Modifying
    @Query(value = "UPDATE customer_Loan_Master SET loan_number_of_core = ?2 ,is_data_synced_to_core_system=1 WHERE loan_number_of_tab = ?1",nativeQuery = true)
    int updateCustomerLoan( long customerNumberOfTab, String loanNumberOfCore);
	
	@Modifying
    @Query(value = "UPDATE customer_Loan_Master SET customer_number_of_core = ?1 WHERE loan_number_of_tab = ?2 AND customer_number_of_tab=?3 AND usr_code =?4",nativeQuery = true)
    int updateCustomerLoanByComposite( String CustomerNoOfCore,long loanNumberOfTab,long customerNumberOfTab,String usrCode);*/
	
	
	
	
	@Modifying
	@Query(value="Delete  FROM  cbresultdetails where mrefno =?1",nativeQuery = true)
	void deleteExistingRecords(int mrefNo);

	
	@Modifying
	@Query(value="UPDATE cbresultdetails  SET mnocimagestring = ?2 WHERE mrefsrno = ?1 ",nativeQuery = true)
    int updateNocImageString(int mrefsrNo,byte[] mnocimagestring);
	
	
	
}
