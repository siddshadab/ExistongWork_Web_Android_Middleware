package com.infrasofttech.microfinance.servicesimpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.LoanCycleParameterPrimaryCompositeEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanCycleParameterPrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanCycleParameterSecondaryCompositeEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanCycleParameterSecondaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.LoanCyclePrimaryHolder;
import com.infrasofttech.microfinance.entityBeans.master.holder.LoanCyclePrimarySecondaryHolder;
import com.infrasofttech.microfinance.repository.LoanCycleParameterPrimaryRepository;
import com.infrasofttech.microfinance.repository.LoanCycleParameterPrimaryRepository.LoanCycleInterface;
import com.infrasofttech.microfinance.repository.LoanCycleParameterSecondaryRepository;
import com.infrasofttech.microfinance.services.LoanCyclePrimarySecondaryService;


@Transactional
@Service
public class LoanCyclePrimarySecondaryServiceImpl implements LoanCyclePrimarySecondaryService{

	@Autowired
	LoanCycleParameterPrimaryRepository primaryRepo;
	
	@Autowired
	LoanCycleParameterSecondaryRepository secRepo;
	
	
	
	
	@Override
	public ResponseEntity<?> getLoanCycle() {
		
		
		HashMap<LoanCycleParameterPrimaryEntity,List<LoanCyclePrimarySecondaryHolder>> map = new HashMap<>();
	
		List<LoanCycleParameterPrimaryEntity> primary = primaryRepo.findAll();
		
		List<LoanCycleInterface> prm = primaryRepo.primaryLoan();
		List<LoanCycleInterface> sec = primaryRepo.secondaryLoan();
		List<LoanCycleInterface> combo= primaryRepo.comboList();		
		List<LoanCyclePrimarySecondaryHolder> lis = new ArrayList<>();
	
			
//					List<LoanCycleInterface> li = primaryRepo.secondaryLoan(e.getMcusttype(),e.getMeffdate(),e.getMgrtype(),e.getMlbrcode(),e.getMloancycle(),e.getMprdcd());	

			
		
				
		return new ResponseEntity<Object> (sec,new HttpHeaders(),HttpStatus.OK);
		
	}
	
	
	
	
	@Override
	public ResponseEntity<?> addLoanCycle(LoanCyclePrimarySecondaryHolder loanCycleHolder) {
		
		try {
			System.out.println("Andar bhi aa gya");
			LoanCycleParameterPrimaryEntity loanCycleEnt = primaryRepo.findLoanCycleData(loanCycleHolder.getMcusttype(),loanCycleHolder.getMeffdate(),loanCycleHolder.getMgrtype(),loanCycleHolder.getMlbrcode(),
					loanCycleHolder.getMloancycle(),loanCycleHolder.getMprdcd());

				LoanCycleParameterPrimaryEntity loanPrmEnt = new LoanCycleParameterPrimaryEntity();
				
				LoanCycleParameterPrimaryCompositeEntity loanPrmCompo = new LoanCycleParameterPrimaryCompositeEntity();
				
				if(loanCycleEnt == null ) {
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
				
					
					//secodary
					List<LoanCycleParameterSecondaryEntity> loanSecEntity = secRepo.secLoan(
							loanCycleHolder.getMcusttype(), loanCycleHolder.getMeffdate(), 
							loanCycleHolder.getMgrtype(),loanCycleHolder.getMlbrcode(),loanCycleHolder.getMloancycle(),
							loanCycleHolder.getMprdcd());							
				
					LoanCycleParameterSecondaryEntity loanCycleSec = new LoanCycleParameterSecondaryEntity();
					LoanCycleParameterSecondaryCompositeEntity loanCycleSecCompo = new LoanCycleParameterSecondaryCompositeEntity();						
					
					loanCycleSecCompo.setmcusttype(loanCycleHolder.getMcusttype());
					loanCycleSecCompo.setmeffdate(loanCycleHolder.getMeffdate());
					loanCycleSecCompo.setmfrequency(loanCycleHolder.getMfrequency());
					loanCycleSecCompo.setmgrtype(loanCycleHolder.getMgrtype());
					loanCycleSecCompo.setmlbrcode(loanCycleHolder.getMlbrcode());
					loanCycleSecCompo.setmloancycle(loanCycleHolder.getMloancycle());
					loanCycleSecCompo.setmprdcd(loanCycleHolder.getMprdcd());
					loanCycleSecCompo.setmruletype(loanCycleHolder.getMruletype());
					loanCycleSecCompo.setmsrno(loanCycleHolder.getMsrno());
						
					loanCycleSec.setLoanCycleParameterSecondaryCompositeEntity(loanCycleSecCompo);
					loanCycleSec.setMuptoamount(loanCycleHolder.getMuptoamount());
					loanCycleSec.setMminamount(loanCycleHolder.getMminamount());
					loanCycleSec.setMmaxamount(loanCycleHolder.getMmaxamount());
					//loanCycleSec.setMlastsynsdate(loanCycleHolder.getMlastsynsdate());
					
					primaryRepo.save(loanPrmEnt);
					secRepo.save(loanCycleSec);					
						
					loanCycleHolder.setMerror(200);
					loanCycleHolder.setMerrormsg("Record Added Successfully");			
			
					return new ResponseEntity<Object>(loanCycleHolder,new HttpHeaders(),HttpStatus.OK);
				}else {
					loanCycleHolder.setMerror(200);
					loanCycleHolder.setMerrormsg("Record Already Exists");	
				    return new ResponseEntity<Object>(loanCycleHolder,new HttpHeaders(),HttpStatus.OK);
				}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}
			
	}

