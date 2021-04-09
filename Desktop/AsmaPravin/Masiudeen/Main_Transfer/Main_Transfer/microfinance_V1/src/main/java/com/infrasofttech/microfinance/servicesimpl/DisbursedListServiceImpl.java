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

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.DisbursedListEntity;
import com.infrasofttech.microfinance.entityBeans.master.GroupsFoundationEntity;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.OmniDisbursedListAuthorizationServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.OmniDisbursedListServiceImpl;
import com.infrasofttech.microfinance.repository.DisbursedListRepository;
import com.infrasofttech.microfinance.services.DisbursedListService;

@Service
@Transactional
public class DisbursedListServiceImpl  implements DisbursedListService{

	@Autowired
	DisbursedListRepository disbRepo;
	@Autowired
	OmniDisbursedListServiceImpl omniDisbursedListServiceImpl;
	
	@Autowired
	OmniDisbursedListAuthorizationServiceImpl omniDisbursedAuthServiceImpl;
	
	@Override
	public ResponseEntity<?> getAllCustomerLoanData() {
		// TODO Auto-generated method stub
		return null;
	}

	
	@Override
	public ResponseEntity<List<DisbursedListEntity>> addList(List<DisbursedListEntity> disbursedList) {
//try {
			
			List<DisbursedListEntity> disbusedListEntity =new ArrayList<DisbursedListEntity>();
			for(DisbursedListEntity disbEntity: disbursedList ) {
				if(disbEntity.getMrefno()!=0) {
					
					DisbursedListEntity returnedEntity = findByMrefno(disbEntity.getMrefno());
					if(returnedEntity!=null&&returnedEntity.getMissynctocoresys()==1&&returnedEntity.getMdisbstatus()==disbEntity.getMdisbstatus()) {
					
						disbusedListEntity.add(returnedEntity);
						
					}else {
						
						System.out.println("ai Jagah p aya");
						disbusedListEntity.add(disbRepo.save(disbEntity));
					}
				}
				else {
					
					disbusedListEntity.add(disbRepo.save(disbEntity));
				}
				
				
			}
			
			
			System.out.println("Returned List from Srevice Impl "+ disbusedListEntity);
			

			return new ResponseEntity<List<DisbursedListEntity>>(disbusedListEntity,new HttpHeaders(),HttpStatus.CREATED);
		/*} catch (Exception e) {
			
		
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}	*/
		
	}

	@Override
	public ResponseEntity<?> findByCreatedByOrRouteTo(String mcreatedBy, LocalDateTime lastUpdateDt) {
		try {
			List<DisbursedListEntity> disbursedList;//=disbRepo.findByRouteAndMlastSynsDate(routeTo,lastUpdateDt);
			if(lastUpdateDt==null) {
				disbursedList=disbRepo.findByCreatedBy(mcreatedBy);
				
			}
			else {
				
				disbursedList=disbRepo.findByCratedByAndMlastSynsDate(mcreatedBy,lastUpdateDt);
			}
			
			if(disbursedList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<DisbursedListEntity>>(disbursedList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Override
	public ResponseEntity<?> findByCreatedByOrMrouteToAndLastSyncedTime(DisbursedListEntity disbursedEntity) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateErrorfromOmni(int mrefno, String errorFromOmni, int mRetry) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<DisbursedListEntity> isDataSynced(int isDataSynced, int disbursmentStatus) {
		List<DisbursedListEntity> disbList = new ArrayList<DisbursedListEntity>() ;
		try {

			System.out.println(isDataSynced);
			disbList=new ArrayList<DisbursedListEntity>();
			disbList = disbRepo.findByIsDataSynced(isDataSynced,disbursmentStatus);
			
			return disbList;


		}catch(Exception e) {
			e.printStackTrace();
		}

		return disbList ;
	}


	


	@Override
	public int updateStatus(List<DisbursedListEntity> disbursedList) {
		
		long start = System.nanoTime();
		try {
       int updatedStatus;
       System.out.println("Taking time for Update start " +start);
       if(disbursedList!=null) {
    	   for(DisbursedListEntity bean :disbursedList) {	
    		   
    		   System.out.println("Returned bean "+ bean);
    		   System.out.println("missyncto coresys is "+ bean.getMissynctocoresys());
				updatedStatus = disbRepo.updateStatus(bean.getMleadsid(),bean.getMissynctocoresys(),bean.getMerrormessage(),LocalDateTime.now());
		}
			long ends = System.nanoTime();
			System.out.println("Taking time for Update ends " +ends);
			
			long total = ends - start;
			
			System.out.println("Taking time for Update total " + total); 
       }
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}


	@Override
	public DisbursedListEntity finfByMleadsid(String mleadsid) {
		DisbursedListEntity disbursedEntity ;
		disbursedEntity = disbRepo.findByleadsId(mleadsid);
		return disbursedEntity;
	
	}
	
	
	
	
	
	
	public void synchronizeDisbursedListToOmni(List<DisbursedListEntity> listEntity) {
		System.out.println("Syncronize Disbursed");
		System.out.println("Disbursed list Size hai " + listEntity.size());
		if (listEntity != null && listEntity.size() > 0) {
			
			
			if(listEntity.size()==1&&listEntity.get(0).getMdisbstatus()==1) {
		 omniDisbursedListServiceImpl
						.omniSoapServicesDisbursedList(listEntity,false);
						
			}
			else {
				omniDisbursedAuthServiceImpl.omniSoapServicesDisbursedList(listEntity, false);
			}
			
				
				//updateStatus(listBean);
				
			
		}
	}


	@Override
	public DisbursedListEntity findByMrefno(int mrefno) {
		DisbursedListEntity disbursedEntity ;
		disbursedEntity = disbRepo.findByMrefNo(mrefno);
		return disbursedEntity;
	}
	
	@Override
	public int updateStatus(DisbursedListEntity disbursedBean) {
		try {
       int updatedStatus;
       if(disbursedBean!=null) {
    		   
				updatedStatus = disbRepo.updateStatus(disbursedBean.getMleadsid(),disbursedBean.getMissynctocoresys(),disbursedBean.getMerrormessage(),LocalDateTime.now());
		
		
       }
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	
	public int updateStatus(DisbursedListEntity disbursedBean , boolean updateflag) { 
		try { 
       int updatedStatus;
       if(disbursedBean!=null) {
    		   
				updatedStatus = disbRepo.updateStatusWithSetNo(disbursedBean.getMleadsid(),disbursedBean.getMissynctocoresys(),
						disbursedBean.getMerrormessage(),LocalDateTime.now(), disbursedBean.getMcurcd(),
						disbursedBean.getMbatchcd(),disbursedBean.getMsetno() );
		
		
       }
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	

}
