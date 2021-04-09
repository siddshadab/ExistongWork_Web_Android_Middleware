package com.infrasofttech.microfinance.servicesimpl;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.controller.SavingsListController;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsListEntity;

import com.infrasofttech.microfinance.repository.SavingsListRepository;
import com.infrasofttech.microfinance.services.SavingsListServices;

@Service
@Transactional
public class SavingsListServicesImpl implements SavingsListServices {

	@Autowired
	SavingsListRepository repo;
	

	@Transactional
	@Override
	public ResponseEntity<?> addList(List<SavingsListEntity> svng) {

		System.out.println("svng::::::::::::::::::::::::::"+svng.toString());
		for(SavingsListEntity obj : svng){
			System.out.println("svng::::::::::::::::::::::::::"+obj.getMrefno());
			System.out.println("svng::::::::::::::::::::::::::"+obj.getTrefno());
			}
		

			return new ResponseEntity<Object>(repo.saveAll(svng), new HttpHeaders(), HttpStatus.CREATED);
	

	}

	@Transactional
	@Override
	public List<SavingsListEntity> isDataSynced(int isDataSynced) {
		System.out.println("Inside is Data Synced");
		List<SavingsListEntity> savinglist = null;
		try {
			// System.out.println(isDataSyncedToCoreSystem);
			savinglist = new ArrayList<SavingsListEntity>();
			System.out.println("savinglist" + savinglist);
			savinglist = repo.findDataByisDataSynced(isDataSynced);
			System.out.println("savinglist1" + savinglist);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return savinglist;
	}

	@Transactional
	public int updateSavingsList(int mrefno, String mprdaccid, String mcrs,LocalDateTime lastSynsdate) {
		System.out.println("Inside Update Savings List");
		int isSavingsListUpdated = 0;
		try {
			System.out.println("isSavingsListUpdated" + isSavingsListUpdated);
			isSavingsListUpdated = repo.updateSavingsList(mrefno, mprdaccid, mcrs,lastSynsdate);

		} catch (Exception e) {
			System.out.println("dhsgfvccdcjdj");
			// logger.error("No Record Found."+e.getMessage());
			return isSavingsListUpdated;
		}
		return isSavingsListUpdated;
	}

	@Transactional
	@Override
	public int updateSavingsErrorfromOmni(int mCustRefNo, String errorFromOmni, LocalDateTime lastSynsdate) {
		System.out.println("Sai m aaya");
		int isSavingsListUpdated = 0;
		try { 
			System.out.println("Try Me");
			isSavingsListUpdated = repo.updateSavingsLastErrorfromOmni(mCustRefNo, errorFromOmni, lastSynsdate);

		} catch (Exception e) {
			// logger.error("No Record Found."+e.getMessage());
			return isSavingsListUpdated;
		}
		return isSavingsListUpdated;
	}
	
	@Transactional
	@Override
	public int updateSavingsErrorfromOmni(int mCustRefNo, String errorFromOmni,int mretry) {
		System.out.println("Meko Error :(");
		int isSavingsListUpdated = 0;
		try { 
			System.out.println("retry value hai "+mretry+ "  mref no hai " + mCustRefNo );
			isSavingsListUpdated = repo.updateSavingsErrorfromOmni(mCustRefNo, errorFromOmni, mretry);

		} catch (Exception e) {
			// logger.error("No Record Found."+e.getMessage());
			return isSavingsListUpdated;
		}
		return isSavingsListUpdated;
	}
	
	  @Transactional
	  
	  @Override 
	  public ResponseEntity<?> findByCreatedByAndLastSyncedTime(SavingsListEntity savingsListEntity)
	  { 
		  try {
	  List<SavingsListEntity> savingsList;
	  
	  //LocalDateTime lastSyncDateTime = lastSyncToTabService.getLastSyncTime(savingsListEntity.getMcreatedby(), 11);
	  if(savingsListEntity.getMlastsynsdate()==null) {
		  savingsList =repo.findByCreatedby(savingsListEntity.getMcreatedby()); 
	  }
	  else {
		  savingsList=repo.findByNotSynced(savingsListEntity.getMcreatedby());  
	  }  
	  
	  if(savingsList.isEmpty())
	return ResponseEntity.notFound().build(); 
	  return  new ResponseEntity<List<SavingsListEntity>>(savingsList,new HttpHeaders(),HttpStatus.OK); }catch(Exception e) {
	 // System.out.println("No Record Found. wasasas : "+e.getStackTrace());
	  //logger.error("No Record Found."+e.getMessage()); return new
		  return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY) ;}
	  
	  }
		
	 
	  
	  
	  
	  
	  @Transactional
		public int updateSavingsCustNo(int mcustmrefno, int mcustno) {
			System.out.println("Inside Update Savings List");
			int isSavingsListUpdated = 0;
			try {
				System.out.println("isSavingsListUpdated" + isSavingsListUpdated);
				isSavingsListUpdated = repo.updateSavingsListCustNo(mcustmrefno,mcustno);

			} catch (Exception e) {
				System.out.println("catch in updating ");
				// logger.error("No Record Found."+e.getMessage());
				return isSavingsListUpdated;
			}
			return isSavingsListUpdated;
		}
	  
	  
	  @Transactional
		public SavingsListEntity getSavAcctFromMrefno(int mrefno) {
			System.out.println("Inside Update Savings List");
			int isSavingsListUpdated = 0;
			SavingsListEntity returnList;
			try {
				System.out.println("isSavingsListUpdated" + isSavingsListUpdated);
				returnList = repo.getSavingListEntityByMrefno(mrefno);

			} catch (Exception e) {
				System.out.println("catch in updating ");
				// logger.error("No Record Found."+e.getMessage());
				return null;
			}
			return returnList;
		}
	  
	 
	  
	  
		@Transactional
		public int updateSavingsErrorfromOmniWithouLastSynsDate(int mCustRefNo, String errorFromOmni) {
			System.out.println("Meko Error :(");
			int isSavingsListUpdated = 0;
			try { 
				System.out.println("Try Me");
				isSavingsListUpdated = repo.updateSavingsErrorfromOmniWithoutlastSynsDate(mCustRefNo, errorFromOmni);

			} catch (Exception e) {
				// logger.error("No Record Found."+e.getMessage());
				return isSavingsListUpdated;
			}
			return isSavingsListUpdated;
		}
		
		
		@Transactional()
		public void updateSyncFromCore(List<Integer> mrefNoList){
			try {
				
				repo.updateSavingsSyncFromServer(mrefNoList);

			}
			catch(Exception e ) {
				
				
			}
		}

}
