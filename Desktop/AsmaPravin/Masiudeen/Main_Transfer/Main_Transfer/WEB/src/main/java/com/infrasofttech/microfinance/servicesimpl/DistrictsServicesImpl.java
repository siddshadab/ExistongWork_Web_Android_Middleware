package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.DistrictsEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.AddressMasterHolder;
import com.infrasofttech.microfinance.repository.DistrictsRepository;
import com.infrasofttech.microfinance.services.DistrictsServices;


@Service
@Transactional
public class DistrictsServicesImpl implements DistrictsServices {
	
	@Autowired
	DistrictsRepository repo;
	
	@Override
	public ResponseEntity<?> getDistricts() {
		try {
			List<DistrictsEntity> districtList=repo.findAll();
			if(districtList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<DistrictsEntity>>(districtList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}

	@Override
	public ResponseEntity<?> addDistricts(DistrictsEntity districtsEntity) {
		try {	
			DistrictsEntity dist = repo.findByMdistCd(districtsEntity.getMdistcd());
			AddressMasterHolder hld = new AddressMasterHolder();	
			if(dist ==  null) {
				repo.save(districtsEntity);
				hld.setMerror(200);
				hld.setMerrormsg("Record Added Successfully");
				return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);
			}else {
				//repo.save(districtsEntity);
				hld.setMerror(409);
				hld.setMerrormsg("Record Already Exists");
				return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);
			}
			
						
		}catch (Exception e) {	
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}	
	}

	@Override
	public ResponseEntity<?> editDistricts(DistrictsEntity districtsEntity) {
		try {	
			AddressMasterHolder hld = new AddressMasterHolder();			
			repo.save(districtsEntity);
			hld.setMerror(200);
			hld.setMerrormsg("Record Updated Successfully");
			return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);			
		}catch (Exception e) {	
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Override
	public ResponseEntity<?> deleteDistricts(AddressMasterHolder addressHolder) {
		try {
			AddressMasterHolder hld = new AddressMasterHolder();
			if(null!=addressHolder) {
							
				repo.deleteByMdistcd(addressHolder.getMdistcd());
				hld.setMerror(200);
				hld.setMerrormsg("Record Deleted Successfully");
				return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);
			}else {
				hld.setMerror(200);
				hld.setMerrormsg("Record Not Exists");
				return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

	}

	@Override
	public ResponseEntity<?> getAllDistricts(DistrictsEntity districtsEntity) {
	
		try {
			List<DistrictsEntity> allDistricts = repo.getAllDistricts(districtsEntity.getMstatecd());
			 
			if(allDistricts.isEmpty())
				ResponseEntity.notFound().build();
			return new ResponseEntity<Object>(allDistricts,new HttpHeaders(),HttpStatus.OK);	
			
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
//			repo.bulkDelete(addressHolder.getMdistcd());
//			hld.setMerror(200);
//			hld.setMerrormsg("Record Deleted Successfully");
//			
//			return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
//		}
//	}

}
