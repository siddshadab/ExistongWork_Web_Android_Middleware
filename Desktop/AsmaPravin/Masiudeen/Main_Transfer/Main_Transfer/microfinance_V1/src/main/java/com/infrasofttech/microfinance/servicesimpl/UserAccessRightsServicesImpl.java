package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.UserAccessRightsEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.MenuAndAccessRightsHolderBean;
import com.infrasofttech.microfinance.repository.UserAccressRightsRepository;
import com.infrasofttech.microfinance.services.UserAccessRightsService;



@Service
@Transactional
public class UserAccessRightsServicesImpl implements UserAccessRightsService {


	@Autowired
	UserAccressRightsRepository repo;


	
	@Transactional
	@Override
	public ResponseEntity<?> getDataUserByMUserCode(String musrcode,int mgrpcd) {		
		try {
			List<UserAccessRightsEntity> userAccessRightsEntity=repo.findByMUserCode(musrcode,mgrpcd);
			if(userAccessRightsEntity.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<UserAccessRightsEntity>>(userAccessRightsEntity,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

	}
	/*
	 * 
	 * 
	 * @Transactional
	 * 
	 * @Override public List<UserAccessRightsEntity>
	 * getDataUserByMUserCodeFroChartsMaster(String musrcode,int mgrpcd) {
	 * List<UserAccessRightsEntity> retEntityList = null;
	 * 
	 * try { retEntityList = repo.findByMUserCode(musrcode,mgrpcd);
	 * 
	 * }catch(Exception e) { retEntityList=null; } return retEntityList; }
	 */
	
	
	@Transactional
	@Override
	public List<MenuAndAccessRightsHolderBean> getChartsIdOnMenuAndAccessJoin(String musrcode,int mgrpcd) {	
		List<MenuAndAccessRightsHolderBean> retEntityList = null;
		
		try {
			retEntityList = repo.getChartsIdOnMenuAndAccessJoin(musrcode,mgrpcd);
			
		}catch(Exception e) {
			retEntityList=null;
		}
		return retEntityList;
	}

}
