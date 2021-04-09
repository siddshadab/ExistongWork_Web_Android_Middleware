package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.TDOffsetInterestSlabCompositeEntity;
import com.infrasofttech.microfinance.entityBeans.master.TDOffsetInterestSlabEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.TDOffsetInterstSlabHolder;
import com.infrasofttech.microfinance.repository.TDOffsetInterestSlabRepository;
import com.infrasofttech.microfinance.services.TDOffsetInterestSlabServices;

@Transactional
@Service
public class TDOffsetInterestSlabServicesImpl implements TDOffsetInterestSlabServices{

	@Autowired
	TDOffsetInterestSlabRepository repo;




	@Override
	public ResponseEntity<?> getAllTDOffsetInterestSlabData() {
		try {
			List<TDOffsetInterestSlabEntity> dbEntity = repo.findAll();
			if(null == dbEntity)
				return ResponseEntity.notFound().build();
			return new ResponseEntity<Object>(dbEntity,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}




	@Override
	public ResponseEntity<?> addTDOffsetInterest(TDOffsetInterstSlabHolder tdOffsetInterestHld) {
		try {
			TDOffsetInterestSlabEntity TDEntity = repo.findByPrmEntity(tdOffsetInterestHld.getMaccttype(),tdOffsetInterestHld.getMeffdate(),tdOffsetInterestHld.getMlbrcode(),tdOffsetInterestHld.getMprdcd(),tdOffsetInterestHld.getMsrno());
			
			TDOffsetInterestSlabEntity tdOffsetEntity = new TDOffsetInterestSlabEntity();
			TDOffsetInterestSlabCompositeEntity tdOffsetCompo = new TDOffsetInterestSlabCompositeEntity();
			
			if(TDEntity==null) {
				tdOffsetCompo.setmaccttype(tdOffsetInterestHld.getMaccttype());
				tdOffsetCompo.setmeffdate(tdOffsetInterestHld.getMeffdate());
				tdOffsetCompo.setmlbrcode(tdOffsetInterestHld.getMlbrcode());
				tdOffsetCompo.setmprdcd(tdOffsetInterestHld.getMprdcd());
				tdOffsetCompo.setmsrno(tdOffsetInterestHld.getMsrno());
				
				tdOffsetEntity.setTdOffsetInterestSlabCompositeEntity(tdOffsetCompo);
				tdOffsetEntity.setMcurcd(tdOffsetInterestHld.getMcurcd());
				tdOffsetEntity.setMdays(tdOffsetInterestHld.getMdays());
				tdOffsetEntity.setMmonths(tdOffsetInterestHld.getMmonths());
				tdOffsetEntity.setMinvamtfrm(tdOffsetInterestHld.getMinvamtfrm());
				tdOffsetEntity.setMuptoamt(tdOffsetInterestHld.getMuptoamt());
				tdOffsetEntity.setMlowertollimit(tdOffsetInterestHld.getMlowertollimit());
				tdOffsetEntity.setMuppertollimit(tdOffsetInterestHld.getMuppertollimit());
				tdOffsetEntity.setMoffsetintrate(tdOffsetInterestHld.getMoffsetintrate());
				
				tdOffsetInterestHld.setMerror(200);
				tdOffsetInterestHld.setMerrormsg("Record Added Successfully");
				repo.save(tdOffsetEntity);
				return new ResponseEntity<Object>(tdOffsetEntity,new HttpHeaders(),HttpStatus.OK); 
			}else {
				
				tdOffsetInterestHld.setMerror(200);
				tdOffsetInterestHld.setMerrormsg("Record Already Exists");		
				return new ResponseEntity<Object>(tdOffsetEntity,new HttpHeaders(),HttpStatus.OK);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<Object>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}	
		
	}




	@Override
	public ResponseEntity<?> updateTDOffsetInterest(TDOffsetInterstSlabHolder tdOffsetInterestHld) {
		try {
			//TDOffsetInterestSlabEntity TDEntity = repo.findByPrmEntity(tdOffsetInterestHld.getMaccttype(),tdOffsetInterestHld.getMeffdate(),tdOffsetInterestHld.getMlbrcode(),tdOffsetInterestHld.getMprdcd(),tdOffsetInterestHld.getMsrno());
			
			TDOffsetInterestSlabEntity tdOffsetEntity = new TDOffsetInterestSlabEntity();
			TDOffsetInterestSlabCompositeEntity tdOffsetCompo = new TDOffsetInterestSlabCompositeEntity();
			
				tdOffsetCompo.setmaccttype(tdOffsetInterestHld.getMaccttype());
				tdOffsetCompo.setmeffdate(tdOffsetInterestHld.getMeffdate());
				tdOffsetCompo.setmlbrcode(tdOffsetInterestHld.getMlbrcode());
				tdOffsetCompo.setmprdcd(tdOffsetInterestHld.getMprdcd());
				tdOffsetCompo.setmsrno(tdOffsetInterestHld.getMsrno());
				
				tdOffsetEntity.setTdOffsetInterestSlabCompositeEntity(tdOffsetCompo);
				tdOffsetEntity.setMcurcd(tdOffsetInterestHld.getMcurcd());
				tdOffsetEntity.setMdays(tdOffsetInterestHld.getMdays());
				tdOffsetEntity.setMmonths(tdOffsetInterestHld.getMmonths());
				tdOffsetEntity.setMinvamtfrm(tdOffsetInterestHld.getMinvamtfrm());
				tdOffsetEntity.setMuptoamt(tdOffsetInterestHld.getMuptoamt());
				tdOffsetEntity.setMlowertollimit(tdOffsetInterestHld.getMlowertollimit());
				tdOffsetEntity.setMuppertollimit(tdOffsetInterestHld.getMuppertollimit());
				tdOffsetEntity.setMoffsetintrate(tdOffsetInterestHld.getMoffsetintrate());
				
				tdOffsetInterestHld.setMerror(200);
				tdOffsetInterestHld.setMerrormsg("Record Updated Successfully");
				repo.save(tdOffsetEntity);
				return new ResponseEntity<Object>(tdOffsetEntity,new HttpHeaders(),HttpStatus.OK); 
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<Object>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}




	@Override
	public ResponseEntity<?> deleteTDOffsetInterest(TDOffsetInterstSlabHolder tdOffsetInterestHld) {
		try {
			//TDOffsetInterestSlabEntity TDEntity = repo.findByPrmEntity(tdOffsetInterestHld.getMaccttype(),tdOffsetInterestHld.getMeffdate(),tdOffsetInterestHld.getMlbrcode(),tdOffsetInterestHld.getMprdcd(),tdOffsetInterestHld.getMsrno());
			
			TDOffsetInterestSlabEntity tdOffsetEntity = new TDOffsetInterestSlabEntity();
			TDOffsetInterestSlabCompositeEntity tdOffsetCompo = new TDOffsetInterestSlabCompositeEntity();
			
				tdOffsetCompo.setmaccttype(tdOffsetInterestHld.getMaccttype());
				tdOffsetCompo.setmeffdate(tdOffsetInterestHld.getMeffdate());
				tdOffsetCompo.setmlbrcode(tdOffsetInterestHld.getMlbrcode());
				tdOffsetCompo.setmprdcd(tdOffsetInterestHld.getMprdcd());
				tdOffsetCompo.setmsrno(tdOffsetInterestHld.getMsrno());
				
				tdOffsetEntity.setTdOffsetInterestSlabCompositeEntity(tdOffsetCompo);
				tdOffsetEntity.setMcurcd(tdOffsetInterestHld.getMcurcd());
				tdOffsetEntity.setMdays(tdOffsetInterestHld.getMdays());
				tdOffsetEntity.setMmonths(tdOffsetInterestHld.getMmonths());
				tdOffsetEntity.setMinvamtfrm(tdOffsetInterestHld.getMinvamtfrm());
				tdOffsetEntity.setMuptoamt(tdOffsetInterestHld.getMuptoamt());
				tdOffsetEntity.setMlowertollimit(tdOffsetInterestHld.getMlowertollimit());
				tdOffsetEntity.setMuppertollimit(tdOffsetInterestHld.getMuppertollimit());
				tdOffsetEntity.setMoffsetintrate(tdOffsetInterestHld.getMoffsetintrate());
				
				tdOffsetInterestHld.setMerror(200);
				tdOffsetInterestHld.setMerrormsg("Record Deleted Successfully");
				
				repo.deleteByPrm(tdOffsetInterestHld.getMaccttype(),tdOffsetInterestHld.getMeffdate(),tdOffsetInterestHld.getMlbrcode(),tdOffsetInterestHld.getMprdcd(),tdOffsetInterestHld.getMsrno());
				return new ResponseEntity<Object>(tdOffsetEntity,new HttpHeaders(),HttpStatus.OK); 
			
		} catch (Exception e) {
		
			e.printStackTrace();
			return new ResponseEntity<Object>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}

		
	}
	
	
	
}
