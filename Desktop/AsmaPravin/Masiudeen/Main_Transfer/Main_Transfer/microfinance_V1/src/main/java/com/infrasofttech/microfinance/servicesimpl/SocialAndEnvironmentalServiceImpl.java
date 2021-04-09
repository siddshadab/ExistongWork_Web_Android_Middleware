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
import com.infrasofttech.microfinance.entityBeans.master.DailyLoanCollectedEntity;
import com.infrasofttech.microfinance.entityBeans.master.SocialAndEnvironmentalEntity;
import com.infrasofttech.microfinance.repository.SocialAndEnvironmentalRepository;
import com.infrasofttech.microfinance.services.SocialAndEnvironmentalService;


@Service
@Transactional
public class SocialAndEnvironmentalServiceImpl implements SocialAndEnvironmentalService{

	@Autowired
	SocialAndEnvironmentalRepository repo;
	
	
	
	@Transactional
	@Override
		public ResponseEntity<?> addList(List<SocialAndEnvironmentalEntity> group) {

		try {
			return new ResponseEntity<Object>(repo.saveAll(group),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	@Transactional
	@Override
	public List<SocialAndEnvironmentalEntity> isDataSynced(int isDataSynced) {
		System.out.println("Inside is Data Synced");
		List<SocialAndEnvironmentalEntity> resultList = null;
		try {
			resultList = new ArrayList<SocialAndEnvironmentalEntity>();
			System.out.println("socialAndEnv" + resultList);
			resultList = repo.findDataByisDataSynced(isDataSynced);
			System.out.println("socialAndEnv" + resultList);

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
			System.out.print("Updated Social for leads id "+mleadsid+mloanmrefno+mloantrefno );
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Transactional
	public int updateStatusAndLeadid(int mrefno ,String mleadsid) {
		System.out.println("updateStatusAndLeadid social :" + mrefno +"::"+ mleadsid );
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
	public ResponseEntity<?> findByCreatedByAndLastSyncedTime(SocialAndEnvironmentalEntity socialEnvEntity) {
		 try{
			  List<SocialAndEnvironmentalEntity>socaialEnvList;
			 
			  
			  if(socialEnvEntity.getMlastsynsdate()==null ) {
				  
				  socaialEnvList =repo.findByCreatedby(socialEnvEntity.getMcreatedby());
				  
				  }
			  else {
				  
				  socaialEnvList=repo.findByCreatedbyAndDateTime(socialEnvEntity.getMcreatedby(), socialEnvEntity.getMlastsynsdate()); 
			  	}
			  	//manipulateSavingsEntity(savingsList);
	  
	  
	  if(socaialEnvList.isEmpty())	    
		  return ResponseEntity.notFound().build(); 
	      return  new ResponseEntity<List<SocialAndEnvironmentalEntity>>(socaialEnvList,new HttpHeaders(),HttpStatus.OK);	      
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
