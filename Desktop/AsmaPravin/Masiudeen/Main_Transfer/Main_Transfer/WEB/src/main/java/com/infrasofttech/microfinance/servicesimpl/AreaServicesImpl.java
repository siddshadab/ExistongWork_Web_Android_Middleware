package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

import com.infrasofttech.microfinance.entityBeans.AreaCompositePrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.AreaEntity;
import com.infrasofttech.microfinance.entityBeans.CountriesEntity;
import com.infrasofttech.microfinance.entityBeans.DistrictsEntity;
import com.infrasofttech.microfinance.entityBeans.StatesEntity;
import com.infrasofttech.microfinance.entityBeans.SubDistrictsEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.AreaHolder;
import com.infrasofttech.microfinance.repository.AreaRepository;
import com.infrasofttech.microfinance.repository.CountriesRepository;
import com.infrasofttech.microfinance.repository.DistrictsRepository;
import com.infrasofttech.microfinance.repository.StatesRepository;
import com.infrasofttech.microfinance.repository.SubDistrictsRepository;
import com.infrasofttech.microfinance.services.AreaServices;
import com.infrasofttech.microfinance.services.DistrictsServices;
import com.infrasofttech.microfinance.services.SubDistrictsServices;


@Service
@Transactional
public class AreaServicesImpl implements AreaServices {	
	
	@Autowired
	AreaRepository repo;
	
	
	@Override
	public ResponseEntity<?> getArea() {
		try {
			List<AreaEntity> areaList=repo.findAll();
			if(areaList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<AreaEntity>>(areaList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Override
	public ResponseEntity<?> getArea(int lbrcd) {
		try {
			List<AreaEntity> areaList=repo.findByMpbrcd(lbrcd);
			if(areaList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<AreaEntity>>(areaList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Override
	public ResponseEntity<?> addArea(AreaHolder areaHolder) {
		
			try {
				AreaEntity areaEnt = repo.findByAreaPlcCd(areaHolder.getMareacd(),areaHolder.getMplacecd());
									
				if(areaEnt == null) {
					
					AreaEntity areaEntity = new AreaEntity();
					AreaCompositePrimaryEntity areaCompoEnt= new AreaCompositePrimaryEntity();
					
					areaCompoEnt.setMareacd(areaHolder.getMareacd());
					areaCompoEnt.setMplacecd(areaHolder.getMplacecd());
					
					areaEntity.setCompositeAreaId(areaCompoEnt);
					areaEntity.setMareadesc(areaHolder.getMareadesc());
					areaHolder.setMerror(200);
					areaHolder.setMerrormsg("Record Added Succesfully");
					
					repo.save(areaEntity);				
					return new ResponseEntity<Object>(areaEntity,new HttpHeaders(), HttpStatus.OK);
				}	
				else {				
					return new ResponseEntity<String>("Record Already Exists",new HttpHeaders(), HttpStatus.CONFLICT);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return new ResponseEntity<String>(new HttpHeaders(), HttpStatus.UNPROCESSABLE_ENTITY);
			}			
		} 
	
	@Override
	public ResponseEntity<?> editArea(AreaHolder areaHolder) {
	try {	
		AreaEntity areaEntity = new AreaEntity();
		AreaCompositePrimaryEntity areaCompoEnt= new AreaCompositePrimaryEntity();
		
		areaCompoEnt.setMareacd(areaHolder.getMareacd());
		areaCompoEnt.setMplacecd(areaHolder.getMplacecd());
		
		areaEntity.setCompositeAreaId(areaCompoEnt);
		areaEntity.setMareadesc(areaHolder.getMareadesc());
		areaHolder.setMerror(200);
		areaHolder.setMerrormsg("Record Updated Succesfully");
		
		repo.save(areaEntity);				
		return new ResponseEntity<Object>(areaEntity,new HttpHeaders(), HttpStatus.OK);
	
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		return new ResponseEntity<Object>(new HttpHeaders(), HttpStatus.UNPROCESSABLE_ENTITY);
	}	
}

	@Override
	public ResponseEntity<?> deleteArea(AreaHolder areaHolder) {
		try {	
			AreaEntity areaEntity = new AreaEntity();
			AreaCompositePrimaryEntity areaCompoEnt= new AreaCompositePrimaryEntity();
			
			areaCompoEnt.setMareacd(areaHolder.getMareacd());
			areaCompoEnt.setMplacecd(areaHolder.getMplacecd());
			
			areaEntity.setCompositeAreaId(areaCompoEnt);
			areaEntity.setMareadesc(areaHolder.getMareadesc());
			areaHolder.setMerror(200);
			areaHolder.setMerrormsg("Record Deleted Succesfully");
			
			repo.deleteAreaCd(areaHolder.getMareacd(), areaHolder.getMplacecd());				
			return new ResponseEntity<Object>(areaEntity,new HttpHeaders(), HttpStatus.OK);
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<Object>(new HttpHeaders(), HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
}
