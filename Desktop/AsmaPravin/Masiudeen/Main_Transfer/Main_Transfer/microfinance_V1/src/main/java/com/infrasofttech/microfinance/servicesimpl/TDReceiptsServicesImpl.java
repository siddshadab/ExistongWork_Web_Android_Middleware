package com.infrasofttech.microfinance.servicesimpl;

import java.time.LocalDateTime;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import com.infrasofttech.microfinance.repository.TDReceiptsRepository;
import com.infrasofttech.microfinance.schedular.ScheduledServicesToCoreSystem;
import com.infrasofttech.microfinance.services.TDReceiptsServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import javax.transaction.Transactional;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.TDReceiptsEntity;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.repository.TDReceiptsRepository;
import com.infrasofttech.microfinance.services.TDReceiptsServices;


@Service
@Transactional
public class TDReceiptsServicesImpl implements TDReceiptsServices {

	@Autowired
	TDReceiptsRepository repo;
	
	@Autowired
	ScheduledServicesToCoreSystem scheduleServices;

	@Transactional
	@Override
	public ResponseEntity<?> addList(List<TDReceiptsEntity> svng) {

		try {

			return new ResponseEntity<Object>(repo.saveAll(svng), new HttpHeaders(), HttpStatus.CREATED);
		} catch (Exception e) {
			// logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

	}

	@Transactional
	@Override
	public List<TDReceiptsEntity> isDataSynced(int isDataSynced) {
		System.out.println("Inside is Data Synced");
		List<TDReceiptsEntity> tdreceipts = null;
		try {
			// System.out.println(isDataSyncedToCoreSystem);
			tdreceipts = new ArrayList<TDReceiptsEntity>();
			System.out.println("tdreceipts" + tdreceipts);
			tdreceipts = repo.findDataByisDataSynced(isDataSynced);
			System.out.println("tdreceiptsq" + tdreceipts);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return tdreceipts;
	}

	@Transactional
	public int updateTDReceipts(int mrefno, String mprdaccid, double mmatval, int mreceiptstatus,String mbatchcd,int setno,int scrollno ) {
		System.out.println("Inside Update TDREceipts List");
		int isTDListUpdated = 0;
		try {
			System.out.println("isTDREceiptsListUpdated" + isTDListUpdated);
			isTDListUpdated = repo.updateTDReceipts(mrefno, mprdaccid, mmatval, mreceiptstatus,mbatchcd,setno,scrollno);

		} catch (Exception e) {
			System.out.println("dhsgfvccdcjdj");
			// logger.error("No Record Found."+e.getMessage());
			return isTDListUpdated;
		}
		return isTDListUpdated;
	}

	@Transactional
	@Override
	public int updateTDReceiptsErrorfromOmni(int mCustRefNo, String errorFromOmni) {
		System.out.println("Meko Error :(");
		int isTDListUpdated = 0;
		try {
			System.out.println("Try Me");
			LocalDateTime updatedDt = LocalDateTime.now();
			//isSavingsListUpdated = repo.updateSavingsErrorfromOmni(mCustRefNo, errorFromOmni, updatedDt);

		} catch (Exception e) {
			// logger.error("No Record Found."+e.getMessage());
			return isTDListUpdated;
		}
		return isTDListUpdated;
	}
	
	  @Transactional
	  
	  @Override 
	  public ResponseEntity<?> findByCreatedByAndLastSyncedTime(TDReceiptsEntity tdListEntity) { try {
	  List<TDReceiptsEntity> tdList;
	  if(tdListEntity.getMlastsynsdate()==null ) {
		  tdList =repo.findByCreatedby(tdListEntity.getMcreatedby()); 
		  }
	  else {
		  tdList=repo.findByCreatedbyAndDateTime(tdListEntity.getMcreatedby()
	  , tdListEntity.getMlastsynsdate()); }
	  //manipulateSavingsEntity(savingsList);
	  
	  
	  if(tdList.isEmpty()) return ResponseEntity.notFound().build(); 
	  return
	  new ResponseEntity<List<TDReceiptsEntity>>(tdList,new
	  HttpHeaders(),HttpStatus.OK); }catch(Exception e) {
	 // System.out.println("No Record Found. wasasas : "+e.getStackTrace());
	  //logger.error("No Record Found."+e.getMessage()); return new
		  return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY) ;}
	  
	  }
	
	  
	  
	  public void  synchronizeTDToOmni(TDReceiptsEntity entity) {
			System.out.println("synchronize TD ToOmni");   
			
			if(entity!=null) {    		
				try { 	

					scheduleServices.synchronizeSingleTDReceiptsToOmni(entity);    				

				}catch(Exception e) {
					e.printStackTrace();
				}


			}


		}  
	  
	  
	  
	  
	  
	  
	  

}
