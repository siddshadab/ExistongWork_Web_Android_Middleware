package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.MenuMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserAccessRightsEntity;
import com.infrasofttech.microfinance.repository.MenuMasterRepository;
import com.infrasofttech.microfinance.services.MenuMasterService;



@Service
@Transactional
public class MenuMasterServiceImpl implements MenuMasterService {


	@Autowired
	MenuMasterRepository repo;


	@Transactional
	@Override
	public ResponseEntity<?> getAllMenusFromMasterData() {
		try {
			List<MenuMasterEntity> menuMasterEntity=repo.findAll();
			if(menuMasterEntity.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<MenuMasterEntity>>(menuMasterEntity,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}



	@Transactional
	@Override
	public List<MenuMasterEntity> getAllDataFroChartsMaster() {

		List<MenuMasterEntity> retEntityList = null;
		try {
			retEntityList = repo.findAll();

		}catch(Exception e) {
			retEntityList=null;
		}
		return retEntityList;

	}

}
