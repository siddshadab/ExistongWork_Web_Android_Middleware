package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.SubDistrictsEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.AddressMasterHolder;
import com.infrasofttech.microfinance.repository.SubDistrictsRepository;
import com.infrasofttech.microfinance.services.SubDistrictsServices;


@Service
@Transactional
public class SubDistrictsServicesImpl implements SubDistrictsServices {	
	
	@Autowired
	SubDistrictsRepository repo;
	
	
	@Override
	public ResponseEntity<?> getSubDistricts() {
		try {
			List<SubDistrictsEntity> subDistrictList=repo.findAll();
			if(subDistrictList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<SubDistrictsEntity>>(subDistrictList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}


	@Override
	public ResponseEntity<?> addSubDist(SubDistrictsEntity subDistrictsEntity) {
		
		AddressMasterHolder hld = new AddressMasterHolder();
		try {
			
			
			SubDistrictsEntity subDist = repo.findByMplaceCd(subDistrictsEntity.getMplacecd());
			if(null == subDist) {
				repo.save(subDistrictsEntity);
				hld.setMerror(200);
				hld.setMerrormsg("Record Added Successfully");
				return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);
			}else {
				hld.setMerror(409);
				hld.setMerrormsg("Record Already Exists");
				return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return new ResponseEntity<>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}


	@Override
	public ResponseEntity<?> editSubDist(SubDistrictsEntity subDistrictsEntity) {
			try {
				AddressMasterHolder hld = new AddressMasterHolder();
				if(subDistrictsEntity != null) {			
						repo.save(subDistrictsEntity);
						hld.setMerror(200);
						hld.setMerrormsg("Record Updated Successfully");
						return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);
				}else {
					hld.setMerror(200);
					hld.setMerrormsg("Record Not Exists");
					return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return new ResponseEntity<>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
			}
	}


	@Override
	public ResponseEntity<?> deleteSubDist(AddressMasterHolder addressHolder) {
		try {
			AddressMasterHolder hld = new AddressMasterHolder();
			
			if(addressHolder!=null) {
				repo.bulkDelete(addressHolder.getMplacecd());
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
			return new ResponseEntity<>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}


	@Override
	public ResponseEntity<?> getAllSubDistricts(SubDistrictsEntity subDistrictsEntity) {
		try {
			List<SubDistrictsEntity> place = repo.findByMplaceCode(subDistrictsEntity.getMdistcd());			
			if(place.isEmpty())
				return ResponseEntity.notFound().build();
			return new ResponseEntity<Object> (place, new HttpHeaders(),HttpStatus.OK);
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
//			repo.bulkDelete(addressHolder.getMplacecd());
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
