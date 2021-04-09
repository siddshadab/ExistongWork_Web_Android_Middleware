package com.infrasofttech.microfinance.servicesimpl;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanCashFlowEntity;
import com.infrasofttech.microfinance.repository.CustomerLoanCashFlowRepository;
import com.infrasofttech.microfinance.services.CustomerLoanCashFlowServices;

@Service
@Transactional
public class CustomerLoanCashFlowServiceImpl implements CustomerLoanCashFlowServices {

	@Autowired
	CustomerLoanCashFlowRepository custLoanCashFlowRepo;

	@Transactional
	@Override
	public ResponseEntity<?> getAllCashFlowData() {
		try {
			List<CustomerLoanCashFlowEntity> customerLoanCashFlowList=custLoanCashFlowRepo.findAll();
			if(customerLoanCashFlowList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CustomerLoanCashFlowEntity>>(customerLoanCashFlowList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {			
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Transactional
	@Override
	public ResponseEntity<?> addList(List<CustomerLoanCashFlowEntity> cashFlowEntity) {
try {	 
	
	List<CustomerLoanCashFlowEntity> cashFlowAddList =new ArrayList<CustomerLoanCashFlowEntity>();
	for(CustomerLoanCashFlowEntity bean: cashFlowEntity) {

		if( bean.getMrefno()!=0) {
			System.out.println("getting Loan mrefno"+bean.getMrefno());
			CustomerLoanCashFlowEntity cashFlowBean = custLoanCashFlowRepo.findByMrefNo(bean.getMrefno());
			if(cashFlowBean!=null) {
				bean.setMissynctocoresys(cashFlowBean.getMissynctocoresys());
				if(cashFlowBean.getMleadsid() != null && !"".equals(cashFlowBean.getMleadsid())) {
				bean.setMleadsid(cashFlowBean.getMleadsid());	
				}
				
			}
		}else {
			bean.setMissynctocoresys(1);
		}

		cashFlowAddList.add(bean);
	}
			
			return new ResponseEntity<Object>(custLoanCashFlowRepo.saveAll(cashFlowEntity),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Override
	public List<CustomerLoanCashFlowEntity> isDataSynced(int isDataSyncToCoreSys) {
		// TODO Auto-generated method stub
		try {
			List<CustomerLoanCashFlowEntity> cashFlowList =  custLoanCashFlowRepo.findByIsDataSynced(isDataSyncToCoreSys);
			return cashFlowList;
		}
		catch(Exception e) {
			return null;
		}
		
		
	}

	@Override
	public void updatemisSynctocoreSys(int misSyncToCoreSys, int mrefno,String merrormessage) {
		// TODO Auto-generated method stub
		try {
			
			custLoanCashFlowRepo.updateMisSyncToCoresys(misSyncToCoreSys, mrefno,merrormessage);
		}catch(Exception e) {
			
			
		}
		
	}

	@Override
	public void updateMerrorMessage(int misSyncToCoreSys, int mrefno, String merrormessage) {
		// TODO Auto-generated method stub
		try {
			custLoanCashFlowRepo.updateErrorFromOmni(mrefno, merrormessage, misSyncToCoreSys);
		}catch(Exception e) {
			custLoanCashFlowRepo.updateErrorFromOmni(mrefno, merrormessage, misSyncToCoreSys);
			
		}
		
	}
	
	@Transactional
	@Override
	public ResponseEntity<?> findByCreatedByAndLastSyncedTime(CustomerLoanCashFlowEntity cashFlowEntity) {
		// TODO Auto-generated method stub
		 try {
			  List<CustomerLoanCashFlowEntity> returnedCashFlowEntity;
			  if(cashFlowEntity.getMlastsynsdate()==null ) {
				  returnedCashFlowEntity =custLoanCashFlowRepo.findByCreatedby(cashFlowEntity.getMcreatedby()); 
				  System.out.println("cashfloq created"+returnedCashFlowEntity);
				  }
			  else {
				  
				  returnedCashFlowEntity=custLoanCashFlowRepo.findByCreatedbyAndDateTime(cashFlowEntity.getMcreatedby(), cashFlowEntity.getMlastsynsdate());
				  System.out.println("mcreatedby and last"+returnedCashFlowEntity);
			  }
			  //manipulateSavingsEntity(savingsList);
			  
			  
			  if(returnedCashFlowEntity.isEmpty())
				  return ResponseEntity.notFound().build(); 
			      return new ResponseEntity<List<CustomerLoanCashFlowEntity>>(returnedCashFlowEntity,new HttpHeaders(),HttpStatus.OK);
			  
		    }catch(Exception e) {
			 // System.out.println("No Record Found. wasasas : "+e.getStackTrace());
			  //logger.error("No Record Found."+e.getMessage()); return new
				  return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY) ;}
	}

	@Override
	public void updateMleadsIdfromMrefTref(String mleadsid, int mloanmrefno, int mloantrefno) {
		try {
			custLoanCashFlowRepo.updateLeadsIdFromLoanMrefTref(mleadsid, mloanmrefno, mloantrefno,LocalDateTime.now());
			System.out.print("Updateed for leads id "+mleadsid+mloanmrefno+mloantrefno );
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Transactional
	public int updateStatusAndLeadid(int mrefno ,String mleadsid) {
		System.out.println("updateStatusAndLeadid cashflow :" + mrefno +"::"+ mleadsid );
		int isUpdated = 0;
		try {
			System.out.println("isUpdated" + isUpdated);
			isUpdated = custLoanCashFlowRepo.updateStatusAndLeadid(mrefno,mleadsid);

		} catch (Exception e) {
			return isUpdated;
		}
		return isUpdated;
	}
}
