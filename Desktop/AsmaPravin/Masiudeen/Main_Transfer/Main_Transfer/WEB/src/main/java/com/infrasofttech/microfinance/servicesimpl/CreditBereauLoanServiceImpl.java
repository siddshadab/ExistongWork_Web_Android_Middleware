package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CreditBereauLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerFamilyDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProspectCompositeLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProspectCompositePrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProspectCompositePrimaryEntityAdhaar;
import com.infrasofttech.microfinance.entityBeans.master.ProspectCreationEntity;
import com.infrasofttech.microfinance.repository.CreditBereauLoanRepository;
import com.infrasofttech.microfinance.repository.CustomerLoanRepository;
import com.infrasofttech.microfinance.repository.ProspectCreationRepository;
import com.infrasofttech.microfinance.services.CreditBereauLoanService;


@Service
@Transactional
public class CreditBereauLoanServiceImpl implements CreditBereauLoanService {
	
	@Autowired
	CreditBereauLoanRepository prospectRepository;
	
	@Autowired
	ProspectCreationRepository prospectCreationRepository;

	@Transactional
	@Override
	public ResponseEntity<?> getByAdhaarNoAndAgentUserName(long adhaarNo, String agentUserName) {
		
		
		/*try {
			ProspectCompositeLoanEntity compositeprospectid = new ProspectCompositeLoanEntity(adhaarNo,agentUserName);
			List<CreditBereauLoanEntity> prospectLoanList=prospectRepository.findByCompositeProspectId(compositeprospectid);
			if(prospectLoanList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CreditBereauLoanEntity>>(prospectLoanList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}*/
		
		return null;
	}

	@Transactional
	@Override
	public ResponseEntity<?> getAllCreditBereauLoanData() {
		try {
			List<CreditBereauLoanEntity> prospectLoanList=prospectRepository.findAll();
			if(prospectLoanList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CreditBereauLoanEntity>>(prospectLoanList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	
	@Transactional
	@Override
	public ResponseEntity<?> addList(CreditBereauLoanEntity prospect) {
		System.out.println("sdsds"+prospect);
		 try {	 
		
		return new ResponseEntity<Object>(prospectRepository.save(prospect),new HttpHeaders(),HttpStatus.CREATED);
	} catch (Exception e) {
		//logger.error("Error While Persisting Object"+e.getMessage());
		return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
	}
	}

	@Override
	public ResponseEntity<?> addLoanDetails(@Valid List<CreditBereauLoanEntity> entity,
			ProspectCompositePrimaryEntity prospectId) {
		// TODO Auto-generated method stub
		return null;
		
		
			
			/*entity.setFamilyDetailsCustomerEntity(customerEntity);	
			customerFamilyDetailsRepository.save(entity);*/
			
	
	}

	

}
