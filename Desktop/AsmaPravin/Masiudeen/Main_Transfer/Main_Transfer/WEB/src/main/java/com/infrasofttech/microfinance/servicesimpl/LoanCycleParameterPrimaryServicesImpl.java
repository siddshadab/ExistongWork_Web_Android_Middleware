package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.CountriesEntity;
import com.infrasofttech.microfinance.entityBeans.master.InterestOffsetEntity;
import com.infrasofttech.microfinance.entityBeans.master.InterestSlabEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanCycleParameterPrimaryCompositeEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanCycleParameterPrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.LookupMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.LoanCyclePrimaryHolder;
import com.infrasofttech.microfinance.entityBeans.master.holder.LoanCyclePrimarySecondaryHolder;
import com.infrasofttech.microfinance.repository.InterestOffsetRepository;
import com.infrasofttech.microfinance.repository.InterestSlabRepository;
import com.infrasofttech.microfinance.repository.LoanCycleParameterPrimaryRepository;
import com.infrasofttech.microfinance.repository.LookupMasterRepository;
import com.infrasofttech.microfinance.services.InterestOffsetServices;
import com.infrasofttech.microfinance.services.InterestSlabServices;
import com.infrasofttech.microfinance.services.LoanCycleParameterPrimaryServices;
import com.infrasofttech.microfinance.services.LookupMasterServices;

@Transactional
@Service
public class LoanCycleParameterPrimaryServicesImpl implements LoanCycleParameterPrimaryServices{

	@Autowired
	LoanCycleParameterPrimaryRepository repo;

	


