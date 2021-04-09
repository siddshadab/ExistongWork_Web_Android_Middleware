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
import com.infrasofttech.microfinance.entityBeans.master.SavingsCollectionListEntity;
import com.infrasofttech.microfinance.repository.SavingsCollectionListRepository;
import com.infrasofttech.microfinance.services.SavingsCollectionListServices;

@Transactional
@Service
public class SavingsCollectionListServicesImpl implements SavingsCollectionListServices{

	@Autowired
	SavingsCollectionListRepository repo;
	

	@Transactional
	@Override
	public ResponseEntity<?> addList(List<SavingsCollectionListEntity> svng) {

		try {

			return new ResponseEntity<Object>(repo.saveAll(svng), new HttpHeaders(), HttpStatus.CREATED);
		} catch (Exception e) {
			// logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

	}


	@Transactional
	@Override
	
	
	
	
	
	
	public List<SavingsCollectionListEntity> isDataSynced(int isDataSynced, int mmoduletype,String mcashflow) {
		System.out.println("Inside is Data Synced");
		List<SavingsCollectionListEntity> savingcollectionlist = null;
		try {
			// System.out.println(isDataSyncedToCoreSystem);
			savingcollectionlist = new ArrayList<SavingsCollectionListEntity>();
			System.out.println("savingcollectionlist" + savingcollectionlist);
			savingcollectionlist = repo.findDataByisDataSynced(isDataSynced,mmoduletype,mcashflow);
			System.out.println("savingcollectionlist1" + savingcollectionlist);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return savingcollectionlist;
	}

	public int updateSavingsCollectionList(int mrefno, LocalDateTime mentrydate, String mbatchcd, int msetno,int mscrollno) {
		System.out.println("Inside Update Show Savings List");
		int isSavingsCollectionListUpdated = 0;
		try {
			System.out.println("isSavingsCollectionListUpdated" + isSavingsCollectionListUpdated);
			isSavingsCollectionListUpdated = repo.updateSavingsCollectionList(mrefno, mentrydate, mbatchcd,msetno,mscrollno);

		} catch (Exception e) {
			System.out.println("dhsgfvccdcjdj");
			// logger.error("No Record Found."+e.getMessage());
			return isSavingsCollectionListUpdated;
		}
		return isSavingsCollectionListUpdated;
		
	}
	@Transactional
	@Override
	public int updateSavingsCollectionErrorfromOmni(int mCustRefNo, String errorFromOmni) {
		System.out.println("Meko Error :(");
		int isSavingsCollectionListUpdated = 0;
		try {
			System.out.println("Try Me");
			LocalDateTime updatedDt = LocalDateTime.now();
			isSavingsCollectionListUpdated = repo.updateSavingsCollectionErrorfromOmni(mCustRefNo, errorFromOmni, updatedDt);

		} catch (Exception e) {
			// logger.error("No Record Found."+e.getMessage());
			return isSavingsCollectionListUpdated;
		}
		return isSavingsCollectionListUpdated;
	}
	@Override
	public void updateStatus(List<SavingsCollectionListEntity> listBean) {
		//List<DailyLoanCollectedEntity> dailyLoanCollectedEntity = new ArrayList<DailyLoanCollectedEntity>() ;
		
		long start = System.nanoTime();
		try {
       int updatedStatus;
       System.out.println("Taking time for Update start " +start);
			for(SavingsCollectionListEntity bean :listBean) {		
				System.out.println("bean1234"+bean.getMissynctocoresys());
				
				updatedStatus = repo.updateStatus(bean.getMrefno(),bean.getMissynctocoresys(),bean.getMerrormessage(),LocalDateTime.now());
		}
			long ends = System.nanoTime();
			System.out.println("Taking time for Update ends " +ends);
			
			long total = ends - start;
			
			System.out.println("Taking time for Update total " + total);
			
		}catch(Exception e) {
			e.printStackTrace();
		}

		//return dailyLoanCollectedEntity ;
	}
	
	
	
	
	
	
	@Transactional
	@Override
	public int updateSavingsCollectionPrdAcctid(int msvngaccmrefno, String prdacctid) {
		System.out.println("Meko Error :(");
		int isSavingsCollectionListUpdated = 0;
		try {
			System.out.println("Try Me");
			LocalDateTime updatedDt = LocalDateTime.now();
			isSavingsCollectionListUpdated = repo.updateSavingsCollectionprdcctid(msvngaccmrefno, prdacctid);

		} catch (Exception e) {
			// logger.error("No Record Found."+e.getMessage());
			return isSavingsCollectionListUpdated;
		}
		return isSavingsCollectionListUpdated;
	}

	
}
