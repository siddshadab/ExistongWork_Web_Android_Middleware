package com.infrasofttech.microfinance.servicesimpl;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.DeviationFormEntity;
import com.infrasofttech.microfinance.entityBeans.master.GuarantorEntity;
import com.infrasofttech.microfinance.repository.GuarantorRepository;
import com.infrasofttech.microfinance.services.GuarantorServices;

@Service
@Transactional
public class GuarantorServicesImpl implements GuarantorServices {

	@Autowired
	GuarantorRepository grntrrepo;

//	@Transactional
//	@Override
//	public ResponseEntity<?> addList(List<GuarantorEntity> grntr) {
//
//		System.out.println("grntr::::::::::::::::::::::::::"+grntr.toString());
//		for(GuarantorEntity obj : grntr){
//			System.out.println("grntr::::::::::::::::::::::::::"+obj.getMrefno());
//			System.out.println("grntr::::::::::::::::::::::::::"+obj.getTrefno());
//			}
//		
//
//			return new ResponseEntity<Object>(grntrrepo.saveAll(grntr), new HttpHeaders(), HttpStatus.CREATED);
//	
//
//	}
	
	@Transactional
	@Override
		public ResponseEntity<?> addList(List<GuarantorEntity> group) {

		try {
			return new ResponseEntity<Object>(grntrrepo.saveAll(group),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	@Transactional
	@Override
	public List<GuarantorEntity> findDataByMloanRefoJoin(BigDecimal mloanmrefno) {
		System.out.println("Inside is Data Synced");
		List<GuarantorEntity> resultList = null;
		try {
			resultList = new ArrayList<GuarantorEntity>();
			resultList = grntrrepo.findDataByMloanRefoJoin(mloanmrefno);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultList;
	}
	
	
	@Transactional
	@Override
	public List<BigDecimal> isDataSynced(int dataSync) {
		System.out.println("Inside is Data Synced");
		List<BigDecimal> resultList = null;
		try {
			resultList = new ArrayList<BigDecimal>();
			resultList = grntrrepo.findDataByisDataSynced(dataSync);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultList;
	}
	
	@Transactional
	public int updateStatus(int mloanmrefno) {
		int isUpdated = 0;
		try {
			System.out.println("isUpdated" + isUpdated);
			isUpdated = grntrrepo.updateStatus(mloanmrefno);

		} catch (Exception e) {
			return isUpdated;
		}
		return isUpdated;
	}
	
	@Transactional
	public int updateErrorStatus(int mloanmrefno) {
		int isUpdated = 0;
		try {
			System.out.println("isUpdated" + isUpdated);
			isUpdated = grntrrepo.updateErrorStatus(mloanmrefno);

		} catch (Exception e) {
			return isUpdated;
		}
		return isUpdated;
	}
	
	@Override
	public void updateMleadsIdfromMrefTref(String mleadsid, int mloanmrefno, int mloantrefno) {
		try {
			grntrrepo.updateLeadsIdFromLoanMrefTref(mleadsid, mloanmrefno, mloantrefno,LocalDateTime.now());
			System.out.print("Updated Guarantor for leads id "+mleadsid+mloanmrefno+mloantrefno );
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Transactional
	public int updateStatusAndLeadid(int mloanmrefno ,String mleadsid) {
		System.out.println("updateStatusAndLeadid guarantor :" + mloanmrefno +"::"+ mleadsid );
		int isUpdated = 0;
		try {
			System.out.println("isUpdated" + isUpdated);
			isUpdated = grntrrepo.updateStatusAndLeadid(mloanmrefno,mleadsid);

		} catch (Exception e) {
			return isUpdated;
		}
		return isUpdated;
	}

	@Override
	public ResponseEntity<?> findByCreatedByAndLastSyncedTime(GuarantorEntity guarantorEntity) {
		try{
			  List<GuarantorEntity>guarantorList;
			 
			  
			  if(guarantorEntity.getMlastsynsdate()==null ) {
				  
				  guarantorList =grntrrepo.findByCreatedby(guarantorEntity.getMcreatedby());
				  System.out.println("mcreatedby"+guarantorList);
				  
				  }
			  else {
				  
				  guarantorList=grntrrepo.findByCreatedbyAndDateTime(guarantorEntity.getMcreatedby(), guarantorEntity.getMlastsynsdate());
				  System.out.println("mcreatedby and last"+guarantorList);
			  	}
			  	//manipulateSavingsEntity(savingsList);
	  
	  
	  if(guarantorList.isEmpty())	    
		  return ResponseEntity.notFound().build(); 
	      return  new ResponseEntity<List<GuarantorEntity>>(guarantorList,new HttpHeaders(),HttpStatus.OK);	      
	    }
		 catch(Exception e) {
	 
		  return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY) ;
		  }	
	
	}

//	@Override
//	public ResponseEntity<?> add1List(GuarantorEntity grntr) {
//		try {
//			return new ResponseEntity<Object>(grntrrepo.save(grntr), new HttpHeaders(), HttpStatus.CREATED);
//		} catch (Exception e) {
//			// logger.error("Error While Persisting Object"+e.getMessage());
//			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
//		}
//	}

}
