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

import com.infrasofttech.microfinance.entityBeans.master.KycMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsListEntity;
import com.infrasofttech.microfinance.repository.KycMasterRepository;
import com.infrasofttech.microfinance.services.KycMasterServices;

@Service
@Transactional
public class KycMasterServiceImpl implements KycMasterServices {

	@Autowired
	KycMasterRepository kycMasterRepository;

	@Autowired
	KycMasterRepository repo;
	
	@Transactional
	@Override
	public ResponseEntity<?> getAllKycMasterData() {
		try {
			List<KycMasterEntity> kycMasterList = kycMasterRepository.findAll();

			if (kycMasterList.isEmpty())
				return ResponseEntity.notFound().build();

			return new ResponseEntity<List<KycMasterEntity>>(kycMasterList, new HttpHeaders(), HttpStatus.OK);

		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Transactional
	@Override
	public ResponseEntity<?> addList(List<KycMasterEntity> kycMasterEntity) {
		try {
					
			return new ResponseEntity<Object>(kycMasterRepository.saveAll(kycMasterEntity), new HttpHeaders(),
					HttpStatus.CREATED);
		} catch (Exception e) {

			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);	            		      			
		}
	}   	

	@Override
	public List<KycMasterEntity> isDataSynced(int isDataSynced) {
		System.out.println("Inside is Data Synced");
		List<KycMasterEntity> kycEntity = null;
		try {

			kycEntity = new ArrayList<KycMasterEntity>();
		    kycEntity = kycMasterRepository.findByIsDataSynced(isDataSynced);
			System.out.println("Kyc master 1ist is " + kycEntity);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return kycEntity;
	}

	@Override
	public void updatemisSynctocoreSys(int misSyncToCoreSys, int mrefno) {
		
					
	}

	@Override
	public void updateMerrorMessage(int misSyncToCoreSys, int mrefno, String merrormessage) {

	}
	
	 @Transactional	  
	 @Override 
	  public ResponseEntity<?> findByCreatedByAndLastSyncedTime(KycMasterEntity kycMasterEntity)
	  { 
		 try{
			  List<KycMasterEntity> kycList;
			 
			  
			  if(kycMasterEntity.getMlastsynsdate()==null ) {
				  
				  kycList =repo.findByCreatedby(kycMasterEntity.getMcreatedby());
				  
				  }
			  else {
				  
				  kycList=repo.findByCreatedbyAndDateTime(kycMasterEntity.getMcreatedby(), kycMasterEntity.getMlastsynsdate()); 
			  	}
			  	//manipulateSavingsEntity(savingsList);
	  
	  
	  if(kycList.isEmpty())	    
		  return ResponseEntity.notFound().build(); 
	      return  new ResponseEntity<List<KycMasterEntity>>(kycList,new HttpHeaders(),HttpStatus.OK);	      
	    }
		 catch(Exception e) {
	 
		  return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY) ;
		  }	  
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
				System.out.print("Updateed for leads id "+mleadsid+mloanmrefno+mloantrefno );
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
		}

		@Transactional
		public int updateStatusAndLeadid(int mrefno ,String mleadsid) {
			System.out.println("updateStatusAndLeadid kyc :" + mrefno +"::"+ mleadsid );
			int isUpdated = 0;
			try {
				System.out.println("isUpdated" + isUpdated);
				isUpdated = repo.updateStatusAndLeadid(mrefno,mleadsid);

			} catch (Exception e) {
				return isUpdated;
			}
			return isUpdated;
		}
}
