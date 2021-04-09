package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.JsonMenuEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.JsonMenuMasterHolder;
import com.infrasofttech.microfinance.repository.JsonMenuRepository;
import com.infrasofttech.microfinance.services.JsonMasterService;

@Service
@Transactional
public class JsonMasterServiceImp implements JsonMasterService{

	@Autowired
	JsonMenuRepository repo;
	
	@Override
	public ResponseEntity<?> getMenuList(JsonMenuMasterHolder jsonMenu) {
		
		List<JsonMenuEntity> menuList = repo.getMenuList(jsonMenu.getMgrpcd());
		String menu = menuList.get(0).getMcachingvalue();
		menu.replaceAll("\n", "");
		
		System.out.println("menu :"+menu);
		return new ResponseEntity<Object>(menu,new HttpHeaders(),HttpStatus.OK);
	}


}