	@Override
	public ResponseEntity<?> editLoanCyclePrimary(LoanCyclePrimarySecondaryHolder loanCycleHolder) {
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
					primaryRepo.save(loanPrmEnt);
					loanCycleHolder.setMerror(200);
					loanCycleHolder.setMerrormsg("Record Updated Successfully");	
					return new ResponseEntity<Object>(loanCycleHolder,new HttpHeaders(),HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	

	@Override
	public ResponseEntity<?> editLoanCycleSecondary(LoanCyclePrimarySecondaryHolder loanCycleHolder) {

		List<LoanCycleParameterSecondaryEntity> loanSecEntity = secRepo.secLoan(
		loanCycleHolder.getMcusttype(), loanCycleHolder.getMeffdate(), 
		loanCycleHolder.getMgrtype(),loanCycleHolder.getMlbrcode(),loanCycleHolder.getMloancycle(),
		loanCycleHolder.getMprdcd());
		System.out.println("srno"+loanSecEntity.get(loanSecEntity.size()-1).getLoanCycleParameterSecondaryCompositeEntity().getmsrno());
		
		int srno=loanSecEntity.get(loanSecEntity.size()-1).getLoanCycleParameterSecondaryCompositeEntity().getmsrno();
		System.out.println("srno"+srno);
		
		
		
		try{
			LoanCycleParameterSecondaryEntity loanCycleSec = new LoanCycleParameterSecondaryEntity();
			LoanCycleParameterSecondaryCompositeEntity loanCycleSecCompo = new LoanCycleParameterSecondaryCompositeEntity();
			
			loanCycleSecCompo.setmcusttype(loanCycleHolder.getMcusttype());
			loanCycleSecCompo.setmeffdate(loanCycleHolder.getMeffdate());
			loanCycleSecCompo.setmfrequency(loanCycleHolder.getMfrequency());
			loanCycleSecCompo.setmgrtype(loanCycleHolder.getMgrtype());
			loanCycleSecCompo.setmlbrcode(loanCycleHolder.getMlbrcode());
			loanCycleSecCompo.setmloancycle(loanCycleHolder.getMloancycle());
			loanCycleSecCompo.setmprdcd(loanCycleHolder.getMprdcd());			
			loanCycleSecCompo.setmruletype(loanCycleHolder.getMruletype());
			loanCycleSecCompo.setmsrno(loanCycleHolder.getMsrno());
			
			loanCycleSec.setLoanCycleParameterSecondaryCompositeEntity(loanCycleSecCompo);
			loanCycleSec.setMuptoamount(loanCycleHolder.getMuptoamount());
			loanCycleSec.setMminamount(loanCycleHolder.getMminamount());
			loanCycleSec.setMmaxamount(loanCycleHolder.getMmaxamount());
									
			secRepo.save(loanCycleSec);			
			loanCycleHolder.setMerror(200);
			loanCycleHolder.setMerrormsg("Record Updated Successfully");	
		    return new ResponseEntity<Object>(loanCycleHolder,new HttpHeaders(),HttpStatus.OK);
	
		} catch (Exception e) {	
			e.printStackTrace();
			return new ResponseEntity<>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}
}
	
	
	
	
	
	
	
	
	
	
	
	
	

	@Override
	public ResponseEntity<?> deleteLoanCycle(List<LoanCyclePrimarySecondaryHolder> code) {
		//try {
			
			LoanCyclePrimarySecondaryHolder loanCycleHolder = new LoanCyclePrimarySecondaryHolder();
			System.out.println("size"+code.size());
				for(int i=0;i<code.size();i++) {				 
					
					primaryRepo.deleteByLoanCycleData(code.get(i).getMcusttype(),code.get(i).getMeffdate(),code.get(i).getMgrtype(),code.get(i).getMlbrcode(),code.get(i).getMloancycle(), code.get(i).getMprdcd());					

					secRepo.deleteByPrmEnt(code.get(i).getMcusttype(),code.get(i).getMeffdate(),code.get(i).getMgrtype(),code.get(i).getMlbrcode(),code.get(i).getMloancycle(),code.get(i).getMprdcd());
				}
				loanCycleHolder.setMerror(200);
				loanCycleHolder.setMerrormsg("Record Deleted Successfully");	
				return new ResponseEntity<Object> (loanCycleHolder,new HttpHeaders(), HttpStatus.OK);
								
				
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			return new ResponseEntity<> (new HttpHeaders(), HttpStatus.UNPROCESSABLE_ENTITY);
//		}
		
		
	}




	@Override
	public ResponseEntity<?> addLoanCycleSecondary(LoanCyclePrimarySecondaryHolder loanCycleHolder) {
		List<LoanCycleParameterSecondaryEntity> loanSecEntity = secRepo.secLoan(
				loanCycleHolder.getMcusttype(), loanCycleHolder.getMeffdate(), 
				loanCycleHolder.getMgrtype(),loanCycleHolder.getMlbrcode(),loanCycleHolder.getMloancycle(),
				loanCycleHolder.getMprdcd());
				System.out.println("srno"+loanSecEntity.get(loanSecEntity.size()-1).getLoanCycleParameterSecondaryCompositeEntity().getmsrno());
				
				int srno=loanSecEntity.get(loanSecEntity.size()-1).getLoanCycleParameterSecondaryCompositeEntity().getmsrno()+1;
				System.out.println("srno"+srno);
				
				
				
				try{
					LoanCycleParameterSecondaryEntity loanCycleSec = new LoanCycleParameterSecondaryEntity();
					LoanCycleParameterSecondaryCompositeEntity loanCycleSecCompo = new LoanCycleParameterSecondaryCompositeEntity();
					
					loanCycleSecCompo.setmcusttype(loanCycleHolder.getMcusttype());
					loanCycleSecCompo.setmeffdate(loanCycleHolder.getMeffdate());
					loanCycleSecCompo.setmfrequency(loanCycleHolder.getMfrequency());
					loanCycleSecCompo.setmgrtype(loanCycleHolder.getMgrtype());
					loanCycleSecCompo.setmlbrcode(loanCycleHolder.getMlbrcode());
					loanCycleSecCompo.setmloancycle(loanCycleHolder.getMloancycle());
					loanCycleSecCompo.setmprdcd(loanCycleHolder.getMprdcd());			
					loanCycleSecCompo.setmruletype(loanCycleHolder.getMruletype());
					loanCycleSecCompo.setmsrno(srno);
					
					loanCycleSec.setLoanCycleParameterSecondaryCompositeEntity(loanCycleSecCompo);
					loanCycleSec.setMuptoamount(loanCycleHolder.getMuptoamount());
					loanCycleSec.setMminamount(loanCycleHolder.getMminamount());
					loanCycleSec.setMmaxamount(loanCycleHolder.getMmaxamount());
											
					secRepo.save(loanCycleSec);			
					loanCycleHolder.setMerror(200);
					loanCycleHolder.setMerrormsg("Record Updated Successfully");	
				    return new ResponseEntity<Object>(loanCycleHolder,new HttpHeaders(),HttpStatus.OK);
			
				} catch (Exception e) {	
					e.printStackTrace();
					return new ResponseEntity<>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
				}
	}

	@Override
	public ResponseEntity<?> deleteLoanCycleData(LoanCyclePrimarySecondaryHolder loanCycle) {

		try {
			primaryRepo.deleteByLoanCycleData(loanCycle.getMcusttype(),loanCycle.getMeffdate(),
					loanCycle.getMgrtype(),loanCycle.getMlbrcode(),loanCycle.getMloancycle(), loanCycle.getMprdcd());					

			
			secRepo.deleteSecondary(loanCycle.getMcusttype(),loanCycle.getMeffdate(),
					loanCycle.getMgrtype(),loanCycle.getMlbrcode(),loanCycle.getMloancycle(),loanCycle.getMprdcd());
			
			loanCycle.setMerror(200);
			loanCycle.setMerrormsg("Record Deleted Successfully");	
			return new ResponseEntity<Object>(loanCycle,new HttpHeaders(),HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}





	

}
