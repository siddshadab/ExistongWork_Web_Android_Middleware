package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.CountriesEntity;
import com.infrasofttech.microfinance.entityBeans.StatesEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.AddressMasterHolder;
import com.infrasofttech.microfinance.repository.CountriesRepository;
import com.infrasofttech.microfinance.repository.StatesRepository;
import com.infrasofttech.microfinance.services.StatesServices;

@Transactional
@Service
public class StatesServicesImpl implements StatesServices{

	
	@Autowired
	StatesRepository repo;
	
	
	@Override
	public ResponseEntity<?> getStates() {
		try {
			List<StatesEntity> stateList=repo.findAll();
			if(stateList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<StatesEntity>>(stateList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	//	return new ResponseEntity<Object>(repo.save(entity),new HttpHeaders(),HttpStatus.CREATED);
		
		
	}


	@Override
	public ResponseEntity<?> addStates(StatesEntity statesEntity) {
		AddressMasterHolder hld = new AddressMasterHolder();
		try {
			
			StatesEntity state = repo.findState(statesEntity.getMstatecd()); 
		if(null == state) {
				System.out.println("aaya idher");
				repo.save(statesEntity);
				hld.setMerror(200);
				hld.setMerrormsg("Record Added Successfully");
				return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);
			}else {
				hld.setMerror(409);
				hld.setMerrormsg("Record Already Exists");
				return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);
			}
		} catch (Exception e) {

			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}


	@Override
	public ResponseEntity<?> editStates(StatesEntity statesEntity) {
		try {
			AddressMasterHolder hld = new AddressMasterHolder();
		
			repo.save(statesEntity);
			hld.setMerror(200);
			hld.setMerrormsg("Record Updated Successfully");
			return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}	
	}


	@Override
	public ResponseEntity<?> deleteStates(AddressMasterHolder addressMasterHolder) {
		try {
			
			AddressMasterHolder hld = new AddressMasterHolder();
			repo.bulkDelete(addressMasterHolder.getMstatecd());
			
			hld.setMerror(200);
			hld.setMerrormsg("Record deleted Successfully");
			return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);			
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

	}


	@Override
	public ResponseEntity<?> getAllStates(StatesEntity statesEntity) {
		
		try {
			List<StatesEntity> states = repo.getAllState(statesEntity.getMcountryid());		

				if(states.isEmpty()) 
					ResponseEntity.notFound().build();
				return new ResponseEntity<Object>(states,new HttpHeaders(),HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	} 
 

//	@Override
//	public ResponseEntity<?> bulkDelete(AddressMasterHolder addressHolder) {
//		try {
//			AddressMasterHolder hld = new AddressMasterHolder();
//			repo.bulkDelete(addressHolder.getMstatecd());
//			hld.setMerror(200);
//			hld.setMerrormsg("Record Deleted Successfully");			
//			return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
//		}
//	}
	

}
