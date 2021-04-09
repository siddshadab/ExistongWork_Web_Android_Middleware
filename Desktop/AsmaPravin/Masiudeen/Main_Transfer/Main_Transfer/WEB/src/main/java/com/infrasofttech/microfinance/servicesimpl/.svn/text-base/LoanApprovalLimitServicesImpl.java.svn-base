package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.LoanApprovalLimitCompositeEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanApprovalLimitEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.LoanApprovalCompositeHolder;
import com.infrasofttech.microfinance.entityBeans.master.holder.LoanApprovalLimitHolder;
import com.infrasofttech.microfinance.repository.LoanApprovalLimitRepository;
import com.infrasofttech.microfinance.services.LoanApprovalLimitServices;

@Transactional
@Service
public class LoanApprovalLimitServicesImpl implements LoanApprovalLimitServices{

	@Autowired
	LoanApprovalLimitRepository repo;




	@Override
	public ResponseEntity<?> getAllLoanApprovalLimitData() {
		try {
			
			return new ResponseEntity<Object>("",new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	
	public ResponseEntity<?> getDataByMlbrCodeAndUSerCode(int lbrcd,String usercd,int mgrpcd){
		try {
			System.out.println(lbrcd);
			System.out.println(usercd);
			System.out.println(mgrpcd);
			List<LoanApprovalLimitEntity> dbEntity = repo.findByMlbrCodeAndUserCd(lbrcd,mgrpcd,usercd);
			
			System.out.println("Returning");
			if(null == dbEntity) {
				System.out.println("Null found in repository");
				return ResponseEntity.notFound().build();
				
			}
				
			System.out.println(dbEntity);
			return new ResponseEntity<Object>(dbEntity,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Transactional
	@Override
	public ResponseEntity<Object> getAllData() {
		try {			
		//List<LoanApprovalHolder> loanEnt =repo.findAllLoanLimit();
			List<LoanApprovalLimitEntity> loanEnt =repo.findAll();
			if(loanEnt.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<Object>(loanEnt,new HttpHeaders(),HttpStatus.OK);
			
		}catch(Exception e) {			
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}


	@Override
	public ResponseEntity<?> AddLoanLimit(LoanApprovalLimitHolder loanHolder) {
		LoanApprovalLimitEntity  loanEnt = repo.findByMlbrCodeAndUserCode(loanHolder.getMlbrcode(),loanHolder.getMgrpcd(),
				loanHolder.getMusercd(),loanHolder.getMsrno());
		try {
			
			if(loanEnt == null) {
				LoanApprovalLimitEntity loanEntity= new LoanApprovalLimitEntity();	
				
				LoanApprovalLimitCompositeEntity loanComposite = new LoanApprovalLimitCompositeEntity();
				
				loanComposite.setmgrpcd(loanHolder.getMgrpcd());
				loanComposite.setmsrno(loanHolder.getMsrno());
				loanComposite.setmlbrcode(loanHolder.getMlbrcode());
				loanComposite.setmusercd(loanHolder.getMusercd());
				
				loanEntity.setLoanApprovalLimitCompositeEntity(loanComposite);
				
				loanEntity.setMcheqlimitamt(loanHolder.getMcheqlimitamt());
				loanEntity.setMlastsynsdate(loanHolder.getMlastsynsdate());
				loanEntity.setMlimitamt(loanHolder.getMlimitamt());
				loanEntity.setMloanacmindrbal(loanHolder.getMloanacmindrbal());
				loanEntity.setMloanacmincrbal(loanHolder.getMloanacmincrbal());
				loanEntity.setMminintrate(loanHolder.getMminintrate());
				loanEntity.setMmaxintrate(loanHolder.getMmaxintrate());
				loanEntity.setMoverduedays(loanHolder.getMoverduedays());
				loanEntity.setMprdcd(loanHolder.getMprdcd());
				loanEntity.setMremarks(loanHolder.getMremarks());
				loanEntity.setMwriteoffamt(loanHolder.getMwriteoffamt());
				repo.save(loanEntity);
				loanHolder.setMerror(200);
				loanHolder.setMerrormsg("Record Saved Successfully.");
				return new ResponseEntity<Object>(loanHolder, new HttpHeaders(),HttpStatus.OK);
				
			}else {
				loanHolder.setMerror(200);
				loanHolder.setMerrormsg("Record Already Exists");
				return new ResponseEntity<Object>(loanHolder, new HttpHeaders(),HttpStatus.OK);
			}
			
		}catch(Exception e) {
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	@Override
	public ResponseEntity<?> updateLoanLimit(LoanApprovalLimitHolder loanHolder) {
			
	try {
				
					LoanApprovalLimitEntity loanEntity= new LoanApprovalLimitEntity();	
					
					LoanApprovalLimitCompositeEntity loanComposite = new LoanApprovalLimitCompositeEntity();
					
					loanComposite.setmgrpcd(loanHolder.getMgrpcd());
					loanComposite.setmsrno(loanHolder.getMsrno());
					loanComposite.setmlbrcode(loanHolder.getMlbrcode());
					loanComposite.setmusercd(loanHolder.getMusercd());
					
					loanEntity.setLoanApprovalLimitCompositeEntity(loanComposite);
					
					loanEntity.setMcheqlimitamt(loanHolder.getMcheqlimitamt());
					loanEntity.setMlastsynsdate(loanHolder.getMlastsynsdate());
					loanEntity.setMlimitamt(loanHolder.getMlimitamt());
					loanEntity.setMloanacmindrbal(loanHolder.getMloanacmindrbal());
					loanEntity.setMloanacmincrbal(loanHolder.getMloanacmincrbal());
					loanEntity.setMminintrate(loanHolder.getMminintrate());
					loanEntity.setMmaxintrate(loanHolder.getMmaxintrate());
					loanEntity.setMoverduedays(loanHolder.getMoverduedays());
					loanEntity.setMprdcd(loanHolder.getMprdcd());
					loanEntity.setMremarks(loanHolder.getMremarks());
					loanEntity.setMwriteoffamt(loanHolder.getMwriteoffamt());	
					repo.save(loanEntity);
					loanHolder.setMerror(200);
					loanHolder.setMerrormsg("Record Updated Successfully.");
					return new ResponseEntity<Object>(loanHolder, new HttpHeaders(),HttpStatus.OK);				
							
			}catch(Exception e) {
				return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
			}			
	}
	
	@Override
	public ResponseEntity<?> deleteLoanLimit(List<LoanApprovalLimitCompositeEntity> code) {
		try {
			LoanApprovalLimitHolder hld = new LoanApprovalLimitHolder();
			for(int i=0;i<code.size();i++) {
				repo.deleteByBulk(code.get(i).getmlbrcode(),code.get(i).getmgrpcd(),code.get(i).getmusercd(),code.get(i).getmsrno());	
				
			}			
			hld.setMerror(200);
			hld.setMerrormsg("Record Deleted Successfully");
			return new ResponseEntity<Object>(hld, new HttpHeaders(),HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
		//		LoanApprovalLimitEntity  loanEnt = repo.findByMlbrCodeAndUserCode(loanHolder.getMlbrcode(),loanHolder.getMgrpcd(),
//				loanHolder.getMusercd(),loanHolder.getMsrno());
		
//		try {
//			
//			
//				LoanApprovalLimitEntity loanEntity= new LoanApprovalLimitEntity();	
//				
//				LoanApprovalLimitCompositeEntity loanComposite = new LoanApprovalLimitCompositeEntity();
//				
//				loanComposite.setmgrpcd(loanHolder.getMgrpcd());
//				loanComposite.setmsrno(loanHolder.getMsrno());
//				loanComposite.setmlbrcode(loanHolder.getMlbrcode());
//				loanComposite.setmusercd(loanHolder.getMusercd());
//				
//				loanEntity.setLoanApprovalLimitCompositeEntity(loanComposite);
//				
//				loanEntity.setMcheqlimitamt(loanHolder.getMcheqlimitamt());
//				loanEntity.setMlastsynsdate(loanHolder.getMlastsynsdate());
//				loanEntity.setMlimitamt(loanHolder.getMlimitamt());
//				loanEntity.setMloanacmindrbal(loanHolder.getMloanacmindrbal());
//				loanEntity.setMloanacmincrbal(loanHolder.getMloanacmincrbal());
//				loanEntity.setMminintrate(loanHolder.getMminintrate());
//				loanEntity.setMmaxintrate(loanHolder.getMmaxintrate());
//				loanEntity.setMoverduedays(loanHolder.getMoverduedays());
//				loanEntity.setMprdcd(loanHolder.getMprdcd());
//				loanEntity.setMremarks(loanHolder.getMremarks());
//				loanEntity.setMwriteoffamt(loanHolder.getMwriteoffamt());			
//				loanHolder.setMerror(200);
//				loanHolder.setMerrormsg("Record Deleted Successfully.");
//			//	repo.deleteByBulk(loanHolder.getMulDelete());
//				//	repo.deleteByMlbrCodeAndUserCode(loanHolder.getMlbrcode(),loanHolder.getMgrpcd(),
//				//		loanHolder.getMusercd(),loanHolder.getMsrno());
//				
//				return new ResponseEntity<Object>(loanHolder, new HttpHeaders(),HttpStatus.OK);
//				
////			}else {
////				return new ResponseEntity<String>("Something is missing", new HttpHeaders(),HttpStatus.OK);
////			}
//			
//		}catch(Exception e) {
//			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
//		}
	
	}


	@Override
	public ResponseEntity<?> findRecByPrmKey(LoanApprovalLimitHolder loanHolder) {
		try {
			LoanApprovalLimitEntity loanEnt = repo.findByPrmKey(loanHolder.getMlbrcode(),loanHolder.getMgrpcd(),
					loanHolder.getMusercd(),loanHolder.getMsrno());
			
			if(loanEnt == null) {
				loanHolder.setMerror(0);
				loanHolder.setMerrormsg("null");
				return new ResponseEntity<Object>(loanHolder, new HttpHeaders(),HttpStatus.OK);
			}else{
				loanHolder.setMerror(200);
				loanHolder.setMerrormsg("Branch Code,Product Code and User Code Already Exists");
				return new ResponseEntity<Object>(loanHolder, new HttpHeaders(),HttpStatus.OK);
			}
							
//			return new ResponseEntity<Object>(new HttpHeaders(),HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
}
