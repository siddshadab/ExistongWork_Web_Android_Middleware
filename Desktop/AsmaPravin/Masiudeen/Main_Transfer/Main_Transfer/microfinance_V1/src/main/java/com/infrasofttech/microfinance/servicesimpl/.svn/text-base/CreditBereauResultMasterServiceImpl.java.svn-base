package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CreditBereauResultMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerFamilyDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProspectCompositePrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProspectCreationEntity;
import com.infrasofttech.microfinance.repository.CreditBereauResultMasterRepository;
import com.infrasofttech.microfinance.repository.ProspectCreationRepository;
import com.infrasofttech.microfinance.services.CreditBereauResultMasterService;



@Service
@Transactional
public class CreditBereauResultMasterServiceImpl implements CreditBereauResultMasterService {

	@Autowired
	CreditBereauResultMasterRepository resultRepository;
	
	@Autowired
	ProspectCreationRepository prospectRepository;
	
	@Transactional
	@Override
	public ResponseEntity<?> getAllCreditBereauResultData() {
		 try {
		List<CreditBereauResultMasterEntity> prospectLoanList=resultRepository.findAll();
		if(prospectLoanList.isEmpty()) 
			return ResponseEntity.notFound().build();
		return new ResponseEntity<List<CreditBereauResultMasterEntity>>(prospectLoanList,new HttpHeaders(),HttpStatus.OK);
	}catch(Exception e) {
		//logger.error("No Record Found."+e.getMessage());
		return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
	}
	}

	@Transactional
	@Override
	public ResponseEntity<?> addList(List<CreditBereauResultMasterEntity> customer) {
try {	 
			
			return new ResponseEntity<Object>(resultRepository.saveAll(customer),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	/*
	 * @Transactional
	 * 
	 * @Override public ResponseEntity<?> getByAdhaarNoAndAgentUserName(long
	 * adhaarNo, String agentUserName) {
	 * 
	 * try { CreditBereauResultMasterEntity
	 * prospect=resultRepository.findByAdhaarNoAndAgentUserName(adhaarNo,
	 * agentUserName); if(prospect.equals(null)) return null; return new
	 * ResponseEntity<CreditBereauResultMasterEntity>(prospect,new
	 * HttpHeaders(),HttpStatus.OK); }catch(Exception e) {
	 * //logger.error("No Record Found."+e.getMessage()); return new
	 * ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY); } }
	 */
	/*
	 * @Transactional
	 * 
	 * @Override public ResponseEntity<?> getByRoutedTo(String agentUserName) { try
	 * { List<CreditBereauResultMasterEntity>
	 * prospect=resultRepository.findByRoutedTo(agentUserName);
	 * if(prospect.isEmpty()) return null; return new
	 * ResponseEntity<List<CreditBereauResultMasterEntity>>(prospect,new
	 * HttpHeaders(),HttpStatus.OK); }catch(Exception e) {
	 * //logger.error("No Record Found."+e.getMessage()); return new
	 * ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY); } }
	 */

	@Override
	public ResponseEntity<?> addResultDetails(@Valid CreditBereauResultMasterEntity entity,
			ProspectCompositePrimaryEntity prospectId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResponseEntity<?> getByAdhaarNoAndAgentUserName(long adhaarNo, String agentUserName) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResponseEntity<?> getByRoutedTo(String agentUserName) {
		// TODO Auto-generated method stub
		return null;
	}

	/*
	 * @Override public ResponseEntity<?> addResultDetails(@Valid
	 * CreditBereauResultMasterEntity entity, ProspectCompositePrimaryEntity
	 * prospectId) { // TODO Auto-generated method stub
	 * 
	 * ProspectCreationEntity prospectEntity = (ProspectCreationEntity)
	 * prospectRepository.findByCompositeProspectId(prospectId);
	 * 
	 * entity.setResultDetailsProspectEntity(prospectEntity);
	 * resultRepository.save(entity);
	 * 
	 * return new ResponseEntity<String>("200",new
	 * HttpHeaders(),HttpStatus.CREATED); }
	 */

	

}
