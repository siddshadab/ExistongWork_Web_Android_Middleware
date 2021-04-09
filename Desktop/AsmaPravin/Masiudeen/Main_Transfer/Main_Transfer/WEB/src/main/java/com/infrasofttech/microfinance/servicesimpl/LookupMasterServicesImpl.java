package com.infrasofttech.microfinance.servicesimpl;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.LookupComposieEntity;
import com.infrasofttech.microfinance.entityBeans.master.LookupMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.LookupMasterEntityHolder;
import com.infrasofttech.microfinance.repository.LookupMasterRepository;
import com.infrasofttech.microfinance.services.LookupMasterServices;

@Transactional
@Service
public class LookupMasterServicesImpl implements LookupMasterServices{

	@Autowired
	LookupMasterRepository repo;
	
	@Override
	public ResponseEntity<?> getAllLookupData() {
		try {

			//List<LookupMasterEntity> dbEntity = repo.findAll();
			
			List <LookupMasterEntity> ent = repo.getSpecificLookup();
				
			HashMap<Integer ,List<LookupMasterEntity>> map = new HashMap<>();
			
			for(LookupMasterEntity e:ent) {
				if(!map.containsKey(e.getLookupComposite().getmcodetype())) {
					map.put(e.getLookupComposite().getmcodetype(), new ArrayList<>());
				}
				map.get(e.getLookupComposite().getmcodetype()).add(e);
			}
			if(null == ent)
				return ResponseEntity.notFound().build();
				return new ResponseEntity<Object>(map,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	/*
	 * @Override public ResponseEntity<?> addList(LookupComposieEntity
	 * lookupComposieEntity) { try { return new
	 * ResponseEntity<Object>(repo.save(lookupComposieEntity),new
	 * HttpHeaders(),HttpStatus.CREATED); } catch (Exception e) { return new
	 * ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY); } }
	 */
	
	@Transactional
	@Override
	public ResponseEntity<?> FindByMcodeType(LookupComposieEntity lookupComposieEntity) {
		
		 LookupMasterEntity lookupMasterEntity= null;
		try {			
					
			 List<LookupMasterEntity> listLookupMaster = null;	
			 
			 if(lookupComposieEntity!= null) {				   
				   
				 listLookupMaster =  repo.findByMcodeType(lookupComposieEntity.getmcodetype());		 
				 System.out.println("listLookupMaster"+listLookupMaster);		 			
			 }			 
			 if(listLookupMaster.isEmpty()) 
				 return ResponseEntity.notFound().build();				
			 	 return  new ResponseEntity<List<LookupMasterEntity>>(listLookupMaster,new HttpHeaders(),HttpStatus.OK);
			}
		catch(Exception e) {
		  		return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		 }	
	}

	@Override
	public ResponseEntity<?> addLookupEntity(LookupMasterEntityHolder lookupEntityHolder) {
		System.out.println(lookupEntityHolder);		
		try {			
			LookupMasterEntity lookupEnt = repo.findByMcode(lookupEntityHolder.getMcode(),lookupEntityHolder.getMcodetype());
			
			LookupMasterEntity lookupEntity = new LookupMasterEntity();
			LookupComposieEntity lookupCompositeEntity = new LookupComposieEntity();
			
			if (lookupEnt == null) {
				lookupCompositeEntity.setmcode(lookupEntityHolder.getMcode());
				lookupCompositeEntity.setmcodetype(lookupEntityHolder.getMcodetype());
				lookupEntity.setLookupComposite(lookupCompositeEntity);
				lookupEntity.setMcodedesc(lookupEntityHolder.getMcodedesc());
				lookupEntity.setMfield1value(lookupEntityHolder.getMfield1value());
				lookupEntity.setMcodedatatype(lookupEntityHolder.getMcodedatatype());
				lookupEntity.setMcodedatalen(lookupEntityHolder.getMcodedatalen());
				lookupEntity.setMlastsynsdate(lookupEntityHolder.getMlastsynsdate());
				lookupEntity.setMcreatedby(lookupEntityHolder.getMcreatedby());
				lookupEntity.setMcreateddt(LocalDateTime.now());
				lookupEntityHolder.setMerror(200);
				lookupEntityHolder.setMerrormsg("Record Saved Successfully");
				repo.save(lookupEntity);
				return new ResponseEntity<Object>(lookupEntityHolder, new HttpHeaders(), HttpStatus.CREATED);
			}
			else {
				lookupEntityHolder.setMerror(200);
				lookupEntityHolder.setMerrormsg("Record Already Exists");
				
				return new ResponseEntity<Object>(lookupEntityHolder, new HttpHeaders(), HttpStatus.CREATED);
			}
		  } catch (Exception e) {			
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}	
	}
	
	public ResponseEntity<?> updateLookupEntity(LookupMasterEntityHolder lookupEntityHolder) {
		System.out.println(lookupEntityHolder);		
		try {			
		
			
			LookupMasterEntity lookupEntity = new LookupMasterEntity();
			LookupComposieEntity lookupCompositeEntity = new LookupComposieEntity();
			
		
				lookupCompositeEntity.setmcode(lookupEntityHolder.getMcode());
				lookupCompositeEntity.setmcodetype(lookupEntityHolder.getMcodetype());
				lookupEntity.setLookupComposite(lookupCompositeEntity);
				lookupEntity.setMcodedesc(lookupEntityHolder.getMcodedesc());
				lookupEntity.setMfield1value(lookupEntityHolder.getMfield1value());
				lookupEntity.setMcodedatatype(lookupEntityHolder.getMcodedatatype());
				lookupEntity.setMcodedatalen(lookupEntityHolder.getMcodedatalen());
				lookupEntity.setMlastsynsdate(lookupEntityHolder.getMlastsynsdate());
				lookupEntity.setMlastupdateby(lookupEntityHolder.getMlastupdateby());
				lookupEntity.setMlastsynsdate(LocalDateTime.now());
				lookupEntityHolder.setMerror(200);
				lookupEntityHolder.setMerrormsg("Record Updated Successfully");
				repo.save(lookupEntity);
				return new ResponseEntity<Object>(lookupEntityHolder, new HttpHeaders(), HttpStatus.CREATED);	
				
		  } catch (Exception e) {			
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}	
	}

	public ResponseEntity<?> deleteLookupEntity(LookupMasterEntityHolder lookupEntityHolder) {
		

		try {	
			
//			LookupMasterEntity lookupEntity = new LookupMasterEntity();
//			LookupComposieEntity lookupCompositeEntity = new LookupComposieEntity();					
//			lookupCompositeEntity.setmcode(lookupEntityHolder.getMcode());
//			lookupCompositeEntity.setmcodetype(lookupEntityHolder.getMcodetype());
//			lookupEntity.setLookupComposite(lookupCompositeEntity);
//			lookupEntity.setMcodedesc(lookupEntityHolder.getMcodedesc());
//			lookupEntity.setMfield1value(lookupEntityHolder.getMfield1value());
//			lookupEntity.setMcodedatatype(lookupEntityHolder.getMcodedatatype());
//			lookupEntity.setMcodedatalen(lookupEntityHolder.getMcodedatalen());
//			lookupEntity.setMlastsynsdate(lookupEntityHolder.getMlastsynsdate());
			
			repo.deleteByMcode(lookupEntityHolder.getMcode(),lookupEntityHolder.getMcodetype());				
			lookupEntityHolder.setMerror(200);
			lookupEntityHolder.setMerrormsg("Record Deleted Successfully");				
			return new ResponseEntity<Object>(lookupEntityHolder, new HttpHeaders(), HttpStatus.OK);	
				
		  } catch (Exception e) {			
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}	
	}

	@Override
	public ResponseEntity<?> findAllLookup() {
	
		List<LookupMasterEntity> lookupEnt = repo.findAll(Sort.by(Sort.Direction.DESC,"mcreateddt"));
	
		try {
			if(lookupEnt.isEmpty())
				return ResponseEntity.notFound().build();
			return new ResponseEntity<Object> (lookupEnt,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {			
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Override
	public ResponseEntity<?> findByRecMCode(LookupMasterEntityHolder lookupHolder) {
		
		try {
		LookupMasterEntity lookupEnt = repo.findByMcode(lookupHolder.getMcode(),lookupHolder.getMcodetype());
	
		 
			if(lookupEnt ==null) {
				lookupHolder.setMerror(0);
				lookupHolder.setMerrormsg("null");
				return new ResponseEntity<Object> (lookupHolder,new HttpHeaders(),HttpStatus.OK);
			}else {
				lookupHolder.setMerror(200);
				lookupHolder.setMerrormsg("Code And Code Type Already Exists");
				return new ResponseEntity<Object> (lookupHolder,new HttpHeaders(),HttpStatus.OK);
			}
			
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Override
	public ResponseEntity<?> findByCode() {
		List<Object> mCode = repo.findByCode();
				return new ResponseEntity<Object> (mCode,new HttpHeaders(),HttpStatus.OK);
	}

	@Override
	public ResponseEntity<?> findByCodeType(LookupMasterEntityHolder lookupHolder) {
		List<LookupMasterEntity> mcodeType = repo.findByCodeType(lookupHolder.getMcodetype());
		return new ResponseEntity<Object> (mcodeType,new HttpHeaders(), HttpStatus.OK);
	}

	@Override
	public ResponseEntity<?> deleteByBulk(List<LookupMasterEntityHolder> code) {
		try {
		LookupMasterEntityHolder hld = new LookupMasterEntityHolder();
		for(int i=0;i<code.size();i++) {
			repo.deleteByBulk(code.get(i).getMcode(),code.get(i).getMcodetype());				
		}			
		hld.setMerror(200);
		hld.setMerrormsg("Record Deleted Successfully");
		return new ResponseEntity<Object>(hld, new HttpHeaders(),HttpStatus.OK);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
	}
	
	
	}
	
	
}
