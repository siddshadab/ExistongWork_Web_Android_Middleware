package com.infrasofttech.microfinance.servicesimpl;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import javax.transaction.Transactional;
import org.springframework.http.ResponseEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanCPVBusinessRecordEntity;
import com.infrasofttech.microfinance.entityBeans.master.KycMasterEntity;
import com.infrasofttech.microfinance.repository.CustomerLoanCPVBusinessRecordRepository;
import com.infrasofttech.microfinance.services.CustomerLoanCPVBusinessRecordService;


@Service
@Transactional
public class CustomerLoanCPVBusinessRecordServiceImpl implements CustomerLoanCPVBusinessRecordService{

	@Autowired
	CustomerLoanCPVBusinessRecordRepository repo;
	
	
	
	@Transactional
	@Override
		public ResponseEntity<?> addList(List<CustomerLoanCPVBusinessRecordEntity> group) {

		System.out.println(group);
		List<CustomerLoanCPVBusinessRecordEntity> returningList = new ArrayList<CustomerLoanCPVBusinessRecordEntity>();
		for(int i = 0;i<group.size();i++) {
			try {
				CustomerLoanCPVBusinessRecordEntity retEntity = 	repo.save(group.get(i));
				returningList.add(retEntity);
				
			}catch(Exception e) {
				
			}
			
		}
		
		try {
			return new ResponseEntity<Object>(returningList,new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	@Transactional
	@Override
	public List<CustomerLoanCPVBusinessRecordEntity> isDataSynced(int isDataSynced) {
		System.out.println("Inside is Data Synced");
		List<CustomerLoanCPVBusinessRecordEntity> resultList = null;
		try {
			resultList = new ArrayList<CustomerLoanCPVBusinessRecordEntity>();
			resultList = repo.findDataByisDataSynced(isDataSynced);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultList;
	}
	
	@Transactional
	public int updateStatus(int mrefno) {
		int isUpdated = 0;
		try {
			System.out.println("isUpdated" + isUpdated);
			isUpdated = repo.updateStatus(mrefno);

		} catch (Exception e) {
			return isUpdated;
		}
		return isUpdated;
	}
	
	@Transactional
	public int updateErrorStatus(int mrefno , String merrormessage) {
		int isUpdated = 0;
		try {
			System.out.println("isUpdated" + isUpdated);
			isUpdated = repo.updateErrorStatus(mrefno,merrormessage);

		} catch (Exception e) {
			return isUpdated;
		}
		return isUpdated;
	}
	
	@Override
	public void updateMleadsIdfromMrefTref(String mleadsid, int mloanmrefno, int mloantrefno) {
		try {
			repo.updateLeadsIdFromLoanMrefTref(mleadsid, mloanmrefno, mloantrefno,LocalDateTime.now());
			System.out.print("Updated CPV for leads id "+mleadsid+mloanmrefno+mloantrefno );
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}

	@Transactional
	public int updateStatusAndLeadid(int mrefno ,String mleadsid) {
		System.out.println("updateStatusAndLeadid cpv :" + mrefno +"::"+ mleadsid );
		int isUpdated = 0;
		try {
			System.out.println("isUpdated" + isUpdated);
			isUpdated = repo.updateStatusAndLeadid(mrefno,mleadsid);

		} catch (Exception e) {
			return isUpdated;
		}
		return isUpdated;
	}

	@Transactional
	@Override
	public ResponseEntity<?> findByCreatedByAndLastSyncedTime(CustomerLoanCPVBusinessRecordEntity cpvEntity) {
		 try{
			  List<CustomerLoanCPVBusinessRecordEntity>cpvList;
			 
			  
			  if(cpvEntity.getMlastsynsdate()==null ) {
				  
				  cpvList =repo.findByCreatedby(cpvEntity.getMcreatedby());
				  
				  }
			  else {
				  
				  cpvList=repo.findByCreatedbyAndDateTime(cpvEntity.getMcreatedby(), cpvEntity.getMlastsynsdate()); 
			  	}
			  	//manipulateSavingsEntity(savingsList);
	  
	  
	  if(cpvList.isEmpty())	    
		  return ResponseEntity.notFound().build(); 
	      return  new ResponseEntity<List<CustomerLoanCPVBusinessRecordEntity>>(cpvList,new HttpHeaders(),HttpStatus.OK);	      
	    }
		 catch(Exception e) {
	 
		  return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY) ;
		  }	 
	}
	
	
	public void updateErrorfromMrefTref(String merrormessage, int mloanmrefno, int mloantrefno) {
		try {
			repo.updateErrorFromLoanMrefTref(merrormessage, mloanmrefno, mloantrefno,LocalDateTime.now());
			System.out.print("Updateed errormessage "+merrormessage+mloanmrefno+mloantrefno );
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	

}
