package com.infrasofttech.microfinance.services;

import java.time.LocalDateTime;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;

public interface CustomerLoanService {

	
	
	public ResponseEntity<?> getAllCustomerLoanData();

	public ResponseEntity<?> getDataCustomerByLoanNo(Long loanNo);
	
	public List<CustomerLoanEntity> isDataSynced(int isDataSynced);
	
	public int updateCustomerLoan(long loanNumberOfTab,String LoanNumberOfCore);

	public 	ResponseEntity<?> addList(List<CustomerLoanEntity> customer);
	
	public int updateCustomerLoanAccountNumber( int mrefno,String loanAccountNumber) ;
	
	//public  int updateCustomerLoanLeadIdOfCoreByComposite( String loanAccountNumber,long loanNumberOfTab,long customerNumberOfTab,String usrCode);
	public int updateCustomerLoanLeadIdOfCore(String loanLeadId, int mrefno);
	
	public ResponseEntity<?> findByCreatedByOrRouteTo(String createdby,String routeto);
	
	public ResponseEntity<?> findByCreatedByOrMrouteToAndLastSyncedTime(CustomerLoanEntity customerLoanEntity);	

	
	public int updateErrorfromOmni(int mCustRefNo,String errorFromOmni,int mRetry);
	
	public int updateErrorfromOmni(int mCustRefNo,String errorFromOmni);
	
	public int updateCustomerInLoanDetails(int mCustRefNo,int customerNumberOfCore,LocalDateTime updatedDateTime) ;
	
	public int updateCustomerLoanLeadIdOfCore(String loanLeadId, int mrefno,int mRetry);
	
	public int updateCustomerLoanLeadIdAndPrdacctIdOfCore(String loanLeadId, String mprdacctid,int mrefno);
	
	public List<CustomerLoanEntity>  getLoanForBasicDetails();
	
	public List<CustomerLoanEntity> getLoanForFinalApproval();
	public CustomerLoanEntity getLoanWithMrefNo(int mrefno );
	
	public int updateIsDisbursed(String loanLeadId);
}
