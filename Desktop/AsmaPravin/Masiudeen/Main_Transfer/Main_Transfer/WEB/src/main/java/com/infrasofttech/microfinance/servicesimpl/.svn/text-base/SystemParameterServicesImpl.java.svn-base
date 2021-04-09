package com.infrasofttech.microfinance.servicesimpl;

import java.time.LocalDateTime;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.SystemParameterCompositeEntity;
import com.infrasofttech.microfinance.entityBeans.master.SystemParameterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.SystemParameterHolder;
import com.infrasofttech.microfinance.repository.SystemParameterRepository;
import com.infrasofttech.microfinance.repository.SystemParameterRepository.SystemParamterHolder;
import com.infrasofttech.microfinance.services.SystemParameterServices;

@Transactional
@Service
public class SystemParameterServicesImpl implements SystemParameterServices{

	@Autowired
	SystemParameterRepository repo;
	
	@Override
	public ResponseEntity<?> getAllSystemParameterData() {
		try {
			List<SystemParameterEntity> dbEntity = repo.findAll(Sort.by(Sort.Direction.DESC,"mcreateddt"));
			//List<SystemParamterHolder> dbEntity = repo.getAll();
			if(null == dbEntity)
				return ResponseEntity.notFound().build();
			return new ResponseEntity<Object>(dbEntity,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Override
	public ResponseEntity<?> addList(SystemParameterEntity systemParameterEntity) {
		try {			
			//systemParameterEntity.setMcreatedby(systemParameterEntity.getMcreatedby());
			//systemParameterEntity.setMcreateddt(LocalDateTime.now());			
			repo.save(systemParameterEntity);
			return new ResponseEntity<Object> (systemParameterEntity,new HttpHeaders(),HttpStatus.CREATED); 
		}
		catch(Exception e){
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	
	
	public String getCodeDesc(String mcode) {
		String getCodeDesc =null;
		if(mcode !=null) {
			try {
			getCodeDesc= repo.findByCode(mcode).getMcodedesc();
			}catch(Exception e) {
				getCodeDesc=null;
				e.printStackTrace();
			}
		}
		return getCodeDesc;
	}
	
	
	
	public String getCodeValue(String mcode) {
		String getCodeValue =null;
		if(mcode !=null) {
			try {
				getCodeValue= repo.findByCode(mcode).getMcodevalue();
			}catch(Exception e) {
				getCodeValue=null;
				e.printStackTrace();
			}
		}
		return getCodeValue;
	}

	@Override
	public ResponseEntity<?> addSysParameter(SystemParameterHolder systemParamterHolder) {
		
		try {
			SystemParameterEntity systemParamEnt = repo.findByMcodeMlbrcode(systemParamterHolder.getMcode(),
								systemParamterHolder.getMlbrcode());
			
			SystemParameterEntity sysEnt = new SystemParameterEntity();
			SystemParameterCompositeEntity sysCompoEnt = new SystemParameterCompositeEntity();
			
			if(systemParamEnt == null) {

				sysCompoEnt.setmcode(systemParamterHolder.getMcode());
				sysCompoEnt.setmlbrcode(systemParamterHolder.getMlbrcode());				
				sysEnt.setSystemParameterCompositeEntity(sysCompoEnt);				
				sysEnt.setMcodedesc(systemParamterHolder.getMcodedesc());
				sysEnt.setMcodevalue(systemParamterHolder.getMcodevalue());
				sysEnt.setMcreatedby(systemParamterHolder.getMcreatedby());
				sysEnt.setMcreateddt(LocalDateTime.now());
				systemParamterHolder.setMerror(200);
				systemParamterHolder.setMerrormsg("Record Added successfully");
				
				repo.save(sysEnt);
				return new ResponseEntity<Object>(systemParamterHolder,new HttpHeaders(),HttpStatus.OK);
			}
			else {
				systemParamterHolder.setMerror(200);
				systemParamterHolder.setMerrormsg("Record Already Exists");
				return new ResponseEntity<Object>(systemParamterHolder,new HttpHeaders(),HttpStatus.CONFLICT);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<Object>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}

	@Override
	public ResponseEntity<?> editSysParameter(SystemParameterHolder systemParamterHolder) {
		
		try {
			
			
			SystemParameterEntity sysEnt = new SystemParameterEntity();
			SystemParameterCompositeEntity sysCompoEnt = new SystemParameterCompositeEntity();
			
			sysCompoEnt.setmcode(systemParamterHolder.getMcode());
			sysCompoEnt.setmlbrcode(systemParamterHolder.getMlbrcode());
			
			sysEnt.setSystemParameterCompositeEntity(sysCompoEnt);
			
			sysEnt.setMcodedesc(systemParamterHolder.getMcodedesc());
			sysEnt.setMcodevalue(systemParamterHolder.getMcodevalue());
			sysEnt.setMlastupdateby(systemParamterHolder.getMlastupdateby());
			sysEnt.setMlastupdatedt(LocalDateTime.now());
			systemParamterHolder.setMerror(200);
			systemParamterHolder.setMerrormsg("Record updated successfully");
			//repo.updateByMcodeMlbrcode(systemParamterHolder.getMcode(), systemParamterHolder.getMlbrcode());
			repo.save(sysEnt);
			return new ResponseEntity<Object>(systemParamterHolder,new HttpHeaders(),HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<Object>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}		
	}

	@Override
	public ResponseEntity<?> deleteSysParameter(List<SystemParameterHolder>  code) {

		try {
			SystemParameterHolder hld = new SystemParameterHolder();
			for(int i=0;i<code.size();i++) {
				repo.deleteByBulk(code.get(i).getMcode(),code.get(i).getMlbrcode());				
			}			
			hld.setMerror(200);
			hld.setMerrormsg("Record Deleted Successfully");
			return new ResponseEntity<Object>(hld, new HttpHeaders(),HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<Object>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
		
//		try {
//			SystemParameterEntity sysEnt = new SystemParameterEntity();
//			SystemParameterCompositeEntity sysCompoEnt = new SystemParameterCompositeEntity();
//			
//			sysCompoEnt.setmcode(systemParamterHolder.getMcode());
//			sysCompoEnt.setmlbrcode(systemParamterHolder.getMlbrcode());
//			
//			sysEnt.setSystemParameterCompositeEntity(sysCompoEnt);
//			
//			sysEnt.setMcodedesc(systemParamterHolder.getMcodedesc());
//			sysEnt.setMcodevalue(systemParamterHolder.getMcodevalue());
//			
//			systemParamterHolder.setMerror(200);
//			systemParamterHolder.setMerrormsg("Record Deleted successfully");
//			
//			repo.deleteByMcodeMlbrcode(systemParamterHolder.getMcode(),systemParamterHolder.getMlbrcode());
//			return new ResponseEntity<Object>(systemParamterHolder,new HttpHeaders(),HttpStatus.OK);
//		} catch (Exception e) {
//			e.printStackTrace();
//			return new ResponseEntity<Object>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
//		}
	}

	@Override
	public ResponseEntity<?> findByMcodeMlbrcd(SystemParameterHolder systemParamterHolder) {
		SystemParameterEntity systemEnt = repo.findByMcode(systemParamterHolder.getMcode(), systemParamterHolder.getMlbrcode());
		
		try {
			if(systemEnt == null) {
				systemParamterHolder.setMerror(0);			
				systemParamterHolder.setMerrormsg("null");
				return new ResponseEntity<Object>(systemParamterHolder,new HttpHeaders(),HttpStatus.OK);
			}
			else{
				systemParamterHolder.setMerror(200);			
				systemParamterHolder.setMerrormsg("Code and Branch Code Already Exists");
				return new ResponseEntity<Object>(systemParamterHolder,new HttpHeaders(),HttpStatus.OK);
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
}
