package com.infrasofttech.microfinance.servicesimpl;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.LoanCycleParameterSecondaryCompositeEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanCycleParameterSecondaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.LoanCycleParameterSecondaryHolder;
import com.infrasofttech.microfinance.repository.LoanCycleParameterPrimaryRepository;
import com.infrasofttech.microfinance.repository.LoanCycleParameterSecondaryRepository;
import com.infrasofttech.microfinance.services.LoanCycleParameterSecondaryServices;


@Service
@Transactional
public class LoanCycleParameterSecondaryServicesImpl implements LoanCycleParameterSecondaryServices{

	@Autowired
	LoanCycleParameterPrimaryRepository prmRepo;
	
	@Autowired
	LoanCycleParameterSecondaryRepository repo;
	

	public static int msrno=0;


	@Override
	public ResponseEntity<?> getAllLoanCycleParameterSecondaryData() {
		try {
			List<LoanCycleParameterSecondaryEntity> dbEntity = repo.findAll();
			if(null == dbEntity)
				return ResponseEntity.notFound().build();
			return new ResponseEntity<Object>(dbEntity,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	
	public ResponseEntity<?> getDataByMlbrCode(int lbrcd){
		try {
			List<LoanCycleParameterSecondaryEntity> dbEntity = repo.findByMlbrCode(lbrcd);
			if(null == dbEntity)
				return ResponseEntity.notFound().build();
			return new ResponseEntity<Object>(dbEntity,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}


	@Override
	public ResponseEntity<?> addData(LoanCycleParameterSecondaryHolder loanCycleHolder) {
		try {
							
				LoanCycleParameterSecondaryEntity loanCycleSec = new LoanCycleParameterSecondaryEntity();
				LoanCycleParameterSecondaryCompositeEntity loanCycleSecCompo = new LoanCycleParameterSecondaryCompositeEntity();						
				
				List<LoanCycleParameterSecondaryEntity> loanSecEntity = repo.secLoan(
						loanCycleHolder.getMcusttype(), loanCycleHolder.getMeffdate(), 
						loanCycleHolder.getMgrtype(),loanCycleHolder.getMlbrcode(),loanCycleHolder.getMloancycle(),
						loanCycleHolder.getMprdcd());	
						
					
						loanCycleSecCompo.setmcusttype(loanCycleHolder.getMcusttype());
						loanCycleSecCompo.setmeffdate(loanCycleHolder.getMeffdate());
						loanCycleSecCompo.setmfrequency(loanCycleHolder.getMfrequency());
						loanCycleSecCompo.setmgrtype(loanCycleHolder.getMgrtype());
						loanCycleSecCompo.setmlbrcode(loanCycleHolder.getMlbrcode());
						loanCycleSecCompo.setmloancycle(loanCycleHolder.getMloancycle());
						loanCycleSecCompo.setmprdcd(loanCycleHolder.getMprdcd());
						loanCycleSecCompo.setmruletype(loanCycleHolder.getMruletype());
						loanCycleSecCompo.setmsrno(++msrno);
						
						loanCycleSec.setLoanCycleParameterSecondaryCompositeEntity(loanCycleSecCompo);
						
						loanCycleSec.setMuptoamount(loanCycleHolder.getMuptoamount());
						loanCycleSec.setMminamount(loanCycleHolder.getMminamount());
						loanCycleSec.setMmaxamount(loanCycleHolder.getMmaxamount());
						//loanCycleSec.setMlastsynsdate(loanCycleHolder.getMlastsynsdate());
						
						repo.save(loanCycleSec);
						//msrno=msrno+1;
						
					
					loanCycleHolder.setMerror(200);
					loanCycleHolder.setMerrormsg("Record Added Successfully");
					
					return new ResponseEntity<Object>(loanCycleHolder,new HttpHeaders(),HttpStatus.OK);

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return new ResponseEntity<>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
			}
							
	}


	@Override
	public ResponseEntity<?> editData(LoanCycleParameterSecondaryHolder loanCycleSecondaryHolder) {
		try {
			
			LoanCycleParameterSecondaryEntity loanCycleSec = new LoanCycleParameterSecondaryEntity();
			LoanCycleParameterSecondaryCompositeEntity loanCycleSecCompo = new LoanCycleParameterSecondaryCompositeEntity();
		
			loanCycleSecCompo.setmcusttype(loanCycleSecondaryHolder.getMcusttype());
			loanCycleSecCompo.setmeffdate(loanCycleSecondaryHolder.getMeffdate());
			loanCycleSecCompo.setmfrequency(loanCycleSecondaryHolder.getMfrequency());
			loanCycleSecCompo.setmgrtype(loanCycleSecondaryHolder.getMgrtype());
			loanCycleSecCompo.setmlbrcode(loanCycleSecondaryHolder.getMlbrcode());
			loanCycleSecCompo.setmloancycle(loanCycleSecondaryHolder.getMloancycle());
			loanCycleSecCompo.setmprdcd(loanCycleSecondaryHolder.getMprdcd());
			loanCycleSecCompo.setmruletype(loanCycleSecondaryHolder.getMruletype());
			loanCycleSecCompo.setmsrno(loanCycleSecondaryHolder.getMsrno());
			
			loanCycleSec.setLoanCycleParameterSecondaryCompositeEntity(loanCycleSecCompo);
			loanCycleSec.setMuptoamount(loanCycleSecondaryHolder.getMuptoamount());
			loanCycleSec.setMminamount(loanCycleSecondaryHolder.getMminamount());
			loanCycleSec.setMmaxamount(loanCycleSecondaryHolder.getMmaxamount());
			//loanCycleSec.setMlastsynsdate(loanCycleSecondaryHolder.getMlastsynsdate());
				
			loanCycleSecondaryHolder.setMerror(200);
			loanCycleSecondaryHolder.setMerrormsg("Record Updated Successfully");
				
			repo.save(loanCycleSec);
			return new ResponseEntity<Object>(loanCycleSec,new HttpHeaders(),HttpStatus.OK);			
				
		} catch (Exception e) {
			return new ResponseEntity<Object>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}


	@Override
	public ResponseEntity<?> editNewRecord(LoanCycleParameterSecondaryHolder loanCycleSecondaryHolder) {
	try {
			
			LoanCycleParameterSecondaryEntity loanCycleSec = new LoanCycleParameterSecondaryEntity();
			LoanCycleParameterSecondaryCompositeEntity loanCycleSecCompo = new LoanCycleParameterSecondaryCompositeEntity();
					
			List<LoanCycleParameterSecondaryEntity> loanSecEntity = repo.secLoan(
					loanCycleSecondaryHolder.getMcusttype(), loanCycleSecondaryHolder.getMeffdate(), 
					loanCycleSecondaryHolder.getMgrtype(),loanCycleSecondaryHolder.getMlbrcode(),loanCycleSecondaryHolder.getMloancycle(),
					loanCycleSecondaryHolder.getMprdcd());			
			
			int srno=loanSecEntity.get(loanSecEntity.size()-1).getLoanCycleParameterSecondaryCompositeEntity().getmsrno()+1;
			
					loanCycleSecCompo.setmcusttype(loanCycleSecondaryHolder.getMcusttype());
					loanCycleSecCompo.setmeffdate(loanCycleSecondaryHolder.getMeffdate());
					loanCycleSecCompo.setmfrequency(loanCycleSecondaryHolder.getMfrequency());
					loanCycleSecCompo.setmgrtype(loanCycleSecondaryHolder.getMgrtype());
					loanCycleSecCompo.setmlbrcode(loanCycleSecondaryHolder.getMlbrcode());
					loanCycleSecCompo.setmloancycle(loanCycleSecondaryHolder.getMloancycle());
					loanCycleSecCompo.setmprdcd(loanCycleSecondaryHolder.getMprdcd());
					loanCycleSecCompo.setmruletype(loanCycleSecondaryHolder.getMruletype());
					loanCycleSecCompo.setmsrno(srno+1);
					
					loanCycleSec.setLoanCycleParameterSecondaryCompositeEntity(loanCycleSecCompo);
					loanCycleSec.setMuptoamount(loanCycleSecondaryHolder.getMuptoamount());
					loanCycleSec.setMminamount(loanCycleSecondaryHolder.getMminamount());
					loanCycleSec.setMmaxamount(loanCycleSecondaryHolder.getMmaxamount());
					//loanCycleSec.setMlastsynsdate(loanCycleSecondaryHolder.getMlastsynsdate());
					
					loanCycleSecondaryHolder.setMerror(200);
					loanCycleSecondaryHolder.setMerrormsg("Record Updated Successfully");
				
					repo.save(loanCycleSec);
					return new ResponseEntity<Object>(loanCycleSec,new HttpHeaders(),HttpStatus.OK);			
				
		} catch (Exception e) {
			return new ResponseEntity<Object>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	
	
	
	@Override
	public ResponseEntity<?> deleteData(LoanCycleParameterSecondaryHolder loanCycleSecondaryHolder) {
		
		try {
			LoanCycleParameterSecondaryEntity loanCycleSec = new LoanCycleParameterSecondaryEntity();
			LoanCycleParameterSecondaryCompositeEntity loanCycleSecCompo = new LoanCycleParameterSecondaryCompositeEntity();
			if(loanCycleSecondaryHolder != null) {	
				
//										
//						loanCycleSecCompo.setmcusttype(loanCycleSecondaryHolder.getMcusttype());
//						loanCycleSecCompo.setmeffdate(loanCycleSecondaryHolder.getMeffdate());
//						loanCycleSecCompo.setmfrequency(loanCycleSecondaryHolder.getMfrequency());
//						loanCycleSecCompo.setmgrtype(loanCycleSecondaryHolder.getMgrtype());
//						loanCycleSecCompo.setmlbrcode(loanCycleSecondaryHolder.getMlbrcode());
//						loanCycleSecCompo.setmloancycle(loanCycleSecondaryHolder.getMloancycle());
//						loanCycleSecCompo.setmprdcd(loanCycleSecondaryHolder.getMprdcd());
//						loanCycleSecCompo.setmruletype(loanCycleSecondaryHolder.getMruletype());
//						loanCycleSecCompo.setmsrno(loanCycleSecondaryHolder.getMsrno());
//						
//						loanCycleSec.setLoanCycleParameterSecondaryCompositeEntity(loanCycleSecCompo);
//						loanCycleSec.setMuptoamount(loanCycleSecondaryHolder.getMuptoamount());
//						loanCycleSec.setMminamount(loanCycleSecondaryHolder.getMminamount());
//						loanCycleSec.setMmaxamount(loanCycleSecondaryHolder.getMmaxamount());
					//	loanCycleSec.setMlastsynsdate(loanCycleSecondaryHolder.getMlastsynsdate());
					
				
						repo.deleteSec(loanCycleSecondaryHolder.getMcusttype(), loanCycleSecondaryHolder.getMeffdate(),
								loanCycleSecondaryHolder.getMfrequency(),loanCycleSecondaryHolder.getMgrtype(),
								loanCycleSecondaryHolder.getMlbrcode(),loanCycleSecondaryHolder.getMloancycle(),
								loanCycleSecondaryHolder.getMprdcd(),loanCycleSecondaryHolder.getMruletype(),
								loanCycleSecondaryHolder.getMsrno());
				
				loanCycleSecondaryHolder.setMerror(200);
				loanCycleSecondaryHolder.setMerrormsg("Record Deleted Successfully");
				
				return new ResponseEntity<Object>(loanCycleSecondaryHolder,new HttpHeaders(),HttpStatus.OK);
			}
			else {
				 loanCycleSecondaryHolder.setMerror(409);
				loanCycleSecondaryHolder.setMerrormsg("Something went wrong");
				return new ResponseEntity<Object>(loanCycleSec,new HttpHeaders(),HttpStatus.OK);
			}
		} catch (Exception e) {
			return new ResponseEntity<Object>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}
	
	}


	@Override
	public ResponseEntity<?> findByPrmKey(LoanCycleParameterSecondaryHolder loanCycleSecHolder) {
		try {
			LoanCycleParameterSecondaryEntity loanSecEntity = repo.findByPrmEnt(
					loanCycleSecHolder.getMcusttype(), loanCycleSecHolder.getMeffdate(),loanCycleSecHolder.getMfrequency(), 
					loanCycleSecHolder.getMgrtype(),loanCycleSecHolder.getMlbrcode(),loanCycleSecHolder.getMloancycle(),
					loanCycleSecHolder.getMprdcd(),loanCycleSecHolder.getMruletype(),loanCycleSecHolder.getMsrno());
			
			if(loanSecEntity == null) {				
				loanCycleSecHolder.setMerror(0);
				loanCycleSecHolder.setMerrormsg("null");
				return new ResponseEntity<Object>(loanCycleSecHolder,new HttpHeaders(),HttpStatus.OK);
			}else {
				loanCycleSecHolder.setMerror(200);
				loanCycleSecHolder.setMerrormsg("Customer Type,Effective Date, Frequency,Group Type, Branch Code,Loan Cycle, Product Code, Rule Type and Serial Number Alrerady exists");
				return new ResponseEntity<Object>(loanCycleSecHolder,new HttpHeaders(),HttpStatus.OK);
			}			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<Object>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}


	@Override
	public ResponseEntity<?> getLoanCycleSecondary( LoanCycleParameterSecondaryHolder loanCycleSecondaryHolder) {
	
//		List<LoanCycleParameterSecondaryEntity> sec = repo.secondaryLoan(loanCycleSecondaryHolder.getMcusttype(),loanCycleSecondaryHolder.getMeffdate(), 
//				loanCycleSecondaryHolder.getMgrtype(),loanCycleSecondaryHolder.getMlbrcode(),
//				loanCycleSecondaryHolder.getMloancycle(),loanCycleSecondaryHolder.getMprdcd(),
//				loanCycleSecondaryHolder.getMfrequency(),loanCycleSecondaryHolder.getMruletype(),
//				loanCycleSecondaryHolder.getMsrno());	
		
		List<LoanCycleParameterSecondaryEntity> all = repo.secLoan(loanCycleSecondaryHolder.getMcusttype(),loanCycleSecondaryHolder.getMeffdate(), 
				loanCycleSecondaryHolder.getMgrtype(),loanCycleSecondaryHolder.getMlbrcode(),
				loanCycleSecondaryHolder.getMloancycle(),loanCycleSecondaryHolder.getMprdcd());
		
		System.out.println("secxxxxxxxxxxxx"+all.size());
		
		return new ResponseEntity<Object>(all,new HttpHeaders(),HttpStatus.OK);
	}


	
}
