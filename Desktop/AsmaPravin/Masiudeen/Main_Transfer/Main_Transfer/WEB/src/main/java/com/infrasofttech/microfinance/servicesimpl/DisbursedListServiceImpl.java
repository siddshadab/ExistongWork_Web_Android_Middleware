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
import com.infrasofttech.microfinance.entityBeans.master.DisbursedListEntity;
import com.infrasofttech.microfinance.repository.DisbursedListRepository;
import com.infrasofttech.microfinance.services.DisbursedListService;

@Service
@Transactional
public class DisbursedListServiceImpl  implements DisbursedListService{

	@Autowired
	DisbursedListRepository disbRepo;
	
	@Override
	public ResponseEntity<?> getAllCustomerLoanData() {
		// TODO Auto-generated method stub
		return null;
	}

	
	@Override
	public ResponseEntity<?> addList(List<DisbursedListEntity> disbursedList) {
//try {
			
			List<DisbursedListEntity> disbusedListEntity =new ArrayList<DisbursedListEntity>();
			/*for(CustomerLoanEntity bean: customerLoan) {

				if(bean.getMleadsid() == null || "".equals(bean.getMleadsid())) {
					System.out.println("getting Loan mrefno"+bean.getMrefno());
					CustomerLoanEntity customerLoanBean = loanRepository.findByMrefNo(bean.getMrefno());
					if(customerLoanBean!=null) {
						bean.setMlastupdatedt(customerLoanBean.getMlastupdatedt()); 
						System.out.println("getting leads is  "+customerLoanBean.getMleadsid());
						bean.setMleadsid(customerLoanBean.getMleadsid());
					}
				}else {
					bean.setMleadsid(bean.getMleadsid());
				}

				customerLoanAdd.add(bean);
			}*/
			
			

			return new ResponseEntity<Object>(disbRepo.saveAll(disbursedList),new HttpHeaders(),HttpStatus.CREATED);
		/*} catch (Exception e) {
			
		
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}	*/
		
	}

	@Override
	public ResponseEntity<?> findByCreatedByOrRouteTo(String createdby, String routeto) {
		// TODO Auto-generated method stub
		return null;
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

}
