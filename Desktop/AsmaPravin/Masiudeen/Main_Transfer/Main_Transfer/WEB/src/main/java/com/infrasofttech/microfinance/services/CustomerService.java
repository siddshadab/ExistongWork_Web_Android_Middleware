package com.infrasofttech.microfinance.services;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CustomerDataholder;
import com.infrasofttech.microfinance.entityBeans.master.holder.CustomerHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.CustomerDedupHolder;





public interface CustomerService {
	
	
	
	public ResponseEntity<?> getAllCustomerData();

	public CustomerEntity getDataCustomerByCustomerNo(int custno);

	
	
	public List<CustomerEntity> isDataSynced(int  isDataSynced);
	public int updateCustomer(int mCustRefNo,int customerNumberOfCore,LocalDateTime updatedDateTime,int mcuststatus);

	ResponseEntity<?> addList(List<CustomerEntity> customer);
	CustomerEntity findByTrefAndMcreatedByAndIsSynced(int trefNo,String mCreatedBy , int mrefno,int isSynced);

	ResponseEntity<?> findByCreatedByAndLastSyncedTime(CustomerEntity customerEntity);

	ResponseEntity<List<CustomerEntity>> addCustomerListByHolder(List<CustomerHolderBean> customer);
	
	public int updateErrorfromOmni(int mCustRefNo,String errorFromOmni) ;
	
	 public ResponseEntity<?> getCustomerById(String mpanNoDesc,String midDesc);
	
	 ResponseEntity<?> findByCenterId(CustomerEntity customerEntity);
	 
	 public CustomerEntity getDataByMrefNo(int mrefNo);

	public void  getWholeEntity(CustomerEntity entity);
	
	public int updateErrorWithRetryFromOmni(int mCustRefNo,String errorFromOmni,int retry,int isSysncToCoreSys) ;
	
	public int updateGroupInCustomerDetails(int mrefno,int groupNumberOfCore,LocalDateTime updatedDateTime);
	
	public int updateCenterInCustomerDetails(int mrefno,int centerNumberOfCore,LocalDateTime updatedDateTime);
	
	
	public ResponseEntity<?> getFingerPrintByCustNo(int mcustno );

	
	public int   getCustomeNumberBymref(int mrefno);
	
	public ResponseEntity<CustomerEntity> getCustomerDedup(CustomerDedupHolder customerDedupHolder);

	public int updateCustStatusInCustomerDetails(int custno, int custStatus);
}
