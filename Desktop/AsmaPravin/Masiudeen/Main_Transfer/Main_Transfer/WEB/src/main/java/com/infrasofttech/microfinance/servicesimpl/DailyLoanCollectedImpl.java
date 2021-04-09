package com.infrasofttech.microfinance.servicesimpl;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.CountriesEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.DailyLoanCollectedEntity;
import com.infrasofttech.microfinance.entityBeans.master.DailyLoanCollectionEntity;
import com.infrasofttech.microfinance.entityBeans.master.LookupMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.SystemParameterEntity;
import com.infrasofttech.microfinance.repository.DailyLoanCollectedRepository;
import com.infrasofttech.microfinance.repository.DailyLoanCollectionRepository;
import com.infrasofttech.microfinance.repository.LookupMasterRepository;
import com.infrasofttech.microfinance.repository.SystemParameterRepository;
import com.infrasofttech.microfinance.services.DailyLoanCollectedServices;
import com.infrasofttech.microfinance.services.DailyLoanCollectionServices;
import com.infrasofttech.microfinance.services.LookupMasterServices;
import com.infrasofttech.microfinance.services.SystemParameterServices;

@Transactional
@Service
public class DailyLoanCollectedImpl implements DailyLoanCollectedServices {

	@Autowired
	DailyLoanCollectedRepository repo;


	@Override
	public ResponseEntity<?> addList(List<DailyLoanCollectedEntity> dailyLoanCollected) {
		List<DailyLoanCollectedEntity> dailyLoanCollectedFinalList = new ArrayList<DailyLoanCollectedEntity>();		
		try {	 
			LocalDateTime updatedDt = LocalDateTime.now();
			for(DailyLoanCollectedEntity collectdBean :dailyLoanCollected ) {				
				collectdBean.setMlastsynsdate(updatedDt);
				dailyLoanCollectedFinalList.add(collectdBean);
			}
			return new ResponseEntity<Object>(repo.saveAll(dailyLoanCollectedFinalList),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}



	//TODO call this in schedule services


	@Override
	public List<DailyLoanCollectedEntity> isDataSyncedToCoreSys(int isDataSynced) {
		List<DailyLoanCollectedEntity> dailyLoanCollectedEntity = new ArrayList<DailyLoanCollectedEntity>() ;
		try {

			System.out.println(isDataSynced);
			dailyLoanCollectedEntity=new ArrayList<DailyLoanCollectedEntity>();
			dailyLoanCollectedEntity = repo.findByIsDataSynced(isDataSynced);


		}catch(Exception e) {
			e.printStackTrace();
		}

		return dailyLoanCollectedEntity ;
	}

	
	@Override
	public void updateStatus(List<DailyLoanCollectedEntity> dailyLoanCollectedEntity) {
		//List<DailyLoanCollectedEntity> dailyLoanCollectedEntity = new ArrayList<DailyLoanCollectedEntity>() ;
		
		long start = System.nanoTime();
		try {
       int updatedStatus;
       System.out.println("Taking time for Update start " +start);
			for(DailyLoanCollectedEntity bean :dailyLoanCollectedEntity) {		
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


}
