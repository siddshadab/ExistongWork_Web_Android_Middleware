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
import com.infrasofttech.microfinance.entityBeans.master.DeviationFormEntity;
import com.infrasofttech.microfinance.entityBeans.master.SocialAndEnvironmentalEntity;
import com.infrasofttech.microfinance.repository.DeviationFormRepository;
import com.infrasofttech.microfinance.services.DeviationFormService;


@Service
@Transactional
public class DeviationFormServiceImpl implements DeviationFormService{

	@Autowired
	DeviationFormRepository repo;
	
	
	
	@Transactional
	@Override
		public ResponseEntity<?> addList(List<DeviationFormEntity> group) {

		try {
			return new ResponseEntity<Object>(repo.saveAll(group),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	@Transactional
	@Override
	public List<DeviationFormEntity> isDataSynced(int isDataSynced) {
		System.out.println("Inside is Data Synced");
		List<DeviationFormEntity> resultList = null;
		try {
			resultList = new ArrayList<DeviationFormEntity>();
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
			System.out.print("Updated Deviation for leads id "+mleadsid+mloanmrefno+mloantrefno );
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}

	@Transactional
	public int updateStatusAndLeadid(int mrefno ,String mleadsid) {
		System.out.println("updateStatusAndLeadid deviation:" + mrefno +"::"+ mleadsid );
		int isUpdated = 0;
		try {
			System.out.println("isUpdated" + isUpdated);
			isUpdated = repo.updateStatusAndLeadid(mrefno,mleadsid);

		} catch (Exception e) {
			return isUpdated;
		}
		return isUpdated;
	}

	@Override
	public ResponseEntity<?> findByCreatedByAndLastSyncedTime(DeviationFormEntity deviationEntity) {
		 try{
			  List<DeviationFormEntity>deviationList;
			 
			  
			  if(deviationEntity.getMlastsynsdate()==null ) {
				  
				  deviationList =repo.findByCreatedby(deviationEntity.getMcreatedby());
				  
				  }
			  else {
				  
				  deviationList=repo.findByCreatedbyAndDateTime(deviationEntity.getMcreatedby(), deviationEntity.getMlastsynsdate()); 
			  	}
			  	//manipulateSavingsEntity(savingsList);
	  
	  
	  if(deviationList.isEmpty())	    
		  return ResponseEntity.notFound().build(); 
	      return  new ResponseEntity<List<DeviationFormEntity>>(deviationList,new HttpHeaders(),HttpStatus.OK);	      
	    }
		 catch(Exception e) {
	 
		  return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY) ;
		  }	
	}

}
