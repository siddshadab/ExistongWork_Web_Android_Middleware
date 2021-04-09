package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.CountriesEntity;
import com.infrasofttech.microfinance.entityBeans.master.CentersFoundationEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.AddressMasterHolder;
import com.infrasofttech.microfinance.repository.CountriesRepository;
import com.infrasofttech.microfinance.services.CountriesServices;

@Service
@Transactional
public class CountriesServiceImpl implements CountriesServices{

	@Autowired
	CountriesRepository repo;
	
	@Transactional
	@Override
	public ResponseEntity<?> addCountries(CountriesEntity contries) {
		try {		
			AddressMasterHolder hld = new AddressMasterHolder();
			CountriesEntity country = repo.findCountry(contries.getMcountryid());
			if(country ==null) {
				repo.save(contries);
				hld.setMerror(200);
				hld.setMerrormsg("Record Added Successfully");
				return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);
			}else {
				hld.setMerror(409);
				hld.setMerrormsg("Record Already Exists");
				return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);
			}	
		
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Override
	public ResponseEntity<?> getCountries() {
		try {
			List<CountriesEntity> countryList=repo.findAll();
			if(countryList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CountriesEntity>>(countryList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
		
	}

	@Override
	public ResponseEntity<?> editCountries(CountriesEntity contries) {
		try {			
			AddressMasterHolder hld = new AddressMasterHolder();
			repo.save(contries);
			hld.setMerror(200);
			hld.setMerrormsg("Record Updated Successfully");			
			return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

//	@Override
//	public ResponseEntity<?> deleteCountries(CountriesEntity contries) {
//		try {	 
//		
//			AddressMasterHolder hld = new AddressMasterHolder();
//			repo.deleteCountries(contries.getMcountryid());
//			hld.setMerror(200);
//			hld.setMerrormsg("Record Deleted Successfully");
//			
//			return new ResponseEntity<Object>(contries,new HttpHeaders(),HttpStatus.OK);
//			
//		} catch (Exception e) {
//			//logger.error("Error While Persisting Object"+e.getMessage());
//			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
//		}
//	}

	@Override
	public ResponseEntity<?> bulkDelete(AddressMasterHolder addressMasterHolder) {
		
		try {
			AddressMasterHolder hld = new AddressMasterHolder();		
		
			repo.bulkDelete(addressMasterHolder.getMcountryid());			
			hld.setMerror(200);
			hld.setMerrormsg("Record Deleted Successfully");
			
			return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}	
	}
	
	
//	
//	  @Override public ResponseEntity<?> getCountries(String countryid) {
//		  try {
//			  List<CountriesEntity> dbEntity = repo.findByCountryID(countryid); 
//			  if(null == dbEntity) 
//				  return ResponseEntity.notFound().build(); 
//			  return new ResponseEntity<Object>(dbEntity,new HttpHeaders(),HttpStatus.OK);
//		  }catch(Exception e) { 
//			  //logger.error("No Record Found."+e.getMessage());
//			  return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY); 
//		  } 
//		 }
	 
	
	
	
	
}
