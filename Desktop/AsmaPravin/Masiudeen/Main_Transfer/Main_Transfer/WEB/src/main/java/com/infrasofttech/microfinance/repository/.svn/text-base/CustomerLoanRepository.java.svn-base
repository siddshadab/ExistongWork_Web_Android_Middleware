package com.infrasofttech.microfinance.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanCompositePrimaryEntity;
import java.util.List;
import java.lang.String;
import java.time.LocalDateTime;

@Repository
public interface CustomerLoanRepository extends JpaRepository<CustomerLoanEntity,Long> {
	
	
	
	//List<CustomerLoanEntity> findByCompositeLoanId(LoanCompositePrimaryEntity compositeloanid);
	
	@Query(value="SELECT TOP 50 * FROM  md045011 WITH (NOLOCK) where missynctocoresys =?1 ",nativeQuery = true)
	List<CustomerLoanEntity> findByIsDataSynced(int isdatasynced);
	
	
	/*@Modifying
    @Query(value = "UPDATE md045011 SET loan_number_of_core = ?2 ,missynctocoresys =1 WHERE loan_number_of_tab = ?1",nativeQuery = true)
    int updateCustomerLoan( long customerNumberOfTab, String loanNumberOfCore);*/
	
	/*@Modifying
    @Query(value = "UPDATE md045011 SET loan_Account_Number_Of_Core = ?1 ,missynctocoresys =3  WHERE loan_number_of_tab = ?2 AND customer_number_of_tab=?3 AND usr_code =?4",nativeQuery = true)
    int updateCustomerLoanAccountNumberOfCoreByComposite( String loanAccountNumberOfCore,long loanNumberOfTab,long customerNumberOfTab,String usrCode);
	*/
	@Modifying
    @Query(value = "UPDATE md045011 SET mprdacctid = ?2 ,mlastupdatedt =?3, missynctocoresys=3 WHERE mrefno = ?1  ",nativeQuery = true)
    int updateCustomerLoanAccountNumber( int mLoanRefNo, String mprdacctid,LocalDateTime updatedDt);
	
	//update missymc to 1 after looking at logic
	@Modifying
    @Query(value = "UPDATE md045011 SET mleadsid = ?2 ,mlastupdatedt =?3, missynctocoresys=2 WHERE mrefno = ?1  ",nativeQuery = true)
    int updateCustomerLoanLeadId( int mLoanRefNo, String mleadsid,LocalDateTime updatedDt);
	
	@Modifying
    @Query(value = "UPDATE md045011 SET merrormessage = ?2,mlastupdatedt =?3  WHERE mrefno = ?1  ",nativeQuery = true)
    int updateErrorFromOmni( int mCustRefNo, String updateErrorFromOmni,LocalDateTime updatedDt);
	
	@Modifying
    @Query(value = "UPDATE md045011 SET merrormessage = ?2,mlastupdatedt =?3,mretry =?4,   WHERE mrefno = ?1  ",nativeQuery = true)
    int updateErrorFromOmni( int mCustRefNo, String updateErrorFromOmni,LocalDateTime updatedDt,int mRetry);

	
	
	
	@Modifying
    @Query(value = "UPDATE md045011 SET mleadsid = ?2 ,mlastupdatedt =?3,mretry =?4, missynctocoresys=2 WHERE mrefno = ?1  ",nativeQuery = true)
    int updateCustomerLoanLeadId( int mLoanRefNo, String mleadsid,LocalDateTime updatedDt,int mRetry);
	
	
	@Query(value="SELECT * FROM  md045011  WITH (NOLOCK) where (mcreatedby=?1 OR mrouteto=?1) AND mlastupdatedt > ?2",nativeQuery = true)
	List<CustomerLoanEntity> findByCreatedbyAndDateTime(String mcreatedby,LocalDateTime lastsynsdate);

	
	@Query(value="SELECT  * FROM  md045011  WITH (NOLOCK) where (mcreatedby=?1  OR mrouteto=?1)  order BY mlastupdatedt  desc",nativeQuery = true)
	List<CustomerLoanEntity> findByCreatedby(String mcreatedby);
	
	
	List<CustomerLoanEntity> findByMcreatedbyAndMrouteto(String mcreatedby , String mrouteto);
	
	@Modifying
    @Query(value = "UPDATE md045011 SET mcustno = ?2 ,mlastupdatedt =?3, missynctocoresys=1 WHERE mcustmrefno = ?1  ",nativeQuery = true)
    int updateCustomerInLoanDetails( int mrefno, int customerNumberOfCore,LocalDateTime updatedDt);
	
	
	
	@Query(value="SELECT TOP 50 * FROM  md045011 WITH (NOLOCK) where missynctocoresys = 0  AND  mleadstatus <> 99 AND (merrormessage = '' OR merrormessage is NULL)",nativeQuery = true)
	List<CustomerLoanEntity> findLoanBasicDetails();
	
	
	@Query(value="SELECT TOP 50 * FROM  md045011  WITH (NOLOCK) where missynctocoresys = 2  and (mleadsid <> '' OR  mleadsid IS NOT NULL )",nativeQuery = true)
	List<CustomerLoanEntity> findLoanFinalDetails();
	
	@Query(value="SELECT  * FROM  md045011 WITH (NOLOCK) where mrefno =?1 ",nativeQuery = true)
	CustomerLoanEntity findBymrefno(int mrefno);
	
	
	@Query(value="SELECT * FROM  md045011 WITH (NOLOCK) where mrefno =?1 ",nativeQuery = true)
	 CustomerLoanEntity findByMrefNo(int mrefno);
	
	
	
	/*
	@Modifying
    @Query(value = "UPDATE md045011 SET mcustno = ?2 ,mlastupdatedt =?3, missynctocoresys=1 WHERE mcustmrefno = ?1  ",nativeQuery = true)
    int updateCustomerInLoanDetails( int mrefno, int customerNumberOfCore,LocalDateTime updatedDt);
    */
	
}