	@Override
	public ResponseEntity<?> getAllLoanCycleParameterPrimaryData() {
		try {
			List<LoanCycleParameterPrimaryEntity> dbEntity = repo.findAll(Sort.by(Sort.Direction.DESC,"mcreateddt"));
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
			List<LoanCycleParameterPrimaryEntity> dbEntity = repo.findByMlbrCode(lbrcd);
			if(null == dbEntity)
				return ResponseEntity.notFound().build();
			return new ResponseEntity<Object>(dbEntity,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Override
	public ResponseEntity<?> addLoanCycleData(LoanCyclePrimaryHolder loanCycleHolder) {
		try {
			LoanCycleParameterPrimaryEntity loanCycleEnt = repo.findLoanCycleData(loanCycleHolder.getMcusttype(),loanCycleHolder.getMeffdate(),loanCycleHolder.getMgrtype(),loanCycleHolder.getMlbrcode(),
					loanCycleHolder.getMloancycle(),loanCycleHolder.getMprdcd());
			
				LoanCycleParameterPrimaryEntity loanPrmEnt = new LoanCycleParameterPrimaryEntity();
				
				LoanCycleParameterPrimaryCompositeEntity loanPrmCompo = new LoanCycleParameterPrimaryCompositeEntity();
				
				if(loanCycleEnt == null) {
					loanPrmCompo.setmlbrcodecusttype(loanCycleHolder.getMcusttype());
					loanPrmCompo.setmeffdate(loanCycleHolder.getMeffdate());
					loanPrmCompo.setmgrtype(loanCycleHolder.getMgrtype());
					loanPrmCompo.setmlbrcode(loanCycleHolder.getMlbrcode());
					loanPrmCompo.setmloancycle(loanCycleHolder.getMloancycle());
					loanPrmCompo.setmprdcd(loanCycleHolder.getMprdcd());
					
					loanPrmEnt.setLoanCycleParameterPrimaryCompositeEntity(loanPrmCompo);
					loanPrmEnt.setMfrequency(loanCycleHolder.getMfrequency());
					loanPrmEnt.setMgender(loanCycleHolder.getMgender());
					loanPrmEnt.setMgrpcycyn(loanCycleHolder.getMgrpcycyn());
					loanPrmEnt.setMincramount(loanCycleHolder.getMincramount());
					loanPrmEnt.setMlogic(loanCycleHolder.getMlogic());
					loanPrmEnt.setMmaxage(loanCycleHolder.getMmaxage());
					loanPrmEnt.setMmaxamount(loanCycleHolder.getMmaxamount());
					loanPrmEnt.setMmaxnoofgrpmems(loanCycleHolder.getMmaxnoofgrpmems());
					loanPrmEnt.setMmaxperiod(loanCycleHolder.getMmaxperiod());
					loanPrmEnt.setMminage(loanCycleHolder.getMminage());				
					loanPrmEnt.setMminamount(loanCycleHolder.getMminamount());
					loanPrmEnt.setMminnoofgrpmems(loanCycleHolder.getMminnoofgrpmems());
					loanPrmEnt.setMminperiod(loanCycleHolder.getMminperiod());
					loanPrmEnt.setMmultiplefactor(loanCycleHolder.getMmultiplefactor());
					loanPrmEnt.setMnoofinstlclosure(loanCycleHolder.getMnoofinstlclosure());
					loanPrmEnt.setMtenor(loanCycleHolder.getMtenor());
					
					loanCycleHolder.setMerror(200);
					loanCycleHolder.setMerrormsg("Record Saved SuccessFully");
					
					 repo.save(loanPrmEnt);				 
					 return new ResponseEntity<Object>(loanPrmEnt,new HttpHeaders(),HttpStatus.OK);				
					
				}			
				else {
						loanCycleHolder.setMerror(200);
						loanCycleHolder.setMerrormsg("Record Already Exists");
					 return new ResponseEntity<Object>(loanPrmEnt,new HttpHeaders(),HttpStatus.OK);
				}
		} catch (Exception e) {			
			return new ResponseEntity<Object>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}	
	}

	@Override
	public ResponseEntity<?> updateLoanCycleData(LoanCyclePrimaryHolder loanCycleHolder) {

			try {

				
					LoanCycleParameterPrimaryEntity loanPrmEnt = new LoanCycleParameterPrimaryEntity();
					
					LoanCycleParameterPrimaryCompositeEntity loanPrmCompo = new LoanCycleParameterPrimaryCompositeEntity();
					
						loanPrmCompo.setmlbrcodecusttype(loanCycleHolder.getMcusttype());
						loanPrmCompo.setmeffdate(loanCycleHolder.getMeffdate());
						loanPrmCompo.setmgrtype(loanCycleHolder.getMgrtype());
						loanPrmCompo.setmlbrcode(loanCycleHolder.getMlbrcode());
						loanPrmCompo.setmloancycle(loanCycleHolder.getMloancycle());
						loanPrmCompo.setmprdcd(loanCycleHolder.getMprdcd());
						
						loanPrmEnt.setLoanCycleParameterPrimaryCompositeEntity(loanPrmCompo);
						loanPrmEnt.setMfrequency(loanCycleHolder.getMfrequency());
						loanPrmEnt.setMgender(loanCycleHolder.getMgender());
						loanPrmEnt.setMgrpcycyn(loanCycleHolder.getMgrpcycyn());
						loanPrmEnt.setMincramount(loanCycleHolder.getMincramount());
						loanPrmEnt.setMlogic(loanCycleHolder.getMlogic());
						loanPrmEnt.setMmaxage(loanCycleHolder.getMmaxage());
						loanPrmEnt.setMmaxamount(loanCycleHolder.getMmaxamount());
						loanPrmEnt.setMmaxnoofgrpmems(loanCycleHolder.getMmaxnoofgrpmems());
						loanPrmEnt.setMmaxperiod(loanCycleHolder.getMmaxperiod());
						loanPrmEnt.setMminage(loanCycleHolder.getMminage());				
						loanPrmEnt.setMminamount(loanCycleHolder.getMminamount());
						loanPrmEnt.setMminnoofgrpmems(loanCycleHolder.getMminnoofgrpmems());
						loanPrmEnt.setMminperiod(loanCycleHolder.getMminperiod());
						loanPrmEnt.setMmultiplefactor(loanCycleHolder.getMmultiplefactor());
						loanPrmEnt.setMnoofinstlclosure(loanCycleHolder.getMnoofinstlclosure());
						loanPrmEnt.setMtenor(loanCycleHolder.getMtenor());
						
						loanCycleHolder.setMerror(200);
						loanCycleHolder.setMerrormsg("Record Updated SuccessFully");

						repo.save(loanPrmEnt);				 
					    return new ResponseEntity<Object>(loanPrmEnt,new HttpHeaders(),HttpStatus.OK);				
						 
			} catch (Exception e) {
				e.printStackTrace();
				return new ResponseEntity<Object>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
			}	



	}

	@Override
	public ResponseEntity<?> deleteLoanCycleData(LoanCyclePrimaryHolder loanCycleHolder) {
		try {
			LoanCycleParameterPrimaryEntity loanCycleEnt = repo.findLoanCycleData(loanCycleHolder.getMcusttype(),loanCycleHolder.getMeffdate(),loanCycleHolder.getMgrtype(),loanCycleHolder.getMlbrcode(),
					loanCycleHolder.getMloancycle(),loanCycleHolder.getMprdcd());
			
				LoanCycleParameterPrimaryEntity loanPrmEnt = new LoanCycleParameterPrimaryEntity();
				
				LoanCycleParameterPrimaryCompositeEntity loanPrmCompo = new LoanCycleParameterPrimaryCompositeEntity();
				
				if(loanCycleEnt == null) {
					loanPrmCompo.setmlbrcodecusttype(loanCycleHolder.getMcusttype());
					loanPrmCompo.setmeffdate(loanCycleHolder.getMeffdate());
					loanPrmCompo.setmgrtype(loanCycleHolder.getMgrtype());
					loanPrmCompo.setmlbrcode(loanCycleHolder.getMlbrcode());
					loanPrmCompo.setmloancycle(loanCycleHolder.getMloancycle());
					loanPrmCompo.setmprdcd(loanCycleHolder.getMprdcd());
					
					loanPrmEnt.setLoanCycleParameterPrimaryCompositeEntity(loanPrmCompo);
					loanPrmEnt.setMfrequency(loanCycleHolder.getMfrequency());
					loanPrmEnt.setMgender(loanCycleHolder.getMgender());
					loanPrmEnt.setMgrpcycyn(loanCycleHolder.getMgrpcycyn());
					loanPrmEnt.setMincramount(loanCycleHolder.getMincramount());
					loanPrmEnt.setMlogic(loanCycleHolder.getMlogic());
					loanPrmEnt.setMmaxage(loanCycleHolder.getMmaxage());
					loanPrmEnt.setMmaxamount(loanCycleHolder.getMmaxamount());
					loanPrmEnt.setMmaxnoofgrpmems(loanCycleHolder.getMmaxnoofgrpmems());
					loanPrmEnt.setMmaxperiod(loanCycleHolder.getMmaxperiod());
					loanPrmEnt.setMminage(loanCycleHolder.getMminage());				
					loanPrmEnt.setMminamount(loanCycleHolder.getMminamount());
					loanPrmEnt.setMminnoofgrpmems(loanCycleHolder.getMminnoofgrpmems());
					loanPrmEnt.setMminperiod(loanCycleHolder.getMminperiod());
					loanPrmEnt.setMmultiplefactor(loanCycleHolder.getMmultiplefactor());
					loanPrmEnt.setMnoofinstlclosure(loanCycleHolder.getMnoofinstlclosure());
					loanPrmEnt.setMtenor(loanCycleHolder.getMtenor());
					
					loanCycleHolder.setMerror(200);
					loanCycleHolder.setMerrormsg("Record Deleted SuccessFully");

					 repo.deleteByLoanCycleData(loanCycleHolder.getMcusttype(),loanCycleHolder.getMeffdate(),loanCycleHolder.getMgrtype(),loanCycleHolder.getMlbrcode(),
								loanCycleHolder.getMloancycle(),loanCycleHolder.getMprdcd());
					 repo.deleteAllSecData(loanCycleHolder.getMcusttype(),loanCycleHolder.getMeffdate(),loanCycleHolder.getMgrtype(),loanCycleHolder.getMlbrcode(),
								loanCycleHolder.getMloancycle(),loanCycleHolder.getMprdcd());
					 return new ResponseEntity<Object>(loanPrmEnt,new HttpHeaders(),HttpStatus.OK);				
					
				}			
				else {
						loanCycleHolder.setMerror(409);
						loanCycleHolder.setMerrormsg("Record Not Exists");
						return new ResponseEntity<Object>(loanPrmEnt,new HttpHeaders(),HttpStatus.OK);
				}
		} catch (Exception e) {			
			return new ResponseEntity<Object>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}	


	}

	@Override
	public ResponseEntity<?> findByPrmKey(LoanCyclePrimaryHolder loanCycleHolder) {
		try {
			LoanCycleParameterPrimaryEntity loanCycleEnt = repo.findLoanCycleData(loanCycleHolder.getMcusttype(),loanCycleHolder.getMeffdate(),loanCycleHolder.getMgrtype(),loanCycleHolder.getMlbrcode(),
					loanCycleHolder.getMloancycle(),loanCycleHolder.getMprdcd());
			
			if(loanCycleEnt == null) {
				loanCycleHolder.setMerror(0);
				loanCycleHolder.setMerrormsg("null");
				return new ResponseEntity<Object>(loanCycleHolder,new HttpHeaders(),HttpStatus.OK);
			}else{
				loanCycleHolder.setMerror(200);
				loanCycleHolder.setMerrormsg("Customer Type,Effictive date,Group Type, Brnach Code,Loan Cycle and Product Code Already Exists");
				return new ResponseEntity<Object>(loanCycleHolder,new HttpHeaders(),HttpStatus.OK);
			   }
			}	
		 	catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity< >(new HttpHeaders(),HttpStatus.OK);
		}
	}
	
}
