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

import com.infrasofttech.microfinance.entityBeans.master.TradeAndNeighbourRefCheckEntity;
import com.infrasofttech.microfinance.repository.TradeAndNeighbourRefCheckRepository;
import com.infrasofttech.microfinance.services.TradeAndNeighbourRefCheckService;


@Service
@Transactional
public class TradeAndNeighbourRefCheckServiceImpl implements TradeAndNeighbourRefCheckService{

	@Autowired
	TradeAndNeighbourRefCheckRepository repo;
	
	
	
	@Transactional
	@Override
		public ResponseEntity<?> addList(List<TradeAndNeighbourRefCheckEntity> group) {

		try {
			return new ResponseEntity<Object>(repo.saveAll(group),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	@Transactional
	@Override
	public ResponseEntity<?> findByCreatedByAndLastSyncedTime(TradeAndNeighbourRefCheckEntity trcNrcEntity) {
		try{
			  List<TradeAndNeighbourRefCheckEntity> trcNrcList;
			 
			  
			  if(trcNrcEntity.getMlastsynsdate()==null ) {
				  
				  trcNrcList =repo.findByCreatedby(trcNrcEntity.getMcreatedby());
				  
				  }
			  else {
				  
				  trcNrcList=repo.findByCreatedbyAndDateTime(trcNrcEntity.getMcreatedby(), trcNrcEntity.getMlastsynsdate()); 
			  	}
			  	//manipulateSavingsEntity(savingsList);
	  
	  
	  if(trcNrcList.isEmpty())	    
		  return ResponseEntity.notFound().build(); 
	      return  new ResponseEntity<List<TradeAndNeighbourRefCheckEntity>>(trcNrcList,new HttpHeaders(),HttpStatus.OK);	      
	    }
		 catch(Exception e) {
	 
		  return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY) ;
		  }	
		
	}
	
	@Transactional
	@Override
	public List<TradeAndNeighbourRefCheckEntity> isDataSynced(int isDataSynced) {
		System.out.println("Inside is Data Synced");
		List<TradeAndNeighbourRefCheckEntity> resultList = null;
		try {
			resultList = new ArrayList<TradeAndNeighbourRefCheckEntity>();
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
			System.out.print("Updated Trade for leads id "+mleadsid+mloanmrefno+mloantrefno );
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}

	@Transactional
	public int updateStatusAndLeadid(int mrefno ,String mleadsid) {
		System.out.println("updateStatusAndLeadid trade:" + mrefno +"::"+ mleadsid );
		int isUpdated = 0;
		try {
			System.out.println("isUpdated" + isUpdated);
			isUpdated = repo.updateStatusAndLeadid(mrefno,mleadsid);

		} catch (Exception e) {
			return isUpdated;
		}
		return isUpdated;
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
